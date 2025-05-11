import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/data/datasources/local/reminder/reminder_local_data_source_impl.dart';
import 'package:onbush/domain/entities/reminder/reminder_entity.dart';
import 'package:onbush/domain/repositories/reminder/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  final ReminderLocalDataSource _reminderLocalDataSource;

  ReminderRepositoryImpl(this._reminderLocalDataSource);
  // This class is responsible for managing local data related to reminders.
  // It interacts with the local database or storage to perform CRUD operations.

  // Example method to fetch reminders from local storage
  @override
  Future<Either<DatabaseException, List<ReminderEntity>>>
      fetchReminders() async {
    try {
      final result = await _reminderLocalDataSource.fetchReminders();
      return Right(result.map((result) => result.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }
  // Logic to fetch reminders from local storage

  // Logic to save a reminder to local storage
  @override
  Future<Either<DatabaseException, void>> saveReminder(
      ReminderEntity reminder) async {
    try {
      final result = await _reminderLocalDataSource
          .saveReminder(reminder.toReminderModel());
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  @override
  Future<Either<DatabaseException, void>> deleteReminder(String id) async {
    try {
      final result = await _reminderLocalDataSource.deleteReminder(id);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  } 
}
