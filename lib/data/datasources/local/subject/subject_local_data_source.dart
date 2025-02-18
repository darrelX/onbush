import 'package:onbush/data/models/subject/subject_model.dart';

abstract class SubjectLocalDataSource {
  /// save pdf file
  Future<void> saveListSubjects(List<SubjectModel> listSubjectModel);

  /// get all availables pdfs
  Future<List<SubjectModel>> getAllSavedSubjects();

  /// delete a pdf file
  Future<void> deleteAllSubjectCache();

  Future<void> deleteSubjectId(int subjectId);
}
