import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? studentId;
  final String? avatar;
  final String? role;
  final int? majorSchoolId;
  final int? schoolId;
  final String? sponsorCode;
  final int? academyLevel;
  final String? birthday;
  final String? gender;
  final String? language;
  final String? sigle;
  final String? schoolName;
  final String? majorSchoolName;

  const UserEntity(
      {required this.id,
      required this.name,
      required this.email,
      required this.phoneNumber,
      required this.studentId,
      required this.avatar,
      required this.role,
      required this.majorSchoolId,
      required this.schoolId,
      required this.sponsorCode,
      required this.academyLevel,
      required this.birthday,
      required this.gender,
      required this.language,
      required this.majorSchoolName,
      required this.schoolName,
      required this.sigle});

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
}
