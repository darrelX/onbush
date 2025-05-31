import 'dart:convert';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/data/datasources/local/subject/subject_local_data_source.dart';
import 'package:onbush/data/models/subject/subject_model.dart';

class SubjectLocalDataSourceImpl implements SubjectLocalDataSource {
  static const String _keySubject = "subject";
  final LocalStorage _localStorage;

  SubjectLocalDataSourceImpl(this._localStorage);

  /// save pdf file
  @override
  Future<void> saveListSubjects(List<SubjectModel> listSubjectModel) async {
    try {
      List<SubjectModel> files = await getAllSavedSubjects();

      // Vérifier si les fichiers ne sont pas déjà sauvegardés
      for (var subject in listSubjectModel) {
        if (!files.any((f) => f.id == subject.id)) {
          files.add(subject);
        }
      }

      // Convertir en JSON
      List<String> jsonList =
          files.map((subject) => jsonEncode(subject.toJson())).toList();

      // Sauvegarde dans le stockage local
      await _localStorage.setStringList(_keySubject, jsonList);
    } catch (e) {
      rethrow;
    }
  }

  /// get all availables pdfs
  @override
  Future<List<SubjectModel>> getAllSavedSubjects() async {
    try {
      List<String>? jsonList = _localStorage.getStringList(_keySubject);

      if (jsonList == null) return [];

      return jsonList.map((jsonStr) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
        return SubjectModel.fromJson(jsonMap);
      }).toList();
    } catch (e) {
      print(
          "Erreur lors de la récupération des fichiers PDF : ${e.toString()}");
      rethrow;
    }
  }

  /// delete a pdf file
  @override
  Future<void> deleteSubjectId(int subjectId) async {
    try {
      List<SubjectModel> files = await getAllSavedSubjects();
      files.removeWhere((pdf) => pdf.id == subjectId);
      List<String> jsonList =
          files.map((pdf) => jsonEncode(pdf.toJson())).toList();
      await _localStorage.setStringList(_keySubject, jsonList);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteAllSubjectCache() async {
    try {
      await _localStorage.remove(_keySubject);
    } catch (e) {
      rethrow;
    }
  }
}
