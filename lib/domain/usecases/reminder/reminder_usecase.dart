import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/domain/entities/reminder/reminder_entity.dart';
import 'package:onbush/domain/repositories/reminder/reminder_repository.dart';

class ReminderUseCase {
  final ReminderRepository _reminderRepository;
  ReminderUseCase(this._reminderRepository);

  // Example method to fetch reminders from local storage
  Future<Either<DatabaseException, List<ReminderEntity>>>
      fetchReminders() async {
    return _reminderRepository.fetchReminders();
  }
  // Logic to fetch reminders from local storage

  // Logic to save a reminder to local storage
  Future<Either<DatabaseException, void>> saveReminder(
      ReminderEntity reminder) async {
    return _reminderRepository.saveReminder(reminder);
  }

  // Logic to delete a reminder from local storage
  Future<Either<DatabaseException, void>> deleteReminder(String id) async {
    return _reminderRepository.deleteReminder(id);
  }
}
