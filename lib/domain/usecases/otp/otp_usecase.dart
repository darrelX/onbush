import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/repositories/otp/otp_repository.dart';

class OtpUseCase {
  final OtpRepository _otpRepository;

  OtpUseCase(this._otpRepository);
  Future<Either<NetworkException, dynamic>> submit({
    required int code,
    required String email,
    required String device,
    required String? role,
    String type = 'register',
  }) async {
    return _otpRepository.submit(
        code: code, email: email, device: device, role: role);
  }

  Future<Either<NetworkException, void>> reSendOtp(
      {required String email,
      required String device,
      String role = "etudiant",
      String type = 'register'}) {
    return _otpRepository.reSendOtp(email: email, device: device);
  }
}
