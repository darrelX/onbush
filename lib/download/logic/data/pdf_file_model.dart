import 'dart:io';

class PdfFileModel {
  final String? name;
  final DateTime? date;
  final String? category;
  final File file;

  const PdfFileModel(
      {required this.name, required this.file, required this.category, required this.date});

  factory PdfFileModel.fromJson(Map<String, dynamic> json) {
    return PdfFileModel(
      name: json['name'],
      file: json['file'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }
}
