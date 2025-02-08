import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';

part 'college_model.g.dart';

@JsonSerializable()
class CollegeModel extends Equatable with EntityConvertible<CollegeModel, CollegeEntity> {
  final int? id;
  @JsonKey(name: 'nom')
  final String? name;

  final String? sigle;
  @JsonKey(name: 'ville')

  final String? city;
  @JsonKey(name: 'pays')

  final String? country;
  @JsonKey(name: 'nb_niveaux')

  final int? totalStudyLevels;

  const CollegeModel(
      {required this.id,
      required this.name,
      required this.sigle,
      required this.city,
      required this.country,
      required this.totalStudyLevels});

  factory CollegeModel.fromJson(Map<String, dynamic> json) {
    return _$CollegeModelFromJson(json);
  }

  toJson() => _$CollegeModelToJson(this);

  @override
  List<Object?> get props => [id, name, sigle, city, country, totalStudyLevels];

  @override
  CollegeEntity toEntity() {
    return CollegeEntity(
      id: id,
      name: name,
      sigle: sigle,
      city: city,
      country: country,
      totalStudyLevels: totalStudyLevels,
    );
  }
}
