import 'package:dio/dio.dart';
import 'package:onbush/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpRepository {
  final Dio _dio;
  final Future<SharedPreferences>? _prefs;

  OtpRepository()
      : _dio = getIt.get<Dio>(instanceName: 'accountApi'),
        _prefs = getIt<Future<SharedPreferences>>();

  Future<void> submit(
      {required String code,
      required String email,
      required String phoneNumber,
      role}) async {
    try {
      final Response response = await _dio.post('/auth/register/confirm/user',
          data: {"phone_number": phoneNumber, "code": code, "email": email});

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
