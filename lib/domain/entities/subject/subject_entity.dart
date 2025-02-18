import 'package:equatable/equatable.dart';
import 'package:onbush/data/models/subject/subject_model.dart';

class SubjectEntity extends Equatable {
  final int? id;
  final String? name;
  final int? semester;
  final int? specialityId;

  const SubjectEntity({
    required this.id,
    required this.name,
    required this.semester,
    required this.specialityId,
  });

  @override
  List<Object?> get props => [id, name, semester, specialityId];

  SubjectModel toSubjectModel() {
    return SubjectModel(
      id: id,
      name: name,
      semester: semester,
      specialityId: specialityId
    );
  }
}
