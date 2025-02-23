import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String? title;
  final DateTime? date;
  final String? description;
  final bool isRead;

  const NotificationEntity(
      {required this.title,
      required this.date,
      required this.description,
      this.isRead = false});

  @override
  List<Object?> get props => [title, date, description, isRead];
}
