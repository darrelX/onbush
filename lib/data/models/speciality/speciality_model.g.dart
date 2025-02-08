// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SpecialityModel _$SpecialityModelFromJson(Map<String, dynamic> json) =>
    SpecialityModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['nom'] as String?,
      sigle: json['sigle'] as String?,
      level: json['niveau'] as String?,
      collegeId: (json['etablissement_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SpecialityModelToJson(SpecialityModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.name,
      'sigle': instance.sigle,
      'niveau': instance.level,
      'etablissement_id': instance.collegeId,
    };
