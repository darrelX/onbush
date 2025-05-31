import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/repositories/payment/payment_repository.dart';

class PaymentUseCase {
  final PaymentRepository _paymentRepository;
  PaymentUseCase(this._paymentRepository);
  Future<Either<NetworkException, dynamic>> initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required String sponsorCode,
    required String discountCode,
  }) async {
    return _paymentRepository.initPayment(
        appareil: appareil,
        email: email,
        phoneNumber: phoneNumber,
        paymentService: paymentService,
        amount: amount,
        sponsorCode: sponsorCode,
        discountCode: discountCode);
  }

  Future<Either<NetworkException, UserEntity?>> verifying(
      {required String transactionId, required String device}) async {
    return _paymentRepository.verifying(transactionId: transactionId, device: device);
  }

  Future<Either<NetworkException, int>> validateSponsorCode(
      {required String sponsorCode}) async {
    return _paymentRepository.validateSponsorCode(sponsorCode: sponsorCode);
  }

  Future<Either<NetworkException, int>> applyDiscountCode(
      {required String reduceCode}) async {
    return _paymentRepository.applyDiscountCode(reduceCode: reduceCode);
  }
}
