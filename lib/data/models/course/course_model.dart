import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel extends Equatable with EntityConvertible<CourseModel, CourseEntity> {
  final int? id;
  @JsonKey(name: 'nom')
  final String? name;
  final String? pdf;
  @JsonKey(name: 'matiere_id')
  final int? courseId;

  const CourseModel(
      {required this.id,
      required this.name,
      required this.pdf,
      required this.courseId});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return _$CourseModelFromJson(json);
  }

  toJson() => _$CourseModelToJson(this);
  @override
  List<Object?> get props => [id, name, pdf, courseId];
  
  @override
  CourseEntity toEntity() {
   return CourseEntity(
     id: id,
     name: name,
     pdf: pdf,
     courseId: courseId,
   );
  }
}
