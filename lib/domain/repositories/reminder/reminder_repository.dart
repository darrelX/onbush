import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/domain/entities/reminder/reminder_entity.dart';

abstract class ReminderRepository {
  // This class is responsible for managing local data related to reminders.
  // It interacts with the local database or storage to perform CRUD operations.

  // Example method to fetch reminders from local storage
  Future<Either<DatabaseException ,List<ReminderEntity>>> fetchReminders();
  // Logic to fetch reminders from local storage

  // Logic to save a reminder to local storage
  Future<Either<DatabaseException, void>> saveReminder(ReminderEntity reminder);


  // Logic to delete a reminder from local storage
  Future<Either<DatabaseException, void>> deleteReminder(String id);
}