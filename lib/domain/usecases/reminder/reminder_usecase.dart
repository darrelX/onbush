import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/domain/entities/reminder/reminder_entity.dart';
import 'package:onbush/domain/repositories/reminder/reminder_repository.dart';
import 'package:onbush/services/reminder/reminder_motification_service.dart';

class ReminderUseCase {
  final ReminderRepository _reminderRepository;
  final ReminderNotificationService _notificationService;
  ReminderUseCase(this._reminderRepository, this._notificationService);

  // Example method to fetch reminders from local storage
  Future<Either<DatabaseException, List<ReminderEntity>>>
      fetchReminders() async {
    return _reminderRepository.fetchReminders();
  }
  // Logic to fetch reminders from local storage

  // Logic to save a reminder to local storage
  Future<Either<DatabaseException, void>> saveReminder(
      ReminderEntity reminder) async {
    try {
      final result = await _reminderRepository.saveReminder(reminder);
      // Si la sauvegarde est réussie, planifie la notification
      await _notificationService.scheduleReminder(reminder);
      return const Right(null); // Retourne la réussite
    } catch (e) {
      // Gère les erreurs lors de la sauvegarde ou de la planification
      return Left(DatabaseException('Error saving reminder: $e'));
    }
  }

  // Logic to delete a reminder from local storage
  Future<Either<DatabaseException, void>> deleteReminder(String id) async {
    try {
      final result = await _reminderRepository.deleteReminder(id);
      // Si la suppression réussit, annule les notifications
      await _notificationService.cancelAllReminders();
      return const Right(null); // Retourne la réussite
    } catch (e) {
      // Gère les erreurs lors de la suppression ou de l'annulation
      return Left(DatabaseException('Error deleting reminder: $e'));
    }
  }
}
