class UserModel {
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
  final String? gender;

  const UserModel({
    required this.gender,
    required this.studentId,
    required this.avatar,
    required this.role,
    required this.majorSchoolId,
    required this.schoolId,
    required this.sponsorCode,
    required this.academiclevel,
    required this.birthday,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  // UserModel copyWith(
  //     {int? id,
  //     String? name,
  //     String? email,
  //     double? balance,
  //     String? phoneNumber}) {
  //   return UserModel(
  //     id: id ?? this.id,
  //     name: name ?? this.name,
  //     email: email ?? this.email,
  //     phoneNumber: phoneNumber ?? this.phoneNumber,
  //     studentId: studentId ?? this.studentId,
  //     avatar: avatad,
  //     role: '',
  //     majorSchoolId: null,
  //     schoolId: null,
  //     sponsorCode: '',
  //     academiclevel: null,
  //     birthday: '',
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['token'].toString() as String?,
      name: json['nom'] as String?,
      gender: json['sexe'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      studentId: json['matricule'] as String?,
      avatar: json['avatar'] as String?,
      role: json['role'] as String?,
      majorSchoolId: json['filiere_id'] as int?,
      schoolId: json['etablissement_id'] as int?,
      sponsorCode: json['code_parrrain'] as String?,
      academiclevel: json['niveau'] as int?,
      birthday: json['birthday'] as String?,
    );
  }

  // Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
