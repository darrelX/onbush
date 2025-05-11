import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onbush/domain/entities/reminder/reminder_entity.dart';
import 'package:onbush/domain/usecases/reminder/reminder_usecase.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final ReminderUseCase _reminderUseCase;

  ReminderCubit(this._reminderUseCase) : super(ReminderInitial());

  Future<void> loadReminders() async {                                                 
    emit(ReminderLoading());
    try {
      final result = await _reminderUseCase.fetchReminders();
      result.fold(
        (failure) => emit(ReminderFailled(failure.message)),
        (reminders) => emit(ReminderLoaded(reminders)),
      );
    } catch (e) {
      emit(ReminderFailled(e.toString()));
    }
  }

  Future<void> addReminder(Map<String, int?> inputMap) async {
    emit(ReminderLoading());
    try {
      final reminder = _mapToReminderEntity(inputMap);

      final result = await _reminderUseCase.saveReminder(reminder);
      result.fold(
        (failure) => emit(ReminderFailled(failure.message)),
        (_) => loadReminders(), // Reload after adding
      );
    } catch (e) {
      print("failed to add reminder: $e");

      emit(ReminderFailled(e.toString()));
    }
  }

  Future<void> deleteReminder(String id) async {
    emit(ReminderLoading());
    try {
      final result = await _reminderUseCase.deleteReminder(id);
      result.fold(
        (failure) => emit(ReminderFailled(failure.message)),
        (_) => loadReminders(), // Reload after deleting
      );
    } catch (e) {
      emit(ReminderFailled(e.toString()));
    }
  }

  ReminderEntity _mapToReminderEntity(Map<String, int?> inputMap) {
    // Mapping des objectifs
    final objectiveMap = {
      0: 2, // 2 fois par semaine
      1: 1, // 1 fois par semaine
      2: 3, // 3 fois par semaine
      3: 4, // 4 fois par semaine
    };

    // Mapping des horaires préférés
    final timeMap = {
      0: const TimeOfDay(hour: 8, minute: 0), // Matin
      1: const TimeOfDay(hour: 14, minute: 0), // Après-midi
      2: const TimeOfDay(hour: 19, minute: 0), // Soirée
    };

    final frequency = objectiveMap[inputMap['objective']] ?? 1;
    final preferredTime =
        timeMap[inputMap['time']] ?? const TimeOfDay(hour: 8, minute: 0);

    return ReminderEntity(
      frequencyPerWeek: frequency,
      preferredTimes: [preferredTime],
    );
  }
}
