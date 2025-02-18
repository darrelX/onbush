
import 'package:onbush/data/models/subject/subject_model.dart';

abstract class SubjectRemoteDataSource {

  /// returns the subject with the given specialityId
  Future<List<SubjectModel>> getSubjectByspecialityId({required int specialityId});

  /// returns the subject with the given level's school
  Future<List<SubjectModel>> getSubjectByLevel({required int subjectId, required int level});
}