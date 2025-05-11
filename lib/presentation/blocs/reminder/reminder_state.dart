part of 'reminder_cubit.dart';

sealed class ReminderState extends Equatable {
  const ReminderState();

  @override
  List<Object?> get props => [];
}

class ReminderInitial extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderLoaded extends ReminderState {
  final List<ReminderEntity> reminders;

  const ReminderLoaded(this.reminders);

  @override
  List<Object?> get props => [reminders];
}

class ReminderFailled extends ReminderState {
  final String message;

  const ReminderFailled(this.message);

  @override
  List<Object?> get props => [message];
}
