import 'package:equatable/equatable.dart';

enum Status { downloaded, notDownloaded, isOpened }

class CourseEntity extends Equatable {
  final String? id;
  final String? name;
  final String? pdfUrl;
  final int? courseId;
  final Status status;
  final String? pdfEpreuve;
  final String? pdfCorrige;

  const CourseEntity({
    required this.id,
    required this.name,
    required this.pdfUrl,
    required this.courseId,
    required this.pdfEpreuve,
    required this.pdfCorrige,
    this.status = Status.notDownloaded,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        pdfUrl,
        courseId,
        pdfEpreuve,
        pdfCorrige,
        status,
      ];
}
