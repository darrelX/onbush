import 'package:equatable/equatable.dart';

class CourseEntity extends Equatable {
  final int? id;
  final String? name;
  final String? pdf;
  final int? courseId;


  const CourseEntity(
      {required this.id,
      required this.name,
      required this.pdf,
      required this.courseId,
      });

  @override
  List<Object?> get props => [id, name, pdf, courseId,];
  
}