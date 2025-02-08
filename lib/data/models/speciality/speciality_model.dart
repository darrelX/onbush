import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';

part 'speciality_model.g.dart';

@JsonSerializable()
class SpecialityModel extends Equatable
    with EntityConvertible<SpecialityModel, SpecialityEntity> {
  final int? id;
  @JsonKey(name: 'nom')
  final String? name;
  final String? sigle;
  @JsonKey(name: 'niveau')
  final String? level;
  @JsonKey(name: 'etablissement_id')
  final int? collegeId;

  const SpecialityModel(
      {required this.id,
      required this.name,
      required this.sigle,
      required this.level,
      this.collegeId});

  factory SpecialityModel.fromJson(Map<String, dynamic> json) {
    return _$SpecialityModelFromJson(json);
  }

  toJson() => _$SpecialityModelToJson(this);

  @override
  List<Object?> get props => [id, name, sigle, level, collegeId];

  @override
  SpecialityEntity toEntity() {
    return SpecialityEntity(id: id, name: name, sigle: sigle, level: level);
  }
}
