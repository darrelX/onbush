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
  final int? academiclevel;
  final String? birthday;

  const UserEntity(
      {this.id,
      this.name,
      this.email,
      this.phoneNumber,
      this.studentId,
      this.avatar,
      this.role,
      this.majorSchoolId,
      this.schoolId,
      this.sponsorCode,
      this.academiclevel,
      this.birthday});

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
        academiclevel,
        birthday
      ];
}
