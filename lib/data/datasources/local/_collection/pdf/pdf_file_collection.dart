import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';

part 'pdf_file_collection.g.dart';

@JsonSerializable()
class PdfFileCollection extends Equatable with EntityConvertible<PdfFileCollection, PdfFileEntity> {
  final int? id;
  final String? name;
  final String? date;
  final String? category;
  final String? filePath;
  final bool isOpened;

  const PdfFileCollection({
    required this.id,
    required this.name,
    required this.filePath,
    this.isOpened = false,
    required this.category,
    required this.date,
  });

  @override
  PdfFileEntity toEntity() {
    return PdfFileEntity(
      id: id,
      name: name,
      isOpened: isOpened,
      filePath: filePath,
      date: date,
      category: category,
    );
  }

  @override
  PdfFileCollection fromEntity(PdfFileEntity? model) {
    return PdfFileCollection(
      id: model?.id,
      name: model?.name,
      filePath: model?.filePath,
      date: model?.date,
      category: model?.category,
      isOpened: model?.isOpened ?? false,
    );
  }

  /// Convertir l'objet en Map pour le stockage
  Map<String, dynamic> toJson() {
    return _$PdfFileCollectionToJson(this);
  }

  /// Convertir un Map en objet PdfFileCollection
  factory PdfFileCollection.fromJson(Map<String, dynamic> json) {
    return _$PdfFileCollectionFromJson(json);
  }

  /// 🔄 **Méthode copyWith() pour modifier des valeurs sans changer l'objet original**
  PdfFileCollection copyWith({
    int? id,
    String? name,
    String? filePath,
    String? date,
    String? category,
    bool? isOpened,
  }) {
    return PdfFileCollection(
      id: id ?? this.id,
      name: name ?? this.name,
      filePath: filePath ?? this.filePath,
      date: date ?? this.date,
      category: category ?? this.category,
      isOpened: isOpened ?? this.isOpened,
    );
  }
  
  @override
  List<Object?> get props => [id, name, filePath, date, category, isOpened];
}
