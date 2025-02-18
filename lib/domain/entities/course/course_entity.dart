import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final int? id;
  final String? name;
  final String? pdfUrl;
  final int? courseId;


  const CourseEntity(
      {required this.id,
      required this.name,
      required this.pdfUrl,
      required this.courseId,
      });

  @override
  List<Object?> get props => [id, name, pdfUrl, courseId,];
  
}