import 'package:equatable/equatable.dart';

class MenteeEntity extends Equatable {
  final String? name;
  final int? level;
  final String? majorSchoolId;
  final String? schoolId;
  final double? amount;

  const MenteeEntity(
      {required this.level,
      required this.amount,
      required this.name,
      required this.majorSchoolId,
      required this.schoolId});

  @override
  List<Object?> get props => [name, level, majorSchoolId, schoolId];
}