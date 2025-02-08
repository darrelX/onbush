// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenteeModel _$MenteeModelFromJson(Map<String, dynamic> json) => MenteeModel(
      level: (json['level'] as num?)?.toInt(),
      amount: (json['montant'] as num?)?.toDouble(),
      name: json['nom'] as String?,
      majorSchoolId: json['filiere'] as String?,
      schoolId: json['etablissement'] as String?,
    );

Map<String, dynamic> _$MenteeModelToJson(MenteeModel instance) =>
    <String, dynamic>{
      'nom': instance.name,
      'level': instance.level,
      'filiere': instance.majorSchoolId,
      'etablissement': instance.schoolId,
      'montant': instance.amount,
    };
