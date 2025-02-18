import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';

abstract class OtpRepository {
  Future<Either<NetworkException, dynamic>> submit({
    required int code,
    required String email,
    required String device,
    required String? role,
    String type = 'register',
  });

  Future<Either<NetworkException, void>> reSendOtp(
      {required String email,
      required String device,
      String role = "etudiant",
      String type = 'register'});
}
