import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';

part 'user_model.g.dart';

@immutable
@JsonSerializable()
class UserModel extends Equatable
    with EntityConvertible<UserModel, UserEntity> {
  @JsonKey(name: 'token')
  final String? id;
  @JsonKey(name: 'nom')
  final String? name;
  final String? email;
  @JsonKey(name: 'telephone')
  final String? phoneNumber;
  @JsonKey(name: 'matricule')
  final String? studentId;
  final String? avatar;
  final String? role;
  @JsonKey(name: 'filiere_id')
  final int? majorSchoolId;
  @JsonKey(name: 'etablissement_id')
  final int? schoolId;
  @JsonKey(name: 'code_parrain')
  final String? sponsorCode;
  @JsonKey(name: 'niveau')
  final int? academyLevel;
  @JsonKey(name: 'naissance')
  final String? birthday;
  @JsonKey(name: 'sexe')
  final String? gender;
  @JsonKey(name: 'lang')
  final String? language;
  @JsonKey(name: 'sigle_etablissement')
  final String? sigle;
  @JsonKey(name: 'nom_etablissement')
  final String? schoolName;
  @JsonKey(name: 'nom_filiere')
  final String? majorSchoolName;

  const UserModel(
      {required this.gender,
      required this.studentId,
      required this.avatar,
      required this.role,
      required this.majorSchoolId,
      required this.schoolId,
      required this.sponsorCode,
      required this.academyLevel,
      required this.birthday,
      required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.language,
      required this.majorSchoolName,
      required this.schoolName,
      required this.sigle});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return _$UserModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        studentId,
        avatar,
        role,
        majorSchoolId,
        schoolId,
        sponsorCode,
        academyLevel,
        birthday
      ];

  @override
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      studentId: studentId,
      avatar: avatar,
      role: role,
      majorSchoolId: majorSchoolId,
      schoolId: schoolId,
      sponsorCode: sponsorCode,
      academyLevel: academyLevel,
      birthday: birthday,
      gender: gender,
      sigle: sigle,
      language: language,
      majorSchoolName: majorSchoolName,
      schoolName: schoolName,
    );
  }
}
