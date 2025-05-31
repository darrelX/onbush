import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:onbush/domain/entities/reminder/reminder_entity.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tzData;

class ReminderNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ReminderNotificationService();

  Future<void> init() async {
    tzData.initializeTimeZones();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleReminder(ReminderEntity reminder) async {
    try {
      final isAllowed = await isExactAlarmPermissionGranted();
      if (!isAllowed) {
        return;
      }

      const androidDetails = AndroidNotificationDetails(
        'reminder_channel',
        'Reminders',
        channelDescription: 'Channel for reminder notifications',
        importance: Importance.max,
        priority: Priority.high,
      );

      const notificationDetails = NotificationDetails(android: androidDetails);

      final now = DateTime.now();
      final tzNow = tz.TZDateTime.now(tz.local);

      final totalNotifications = reminder.frequencyPerWeek ?? 0;
      final notificationsPerDay = (totalNotifications / 7).ceil();

      // On s'assure qu'il y a au moins une heure préférée
      if (reminder.preferredTimes.isEmpty) {
        return;
      }

      // Générer les horaires à utiliser : on répète si besoin
      final expandedTimes = List.generate(
        notificationsPerDay,
        (i) => reminder.preferredTimes[i % reminder.preferredTimes.length],
      );

      for (int i = 0; i < expandedTimes.length; i++) {
        final time = expandedTimes[i];

        final scheduledDate = DateTime(
          now.year,
          now.month,
          now.day,
          time.hour,
          time.minute,
        );

        var tzDateTime = tz.TZDateTime.from(scheduledDate, tz.local);

        // Si l'heure est déjà passée aujourd'hui, planifier pour demain
        if (tzDateTime.isBefore(tzNow)) {
          tzDateTime = tzDateTime.add(const Duration(days: 1));
        }

        final notificationId = '${reminder.id}-$i'.hashCode;

        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          'Rappel',
          'C’est le moment de votre rappel.',
          tzDateTime,
          notificationDetails,
          matchDateTimeComponents: DateTimeComponents.time,
          androidScheduleMode: AndroidScheduleMode.exact,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> cancelAllReminders() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<bool> isExactAlarmPermissionGranted() async {
    if (!Platform.isAndroid) return true;

    const methodChannel = MethodChannel('check_exact_alarm');

    try {
      final bool isGranted =
          await methodChannel.invokeMethod('isExactAlarmAllowed') ?? false;

      if (isGranted) {
        return true;
      }

      print(
          "[ExactAlarm] Permission non accordée. Redirection vers les paramètres...");

      // Appel de la fonction séparée
      // await redirectToExactAlarmPermissionSettings();

      return false;
    } on PlatformException catch (e) {
      print(
          "[ExactAlarm] Erreur lors de la vérification de la permission : $e");
      return false;
    } on MissingPluginException {
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Fonction utilitaire séparée pour ouvrir les paramètres de permission d'alarmes exactes
  Future<void> redirectToExactAlarmPermissionSettings() async {
    const intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
      data: 'package:com.example.onbush', // À remplacer si nécessaire
    );
    await intent.launch();
  }
}
