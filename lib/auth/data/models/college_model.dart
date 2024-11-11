class CollegeModel {
  final int? id;
  final String? name;
  final String? sigle;
  final String? city;
  final String? country;
  final int? totalStudyLevels;

  const CollegeModel(
      {required this.id,
      required this.name,
      required this.sigle,
      required this.city,
      required this.country,
      required this.totalStudyLevels});

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return CollegeModel(
      id: json['id'] as int?,
      name: json['nom'] as String?,
      sigle: json['sigle'] as String?, 
      city: json['ville'] as String?,
      country: json['pays'] as String?,
      totalStudyLevels: json['nb_niveaux'] as int?,
    );
  }
}
