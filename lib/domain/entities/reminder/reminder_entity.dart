import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:onbush/data/models/reminder/reminder_model.dart';
import 'package:uuid/uuid.dart';

class ReminderEntity extends Equatable {
  final int? frequencyPerWeek; // ex: 7 = quotidien, 14 = deux fois par jour
  final String? id; // Unique identifier for the reminder
  final List<TimeOfDay> preferredTimes;

   ReminderEntity({
    String? id,
    required this.frequencyPerWeek,
    required this.preferredTimes,
  }) : id = id ?? const Uuid().v4();

  
  ReminderModel toReminderModel() {
    return ReminderModel(
      id: id,
      frequencyPerWeek: frequencyPerWeek,
      preferredTimes: preferredTimes
    );
  }

  @override
  List<Object?> get props => [frequencyPerWeek, preferredTimes, id];
}
