class SpecialityModel {
  final int? id;
  final String? name;
  final String? sigle;
  final String? level;
  final int? collegeId;

  const SpecialityModel(
      {required this.id,
      required this.name,
      required this.sigle,
      required this.level,
      this.collegeId});

  factory SpecialityModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return SpecialityModel(
        id: json['id'] as int?,
        name: json['nom'] as String?,
        collegeId: json['etablissement_id'] as int?,
        sigle: json['sigle'] as String?,
        level: json['niveau'] as String?);
  }
}
