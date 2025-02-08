import 'package:equatable/equatable.dart';

class SpecialityEntity extends Equatable {
  final int? id;
  final String? name;
  final String? sigle;
  final String? level;
  final int? collegeId;

  const SpecialityEntity(
      {required this.id,
      required this.name,
      required this.sigle,
      required this.level,
      this.collegeId});

  @override
  List<Object?> get props => [id, name, sigle, level, collegeId];
  
}