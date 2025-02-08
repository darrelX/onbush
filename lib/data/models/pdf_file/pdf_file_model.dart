import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:onbush/data/datasources/_mappers/entity_convertible.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';

part 'pdf_file_model.g.dart';

@JsonSerializable()
class PdfFileModel extends Equatable
    with EntityConvertible<PdfFileModel, PdfFileEntity> {
      final int? id;
  final String? name;
  final String? date;
  final String? category;
  final String? filePath;
  final bool isOpened;

  const PdfFileModel(

      {
        required this.id,
        required this.name,
      required this.filePath,
      this.isOpened = false,
      required this.category,
      required this.date});

  factory PdfFileModel.fromJson(Map<String, dynamic> json) {
    return _$PdfFileModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$PdfFileModelToJson(this);

  @override
  List<Object?> get props => [name, date, category, filePath, isOpened];

  @override
  PdfFileEntity toEntity() {
    return PdfFileEntity(
      id: id,
      name: name,
      isOpened :  isOpened,
      filePath: filePath,
      date: date,
      category: category,
    );
  }
}
