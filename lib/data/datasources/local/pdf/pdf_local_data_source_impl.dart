import 'dart:convert';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/data/datasources/local/pdf/pdf_local_data_source.dart';
import 'package:onbush/data/models/pdf_file/pdf_file_model.dart';

class PdfLocalDataSourceImpl implements PdfLocalDataSource {
  static const String _keyPdfFiles = "pdf_file";
  final LocalStorage _localStorage;
  PdfLocalDataSourceImpl({required LocalStorage localStorage})
      : _localStorage = localStorage;

  /// Sauvegarder un fichier PDF dans `SharedPreferences`
  @override
  Future<void> savePdfFile(PdfFileModel pdfFile) async {
    try {
      List<PdfFileModel> files = await getAllPdfFile();

      // Vérifier si le fichier est déjà sauvegardé
      if (!files.any((f) => f.filePath == pdfFile.filePath)) {
        files.add(pdfFile);
        List<String> jsonList =
            files.map((pdf) => jsonEncode(pdf.toJson())).toList();
        await _localStorage.setStringList(
            _keyPdfFiles, List<String>.from(jsonList));
      }
    } catch (e) {
      print("Erreur lors de la sauvegarde du fichier PDF : ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> savePdfFileByPath(
      String filePath, String category, String name) async {
    try {
      List<PdfFileModel> files = await getAllPdfFile();

      // Vérifier si le fichier est déjà sauvegardé
      if (!files.any((f) => f.filePath == filePath)) {
        PdfFileModel newPdfFile = PdfFileModel(
          filePath: filePath,
          category: category,
          name: name,
        );

        files.add(newPdfFile);
        List<String> jsonList =
            files.map((pdf) => jsonEncode(pdf.toJson())).toList();
        await _localStorage.setStringList(
            _keyPdfFiles, List<String>.from(jsonList));
      }
    } catch (e) {
      print("Erreur lors de la sauvegarde du fichier PDF : ${e.toString()}");
      rethrow;
    }
  }

  /// Récupérer tous les fichiers PDF depuis `SharedPreferences`
  @override
  Future<List<PdfFileModel>> getAllPdfFile({int maxResults = -1}) async {
    try {
      final jsonList = _localStorage.getStringList(_keyPdfFiles);
      if (jsonList == null) return [];

      final pdfList = jsonList
          .map((jsonStr) => PdfFileModel.fromJson(
              jsonDecode(jsonStr) as Map<String, dynamic>))
          .toList();

      return (maxResults > 0) ? pdfList.take(maxResults).toList() : pdfList;
    } catch (e) {
      rethrow;
    }
  }

  /// Supprimer un fichier PDF par son chemin (`filePath`)
  @override
  Future<void> deletePdfFile(String pdfPath) async {
    try {
      List<PdfFileModel> files = await getAllPdfFile();
      files.removeWhere((pdf) => pdf.filePath == pdfPath);
      List<String> jsonList =
          files.map((pdf) => jsonEncode(pdf.toJson())).toList();
      await _localStorage.setStringList(_keyPdfFiles, jsonList);
      print("setStringList a été appelé !");
    } catch (e) {
      print("Erreur lors de la suppression du fichier PDF : ${e.toString()}");
      rethrow;
    }
  }

  /// Vérifier si un fichier PDF est enregistré
  @override
  Future<bool> isSavedPdfFile(String pdfPath) async {
    try {
      List<PdfFileModel> files = await getAllPdfFile();
      return files.any((pdf) => pdf.filePath == pdfPath);
    } catch (e) {
      print("Erreur lors de la vérification du fichier PDF : ${e.toString()}");
      rethrow;
    }
  }

  /// Vérifier si un fichier PDF a déjà été ouvert
  @override
  Future<bool> isOpenedPdfFile(String pdfPath) async {
    try {
      List<PdfFileModel> files = await getAllPdfFile();
      PdfFileModel? pdfFile = files.firstWhere((pdf) => pdf.filePath == pdfPath,
          orElse: () => PdfFileModel(
                id: null,
                name: null,
                filePath: pdfPath,
                category: null,
                date: null,
                isOpened: false,
              ));

      return pdfFile.isOpened;
    } catch (e) {
      print(
          "Erreur lors de la vérification de l'ouverture du fichier PDF : ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<PdfFileModel> getPdfFileByPath(String pdfPath) async {
    try {
      List<PdfFileModel> files = await getAllPdfFile();
      PdfFileModel pdfFile = files.firstWhere((pdf) => pdf.filePath == pdfPath);
      return pdfFile;
    } catch (e) {
      rethrow;
    }
  }
}
