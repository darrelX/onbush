import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/data/datasources/remote/otp/otp_remote_data_source.dart';
import 'package:onbush/domain/repositories/otp/otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {
  final OtpRemoteDataSource _otpRemoteDataSource;
  OtpRepositoryImpl(this._otpRemoteDataSource);

  @override
  Future<Either<NetworkException, dynamic>> submit({
    required int code,
    required String email,
    required String device,
    required String? role,
    String type = 'register',
  }) async {
    try {
      final result = await _otpRemoteDataSource.submit(
          code: code, email: email, device: device, role: role);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.extractErrorMessage(e));
    }
  }

  @override
  Future<Either<NetworkException, void>> reSendOtp(
      {required String email,
      required String device,
      String role = "etudiant",
      String type = 'register'}) async {
    try {
      final result =
          await _otpRemoteDataSource.reSendOtp(email: email, device: device);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.extractErrorMessage(e));
    }
  }
}
