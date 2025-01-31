import 'package:dio/dio.dart';
import 'package:onbush/presentation/dashboard/profil/data/models/mentee_model.dart';
import 'package:onbush/service_locator.dart';

class MenteeRepository {
  final Dio _dioApiData;
  final Dio _dioApiAccount;
  MenteeRepository()
      : _dioApiData = getIt.get<Dio>(instanceName: 'dataApi'),
        _dioApiAccount = getIt.get<Dio>(instanceName: 'accountApi');

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

  Future<void> editProfil(
      {required String device,
      required String studentId,
      required String name,
      required String gender,
      required String birthday,
      required String phone,
      required String email,
      required String level,
      required String avatar,
      required String language,
      required String role}) async {
    try {
      final Response response =
          await _dioApiAccount.post("/auth/update/user", data: {
        "appareil": device,
        "matricule": studentId,
        "nom": name,
        "email": email,
        "telephone": phone,
        "sexe": gender,
        "naissance": birthday,
        "niveau": level,
        "avatar": avatar,
        "lang": language,
        "role": role
      });
    } catch (e) {
      rethrow;
    }
  }
}
