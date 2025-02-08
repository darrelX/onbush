import 'dart:io';

class PdfFileModel {
  final String? name;
  final String? date;
  final String? category;
  final File file;

  const PdfFileModel(
      {required this.name,
      required this.file,
      required this.category,
      required this.date});

  factory PdfFileModel.fromJson(Map<String, dynamic> json) {
    return PdfFileModel(
      name: json['name'],
      file: json['file'],
      date: json['date'],
      category: json['category'],
    );
  }
}
