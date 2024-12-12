class SubjectModel {
  final int? id;
  final String? name;
  final int? semester;
  final int? specialityId;

  SubjectModel(
      {required this.id,
      required this.name,
      required this.semester,
      required this.specialityId});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'],
      name : json['nom'],
      semester: json['semestre'],
      specialityId: json['filiere_id'],
    );
  }

}
