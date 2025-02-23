import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/data/datasources/remote/payment/payment_remote_data_source.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/repositories/payment/payment_repository.dart';

class PaymentRepositoryImpl extends PaymentRepository {
  final PaymentRemoteDataSource _paymentRemoteDataSource;

  PaymentRepositoryImpl(this._paymentRemoteDataSource);

  @override
  Future<Either<NetworkException, dynamic>> initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required String sponsorCode,
    required String discountCode,
  }) async {
    try {
      final result = await _paymentRemoteDataSource.initPayment(
          appareil: appareil,
          email: email,
          phoneNumber: phoneNumber,
          paymentService: paymentService,
          amount: amount,
          sponsorCode: sponsorCode,
          discountCode: discountCode);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  @override
  Future<Either<NetworkException, UserEntity?>> verifying(
      {required String transactionId}) async {
    try {
      final result = await _paymentRemoteDataSource.verifying(
          transactionId: transactionId);
      return Right(result?.toEntity());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  @override
  Future<Either<NetworkException, int>> validateSponsorCode(
      {required String sponsorCode}) async {
    try {
      final result = await _paymentRemoteDataSource.validateSponsorCode(
          sponsorCode: sponsorCode);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  @override
  Future<Either<NetworkException, int>> applyDiscountCode(
      {required String reduceCode}) async {
    try {
      final result = await _paymentRemoteDataSource.applyDiscountCode(
          reduceCode: reduceCode);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }
}
