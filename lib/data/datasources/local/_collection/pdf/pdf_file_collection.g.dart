// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pdf_file_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PdfFileCollection _$PdfFileCollectionFromJson(Map<String, dynamic> json) =>
    PdfFileCollection(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      filePath: json['filePath'] as String?,
      isOpened: json['isOpened'] as bool? ?? false,
      category: json['category'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$PdfFileCollectionToJson(PdfFileCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'date': instance.date,
      'category': instance.category,
      'filePath': instance.filePath,
      'isOpened': instance.isOpened,
    };
