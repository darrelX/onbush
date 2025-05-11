import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
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
        print("Permission 'SCHEDULE_EXACT_ALARM' non accordée");
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

      final notificationsPerDay = (reminder.frequencyPerWeek! / 7).ceil();

      for (int i = 0; i < reminder.preferredTimes.length; i++) {
        if (i >= notificationsPerDay) break;

        final time = reminder.preferredTimes[i];
        final today = DateTime.now();

        final scheduledDate = DateTime(
          today.year,
          today.month,
          today.day,
          time.hour,
          time.minute,
        );

        final tzDateTime = tz.TZDateTime.from(scheduledDate, tz.local);

        final notificationId = '${reminder.id}-$i'.hashCode;
        print("manouchou Notification ID: $notificationId");
        print("manouchou Scheduled Date: $scheduledDate");

        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          'Rappel',
          'C’est le moment de votre rappel.',
          tzDateTime.isBefore(tz.TZDateTime.now(tz.local))
              ? tzDateTime.add(const Duration(days: 1))
              : tzDateTime,
          notificationDetails,
          matchDateTimeComponents: DateTimeComponents.time,
          androidScheduleMode: AndroidScheduleMode.exact,
        );
        print("manouchou Scheduled Date: $scheduledDate");
      }
    } catch (e) {
      print("Erreur dans scheduleReminder: ${e.toString()}");
      rethrow;
    }
  }

// Future<void> cancelReminder(ReminderEntity reminder) async {
//   for (int i = 0; i < reminder.preferredTimes.length; i++) {
//     await flutterLocalNotificationsPlugin.cancel('${reminder.id}-$i'.hashCode);
//   }
// }
  Future<void> cancelAllReminders() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<bool> isExactAlarmPermissionGranted() async {
    if (!Platform.isAndroid) return true; // Pas concerné sur iOS

    const methodChannel = MethodChannel('check_exact_alarm');

    try {
      final bool isGranted =
          await methodChannel.invokeMethod('isExactAlarmAllowed') ?? false;

      if (isGranted) {
        print("[ExactAlarm] Permission accordée.");
        return true;
      }

      print(
          "[ExactAlarm] Permission non accordée. Redirection vers les paramètres...");

      // Rediriger l'utilisateur vers les paramètres de permission d'alarmes exactes
      const intent = AndroidIntent(
        action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
        data: 'package:com.example.onbush',
      );
      await intent.launch();

      return false;
    } on PlatformException catch (e) {
      print(
          "[ExactAlarm] Erreur lors de la vérification de la permission : $e");
      return false;
    } on MissingPluginException {
      print("[ExactAlarm] Méthode native non implémentée.");
      return false;
    } catch (e) {
      print("[ExactAlarm] Erreur inattendue : $e");
      return false;
    }
  }

  
}
