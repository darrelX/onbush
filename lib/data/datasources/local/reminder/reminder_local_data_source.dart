import 'dart:convert';

import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/data/datasources/local/reminder/reminder_local_data_source_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onbush/data/models/reminder/reminder_model.dart';

class ReminderLocalDataSourceImpl implements ReminderLocalDataSource {
  static const String _remindersKey = 'REMINDERS_KEY';

  final LocalStorage _localStorage;

  ReminderLocalDataSourceImpl(this._localStorage);

  @override
  Future<List<ReminderModel>> fetchReminders() async {
    try {
      final jsonString = _localStorage.getString(_remindersKey);
      if (jsonString != null) {
        final List decodedList = json.decode(jsonString);
        return decodedList
            .map((jsonItem) => ReminderModel.fromJson(jsonItem))
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching reminders: $e");
      rethrow;
    }
  }

  @override
  Future<void> saveReminder(ReminderModel reminder) async {
    try {
      final reminders = await fetchReminders();
      // Remove existing reminder with same id if exists (to update)
      reminders.removeWhere((r) => r.id == reminder.id);
      reminders.add(reminder);

      final encodedList = reminders.map((r) => r.toJson()).toList();
      final jsonString = json.encode(encodedList);
      await _localStorage.setString(_remindersKey, jsonString);
    } catch (e) {
      print("Error saving reminder: $e");
      rethrow;
    }
  }

  @override
  Future<void> deleteReminder(String id) async {
    try {
      final reminders = await fetchReminders();
      reminders.removeWhere((r) => r.id == id);

      final encodedList = reminders.map((r) => r.toJson()).toList();
      final jsonString = json.encode(encodedList);
      await _localStorage.setString(_remindersKey, jsonString);
    } catch (e) {
      print("Error deleting reminder: $e");
      rethrow;
    }
  }
}
