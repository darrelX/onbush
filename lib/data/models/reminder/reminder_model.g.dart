// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderModel _$ReminderModelFromJson(Map<String, dynamic> json) =>
    ReminderModel(
      id: json['id'] as String?,
      frequencyPerWeek: (json['frequencyPerWeek'] as num?)?.toInt(),
      preferredTimes: const TimeOfDayListConverter()
          .fromJson(json['preferredTimes'] as List),
    );

Map<String, dynamic> _$ReminderModelToJson(ReminderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'frequencyPerWeek': instance.frequencyPerWeek,
      'preferredTimes':
          const TimeOfDayListConverter().toJson(instance.preferredTimes),
    };
