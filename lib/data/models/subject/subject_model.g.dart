// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) => SubjectModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['nom'] as String?,
      semester: (json['semestre'] as num?)?.toInt(),
      specialityId: (json['filiere_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubjectModelToJson(SubjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.name,
      'semestre': instance.semester,
      'filiere_id': instance.specialityId,
    };
