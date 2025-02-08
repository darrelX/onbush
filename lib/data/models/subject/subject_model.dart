import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';

part 'subject_model.g.dart';

@JsonSerializable()
class SubjectModel extends Equatable
    with EntityConvertible<SubjectModel, SubjectEntity> {
  final int? id;
  @JsonKey(name: 'nom')
  final String? name;
  @JsonKey(name: 'semestre')
  final int? semester;
  @JsonKey(name: 'filiere_id')
  final int? specialityId;

  const SubjectModel(
      {required this.id,
      required this.name,
      required this.semester,
      required this.specialityId});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return _$SubjectModelFromJson(json);
  }

  toJson() => _$SubjectModelToJson(this);

  @override
  List<Object?> get props => [id, name, semester, specialityId];

  @override
  SubjectEntity toEntity() {
    return SubjectEntity(
      id: id,
      name: name,
      semester: semester,
      specialityId: specialityId,
    );
  }
}
