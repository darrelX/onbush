import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/otp/otp_remote_data_source.dart';
import 'package:onbush/data/models/user/user_model.dart';

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final Dio _dioAccountApi;
  OtpRemoteDataSourceImpl(this._dioAccountApi);

  @override
  Future<dynamic> submit({
    required int code,
    required String email,
    required String device,
    required String? role,
    String type = 'register',
  }) async {
    try {
      // Validation des paramètres (facultatif selon les exigences)
      if (code <= 0 || email.isEmpty || device.isEmpty) {
        throw ArgumentError('Invalid arguments provided');
      }

      final Response response = await _dioAccountApi.post(
        '/auth/$type/confirm/user',
        data: {
          "appareil": device,
          "code": code,
          "email": email,
          "role": role ?? "etudiant"
        },
      );

      final data = response.data["data"];
      if (data is String) {
        return data; // Retourne la chaîne si `data` est un String
      } else if (data is Map<String, dynamic>) {
        return UserModel.fromJson(data); // Retourne un UserModel si possible
      } else {
        throw const FormatException('Unexpected response format');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reSendOtp(
      {required String email,
      required String device,
      String role = "etudiant",
      String type = 'register'}) async {
    try {
      final Response response = await _dioAccountApi.post(
          '/auth/$type/confirm/code/resend',
          data: {"email": email, "appareil": device, "role": role});
    } catch (e) {
      rethrow;
    }
  }
}
