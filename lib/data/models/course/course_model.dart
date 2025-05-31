import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:equatable/equatable.dart';

part 'course_model.g.dart';

enum CourseContentType {
  auto, // utilise un ordre de priorité : pdf > pdfEpreuve > pdfCorrige
  main, // pour le champ "pdf"
  epreuve, // pour le champ "pdf_epreuve"
  corrige, // pour le champ "pdf_corrige"
}

@JsonSerializable()
class CourseModel extends Equatable
    with EntityConvertible<CourseModel, CourseEntity> {
  @JsonKey(name: 'id', fromJson: _idFromJson)
  final String? id;

  static String? _idFromJson(dynamic value) => value?.toString();

  @JsonKey(name: 'nom')
  final String? name;

  @JsonKey(name: 'pdf')
  final String? pdfUrl;

  @JsonKey(name: 'matiere_id')
  final int? courseId;

  @JsonKey(name: 'pdf_epreuve')
  final String? pdfEpreuve;

  @JsonKey(name: 'pdf_corrige')
  final String? pdfCorrige;

  const CourseModel({
    required this.id,
    required this.name,
    this.pdfUrl,
    this.pdfEpreuve,
    this.pdfCorrige,
    required this.courseId,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  static List<CourseModel> fromJsonList(Map<String, dynamic> json) {
    final List<CourseModel> models = [];
    final String? baseId = json['id']?.toString();
    final String? baseName = json['nom'];
    final int? matiereId = json['matiere_id'];

    final String? pdf = json['pdf'];
    final String? pdfEpreuve = json['pdf_epreuve'];
    final String? pdfCorrige = json['pdf_corrige'];

    if (pdf != null && pdf.isNotEmpty) {
      models.add(CourseModel(
        id: baseId,
        name: baseName,
        pdfUrl: pdf,
        courseId: matiereId,
      ));
    }

    if (pdfEpreuve != null && pdfEpreuve.isNotEmpty) {
      models.add(CourseModel(
        id: '${baseId}_epreuve',
        name: '$baseName - Épreuve',
        pdfEpreuve: pdfEpreuve,
        courseId: matiereId,
      ));
    }

    if (pdfCorrige != null && pdfCorrige.isNotEmpty) {
      models.add(CourseModel(
        id: '${baseId}_corrige',
        name: '$baseName - Corrigé',
        pdfCorrige: pdfCorrige,
        courseId: matiereId,
      ));
    }

    return models;
  }

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  @override
  List<Object?> get props => [id, name, pdfUrl, courseId];

  /// ✅ toEntity avec différenciation par type de document
  @override
  CourseEntity toEntity() {
    return CourseEntity(
      id: id,
      name: name,
      pdfUrl: pdfUrl,
      pdfEpreuve: pdfEpreuve,
      pdfCorrige: pdfCorrige,
      courseId: courseId,
    );
  }
}
