import 'package:equatable/equatable.dart';

enum Status { downloaded, notDownloaded, isOpened }

class CourseEntity extends Equatable {
  final int? id;
  final String? name;
  final String? pdfUrl;
  final int? courseId;
  final Status status;

  const CourseEntity({
    required this.id,
    required this.name,
    required this.pdfUrl,
    required this.courseId,
    this.status = Status.notDownloaded,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        pdfUrl,
        courseId,
      ];
}
