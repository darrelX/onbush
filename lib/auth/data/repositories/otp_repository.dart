import 'package:dio/dio.dart';
import 'package:onbush/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpRepository {
  final Dio _dio;
  final Future<SharedPreferences>? _prefs;

  OtpRepository()
      : _dio = getIt.get<Dio>(instanceName: 'accountApi'),
        _prefs = getIt<Future<SharedPreferences>>();

  Future<void> submit({
    required int code,
    required String email,
    required String device,
    required String? role,
  }) async {
    try {
      final Response response = await _dio.post('/auth/register/confirm/user',
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

  // Future<void> sendOtp({required String phoneNumber, required String email, String role = "email"}) async {
  //   try {
  //     final Response response = await _dio.post('/auth/register/confirm/user',
  //         data: {
  //           "phone_number": phoneNumber,
  //           "email": email,
  //           "role": role
  //         });
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
