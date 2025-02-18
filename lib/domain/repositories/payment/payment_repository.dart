import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';

abstract class PaymentRepository {
  Future<Either<NetworkException, dynamic>> initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required String sponsorCode,
    required String discountCode,
  });

  Future<Either<NetworkException, UserEntity?>> verifying(
      {required String transactionId});

  Future<Either<NetworkException, int>> validateSponsorCode(
      {required String sponsorCode});

  Future<Either<NetworkException, int>> applyDiscountCode(
      {required String reduceCode});
}
