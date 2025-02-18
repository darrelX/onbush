import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/subject/subject_remote_data_source.dart';
import 'package:onbush/data/models/subject/subject_model.dart';

class SubjectRemoteDataSourceImpl implements SubjectRemoteDataSource {
  final Dio _dioDataApi;

  SubjectRemoteDataSourceImpl(this._dioDataApi);

  @override
  Future<List<SubjectModel>> getSubjectByspecialityId(
      {required int specialityId}) async {
    List<SubjectModel> subjects = [];
    try {
      Response response =
          await _dioDataApi.get("/filiere/$specialityId/matieres");
      List<dynamic> data = response.data['data'] as List<dynamic>;
      subjects = data
          .map((item) => SubjectModel.fromJson(item as Map<String, dynamic>))
          .toList();
      return subjects;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<SubjectModel>> getSubjectByLevel(
      {required int subjectId, required int level}) {
    // TODO: implement getSubjectByLevel
    throw UnimplementedError();
  }
}
