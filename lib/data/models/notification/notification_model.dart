import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/notification/notification_entity.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends Equatable
    with EntityConvertible<NotificationModel, NotificationEntity> {
  final String? title;
  final DateTime? date;
  final String? description;
  final bool? isRead;

  NotificationModel({
    required this.title,
    required this.description,
    required this.date,
    this.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  List<Object?> get props => [title, date, description, isRead];

  @override
  NotificationEntity toEntity() {
    return NotificationEntity(
        date: date, title: title, description: description, isRead: isRead ?? false);
  }

  @override
  NotificationModel fromEntity(NotificationEntity? model) {
    return NotificationModel(
        date: date, title: title, description: description, isRead: isRead ?? false);
  }
}
