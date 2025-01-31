import 'package:equatable/equatable.dart';

class MenteeModel extends Equatable {
  final String? name;
  final int? level;
  final String? majorSchoolId;
  final String? schoolId;
  final double? amount;

  const MenteeModel(
      {required this.level,
      required this.amount,
      required this.name,
      required this.majorSchoolId,
      required this.schoolId});

  @override
  List<Object?> get props => [name, level, majorSchoolId, schoolId];

  factory MenteeModel.fromJson(Map<String, dynamic> json){
    return MenteeModel(
      name: json['nom'],
      level: json['level'],
      majorSchoolId: json['filiere'],
      amount: json['montant'],
      schoolId: json['etablissement'],
    );
  }
  
}
