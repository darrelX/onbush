import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:onbush/presentation/views/auth/data/models/user_model.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/database/local_storage.dart';

class OtpRepository {
  final Dio _dio;
  final LocalStorage _prefs;

  OtpRepository()
      : _dio = getIt.get<Dio>(instanceName: 'accountApi'),
        _prefs = getIt<LocalStorage>();

  Future<Either<UserModel?, void>> submit({
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

      final Response response = await _dio.post('/auth/$type/confirm/user',
          data: {
            "appareil": device,
            "code": code,
            "email": email,
            "role": role ?? "etudiant"
          });
      final data = response.data["data"];
      if (data is String) {
        return Right(data); // Retourne une chaîne si `data` est un String
      } else if (data is Map<String, dynamic>) {
        return Left(UserModel.fromJson(data)); // Retourne un UserModel si possible
      } else {
        throw const FormatException('Unexpected response format');
      }

    } catch (e) {
      rethrow;
    }
  }

  Future<void> reSendOtp(
      {required String email,
      required String device,
      String role = "etudiant",
      String type = 'register'}) async {
    try {
      final Response response = await _dio.post(
          '/auth/$type/confirm/code/resend',
          data: {"email": email, "appareil": device, "role": role});
    } catch (e) {
      rethrow;
    }
  }
}
