class CourseModel {
  final int id;
  final String name;
  final String pdf;
  final int courseId;

  const CourseModel(
      {required this.id,
      required this.name,
      required this.pdf,
      required this.courseId});

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      courseId: json['matiere_id'],
      id: json['id'],
      name: json['nom'],
      pdf: json['pdf'],
    );
  }
}
