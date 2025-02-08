import 'package:equatable/equatable.dart';

class SubjectEntity extends Equatable {
  final int? id;
  final String? name;
  final int? semester;
  final int? specialityId;

  const SubjectEntity(
      {required this.id,
      required this.name,
      required this.semester,
      required this.specialityId,
      });

  @override
  List<Object?> get props => [id, name, semester, specialityId];
  
}