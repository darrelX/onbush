import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:uuid/uuid.dart';
// import 'package:uuid/uuid.dart';  // ✅ Import du package Uuid

part 'pdf_file_model.g.dart';

@JsonSerializable()
class PdfFileModel extends Equatable
    with EntityConvertible<PdfFileModel, PdfFileEntity> {
  final String? id; // ✅ Modification du type en String
  final String? name;
  final DateTime? date;
  final DateTime? updatedDate;
  final String? category;
  final String? filePath;
  final bool isOpened;

  PdfFileModel({
    String? id, // ✅ Génération automatique d'un UUID si id est null
    required this.name,
    required this.filePath,
    DateTime? updatedDate,
    this.isOpened = false,
    required this.category,
    DateTime? date,
  })  : date = date ?? DateTime.now(),
        updatedDate = updatedDate ?? DateTime.now(),
        id = id ?? const Uuid().v4(); // ✅ Génération de l'UUID ici

  factory PdfFileModel.fromJson(Map<String, dynamic> json) {
    return _$PdfFileModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$PdfFileModelToJson(this);

  @override
  List<Object?> get props =>
      [id, name, date, category, filePath, isOpened, updatedDate];

  @override
  PdfFileEntity toEntity() {
    return PdfFileEntity(
      id: id,
      name: name,
      isOpened: isOpened,
      filePath: filePath,
      date: date,
      category: category,
      updatedDate: updatedDate, // Ajout de updatedDate
    );
  }

  @override
  PdfFileModel fromEntity(PdfFileEntity? model) {
    return PdfFileModel(
      id: model?.id,
      name: model?.name,
      filePath: model?.filePath,
      date: model?.date,
      category: model?.category,
      isOpened: model?.isOpened ?? false,
      updatedDate: model?.updatedDate, // Ajout de updatedDate
    );
  }

  PdfFileModel copyWith({
    String? id,
    String? name,
    String? filePath,
    DateTime? date,
    String? category,
    bool? isOpened,
  }) {
    return PdfFileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      date: date ?? this.date,
      category: category ?? this.category,
      isOpened: isOpened ?? this.isOpened,
      updatedDate: DateTime.now(),
    );
  }
}
