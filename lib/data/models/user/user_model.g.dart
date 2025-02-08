// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      gender: json['sexe'] as String?,
      studentId: json['matricule'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
      majorSchoolId: (json['filiere_id'] as num?)?.toInt(),
      schoolId: (json['etablissement_id'] as num?)?.toInt(),
      sponsorCode: json['code_parrain'] as String?,
      academiclevel: (json['niveau'] as num?)?.toInt(),
      birthday: json['naissance'] as String?,
      id: json['token'] as String?,
      name: json['nom'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['telephone'] as String?,
      language: json['lang'] as String?,
      majorSchoolName: json['nom_filiere'] as String?,
      schoolName: json['nom_etablissement'] as String?,
      sigle: json['sigle_etablissement'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'token': instance.id,
      'nom': instance.name,
      'email': instance.email,
      'telephone': instance.phoneNumber,
      'matricule': instance.studentId,
      'avatar': instance.avatar,
      'role': instance.role,
      'filiere_id': instance.majorSchoolId,
      'etablissement_id': instance.schoolId,
      'code_parrain': instance.sponsorCode,
      'niveau': instance.academiclevel,
      'naissance': instance.birthday,
      'sexe': instance.gender,
      'lang': instance.language,
      'sigle_etablissement': instance.sigle,
      'nom_etablissement': instance.schoolName,
      'nom_filiere': instance.majorSchoolName,
    };
