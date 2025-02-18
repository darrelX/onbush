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
  final int? academyLevel;
  final String? birthday;
  final String? gender;
  final String? language;
  final String? sigle;
  final String? schoolName;
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
  //     Academylevel: null,
  //     birthday: '',
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return UserModel(
        id: json['token'] as String,
        name: json['nom'] as String?,
        gender: json['sexe'] as String?,
        email: json['email'] as String?,
        phoneNumber: json['telephone'] as String?,
        studentId: json['matricule'] as String?,
        avatar: json['avatar'] as String?,
        role: json['role'] as String?,
        majorSchoolId: json['filiere_id'] as int?,
        schoolId: json['etablissement_id'] as int?,
        sponsorCode: json['code_parrain'] as String?,
        academyLevel: json['niveau'] as int?,
        birthday: json['naissance'] as String?,
        language: json['langue'] as String?,
        majorSchoolName: json['nom_filiere'] as String?,
        schoolName: json['nom_etablissement'] as String?,
        sigle: json['sigle_etablissement'] as String?);
  }

  // Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
