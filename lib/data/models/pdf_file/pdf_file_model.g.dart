// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdfFileModel _$PdfFileModelFromJson(Map<String, dynamic> json) => PdfFileModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      filePath: json['filePath'] as String?,
      isOpened: json['isOpened'] as bool? ?? false,
      category: json['category'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$PdfFileModelToJson(PdfFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date?.toIso8601String(),
      'category': instance.category,
      'filePath': instance.filePath,
      'isOpened': instance.isOpened,
    };
