import 'dart:io';

import 'package:equatable/equatable.dart';

class PdfFileEntity extends Equatable {
  final int? id;
  final String? name;
  final String? date;
  final String? category;
  final String? filePath;
  final bool isOpened;

  const PdfFileEntity(
      {required this.id,
      required this.name,
      required this.filePath,
      this.isOpened = false,
      required this.category,
      required this.date});

  @override
  List<Object?> get props => [id, name, date, category, filePath, isOpened];
}
