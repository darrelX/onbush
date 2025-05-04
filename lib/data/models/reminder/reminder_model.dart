import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/reminder/reminder_entity.dart';
import 'package:uuid/uuid.dart';

part 'reminder_model.g.dart';

@JsonSerializable()
class ReminderModel extends Equatable
    with EntityConvertible<ReminderModel, ReminderEntity> {
  final String? id;
  final int? frequencyPerWeek;

  @TimeOfDayListConverter()
  final List<TimeOfDay> preferredTimes;

  ReminderModel({
    String? id,
    required this.frequencyPerWeek,
    required this.preferredTimes,
  }) : id = id ?? const Uuid().v4();

  factory ReminderModel.fromJson(Map<String, dynamic> json) =>
      _$ReminderModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderModelToJson(this);

  @override
  List<Object?> get props => [frequencyPerWeek, preferredTimes];

  @override
  ReminderEntity toEntity() {
    return ReminderEntity(
      id: id,
      frequencyPerWeek: frequencyPerWeek,
      preferredTimes: preferredTimes,
    );
  }
}

class TimeOfDayListConverter
    implements JsonConverter<List<TimeOfDay>, List<dynamic>> {
  const TimeOfDayListConverter();

  @override
  List<TimeOfDay> fromJson(List<dynamic> json) {
    return json.map((time) {
      final timeMap = time as Map<String, dynamic>;
      return TimeOfDay(hour: timeMap['hour'], minute: timeMap['minute']);
    }).toList();
  }

  @override
  List<dynamic> toJson(List<TimeOfDay> times) {
    return times
        .map((time) => {'hour': time.hour, 'minute': time.minute})
        .toList();
  }
}
