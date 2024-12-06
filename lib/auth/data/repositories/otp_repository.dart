import 'package:dio/dio.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/local/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpRepository {
  final Dio _dio;
  final LocalStorage _prefs;

  OtpRepository()
      : _dio = getIt.get<Dio>(instanceName: 'accountApi'),
        _prefs = getIt<LocalStorage>();

  Future<void> submit({
    required int code,
    required String email,
    required String device,
    required String? role,
    String type = 'register',
  }) async {
    try {
      final Response response = await _dio.post('/auth/$type/confirm/user',
          data: {
            "appareil": device,
            "code": code,
            "email": email,
            "role": role ?? "etudiant"
          });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> reSendOtp(
      {required String email,
      required int code,
      required String device,
      String role = "email",
      String type = 'register'}) async {
    try {
      final Response response = await _dio.post('/auth/$type/confirm/user',
          data: {
            "code": code,
            "email": email,
            "role": role,
            "appareil": device
          });
    } catch (e) {
      rethrow;
    }
  }
}
