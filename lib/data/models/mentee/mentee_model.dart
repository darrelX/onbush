import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/mentee/mentee_entity.dart';

part 'mentee_model.g.dart';

@JsonSerializable()
class MenteeModel extends Equatable
    with EntityConvertible<MenteeModel, MenteeEntity> {
  @JsonKey(name: 'nom')
  final String? name;
  @JsonKey(name: 'level')
  final int? level;
  @JsonKey(name: 'filiere')
  final String? majorSchoolId;
  @JsonKey(name: 'etablissement')
  final String? schoolId;
  @JsonKey(name: 'montant')
  final double? amount;

  const MenteeModel(
      {required this.level,
      required this.amount,
      required this.name,
      required this.majorSchoolId,
      required this.schoolId});

  @override
  List<Object?> get props => [name, level, majorSchoolId, schoolId];

  factory MenteeModel.fromJson(Map<String, dynamic> json) {
    return _$MenteeModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$MenteeModelToJson(this);

  @override
  MenteeEntity toEntity() {
    return MenteeEntity(
        level: level,
        amount: amount,
        name: name,
        majorSchoolId: majorSchoolId,
        schoolId: schoolId);
  }
}
