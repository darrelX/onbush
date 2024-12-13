import 'package:dio/dio.dart';
import 'package:onbush/presentation/dashboard/profil/data/models/mentee_model.dart';
import 'package:onbush/service_locator.dart';

class MenteeRepository {
  final Dio _dioApiData;
  MenteeRepository() : _dioApiData = getIt.get<Dio>(instanceName: 'dataApi');

  Future<List<MenteeModel>> getListGetMentee(
      {required String appareil, required String email}) async {
    try {
      final Response response = await _dioApiData
          .post('/filleuls', data: {"appareil": appareil, "email": email});
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
