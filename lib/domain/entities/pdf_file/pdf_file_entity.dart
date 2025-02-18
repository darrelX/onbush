import 'package:equatable/equatable.dart';
import 'package:onbush/data/models/pdf_file/pdf_file_model.dart';
import 'package:uuid/uuid.dart';

class PdfFileEntity extends Equatable {
  final String? id;
  final String? name;
  final DateTime? date;
  final String? category;
  final String? filePath;
  final bool isOpened;

  PdfFileEntity(
      { String? id,
      required this.name,
    
      required this.filePath,
      this.isOpened = false,
      required this.category,
        DateTime? date}) : id = id  ?? const Uuid().v4(), date = date ?? DateTime.now();

  PdfFileEntity copyWith({
    String? id,
    String? name,
    DateTime? date,
    String? category,
    String? filePath,
    bool? isOpened,
  }) {
    return PdfFileEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      category: category ?? this.category,
      filePath: filePath ?? this.filePath,
      isOpened: isOpened ?? this.isOpened,
    );
  }

  PdfFileModel toPdfFileModel() {
    return PdfFileModel(
      id: id,
      name: name,
      filePath: filePath,
      date: date,
      category: category,
      isOpened: isOpened,
    );
  }

  @override
  List<Object?> get props => [id, name, date, category, filePath, isOpened];
}
