// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['nom'] as String?,
      pdfUrl: json['pdf'] as String?,
      courseId: (json['matiere_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.name,
      'pdf': instance.pdfUrl,
      'matiere_id': instance.courseId,
    };
