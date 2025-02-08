// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'college_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollegeModel _$CollegeModelFromJson(Map<String, dynamic> json) => CollegeModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['nom'] as String?,
      sigle: json['sigle'] as String?,
      city: json['ville'] as String?,
      country: json['pays'] as String?,
      totalStudyLevels: (json['nb_niveaux'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CollegeModelToJson(CollegeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.name,
      'sigle': instance.sigle,
      'ville': instance.city,
      'pays': instance.country,
      'nb_niveaux': instance.totalStudyLevels,
    };
