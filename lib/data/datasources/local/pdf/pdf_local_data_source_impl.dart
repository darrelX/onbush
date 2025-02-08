import 'dart:convert';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/data/datasources/local/_collection/pdf/pdf_file_collection.dart';
import 'package:onbush/data/datasources/local/pdf/pdf_local_data_source.dart';

class PdfLocalDataSourceImpl implements PdfLocalDataSource {
  static const String _keyPdfFiles = "pdf_file";
  final LocalStorage _localStorage;
  PdfLocalDataSourceImpl(this._localStorage);

  /// Sauvegarder un fichier PDF dans `SharedPreferences`
  @override
  Future<void> savePdfFile(PdfFileCollection pdfFile) async {
    try {
      List<PdfFileCollection> files = await getAllPdfFile();

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

  /// Récupérer tous les fichiers PDF depuis `SharedPreferences`
  @override
  Future<List<PdfFileCollection>> getAllPdfFile() async {
    try {
      List<String>? jsonList = _localStorage.getStringList(_keyPdfFiles);

      if (jsonList == null) return [];

      return jsonList.map((jsonStr) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
        return PdfFileCollection.fromJson(jsonMap);
      }).toList();
    } catch (e) {
      print(
          "Erreur lors de la récupération des fichiers PDF : ${e.toString()}");
      rethrow;
    }
  }

  /// Supprimer un fichier PDF par son chemin (`filePath`)
  @override
  Future<void> deletePdfFile(String pdfPath) async {
    try {
      List<PdfFileCollection> files = await getAllPdfFile();
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
      List<PdfFileCollection> files = await getAllPdfFile();
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
      List<PdfFileCollection> files = await getAllPdfFile();
      PdfFileCollection? pdfFile =
          files.firstWhere((pdf) => pdf.filePath == pdfPath,
              orElse: () => PdfFileCollection(
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
}
