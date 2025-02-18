import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/mentee/mentee_remote_data_source.dart';
import 'package:onbush/data/models/mentee/mentee_model.dart';

class MenteeRemoteDataSourceImpl implements MenteeRemoteDataSource {
  final Dio _dioApiData;

  MenteeRemoteDataSourceImpl({required Dio dioApiData}) : _dioApiData = dioApiData;

  @override
  Future<List<MenteeModel>> getAllMentees({required String device, required String email}) async {
    try {
      final Response response = await _dioApiData
          .post('/filleuls', data: {"appareil": device, "email": email});
      final List<dynamic> result = response.data["data"];
      final List<MenteeModel> listMentee = result
          .map((e) => MenteeModel.fromJson(e as Map<String, dynamic>))
          .toList();
      return listMentee;
    } catch (e) {
      rethrow;
    }
  }
}
