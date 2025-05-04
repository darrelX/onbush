import 'package:onbush/data/models/reminder/reminder_model.dart';

abstract class ReminderLocalDataSource {
  // This class is responsible for managing local data related to reminders.
  // It interacts with the local database or storage to perform CRUD operations.

  // Example method to fetch reminders from local storage
  Future<List<ReminderModel>> fetchReminders();
  // Logic to fetch reminders from local storage

  // Logic to save a reminder to local storage
  Future<void> saveReminder(ReminderModel reminder);


  // Logic to delete a reminder from local storage
  Future<void> deleteReminder(String id);
}
