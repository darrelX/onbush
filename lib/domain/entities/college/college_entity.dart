import 'package:equatable/equatable.dart';

class CollegeEntity extends Equatable {
  final int? id;
  final String? name;
  final String? sigle;
  final String? city;
  final String? country;
  final int? totalStudyLevels;

  const CollegeEntity(
      {required this.id,
      required this.name,
      required this.sigle,
      required this.city,
      required this.country,
      required this.totalStudyLevels});

  @override
  List<Object?> get props => [id, name, sigle, city, country, totalStudyLevels];
}
