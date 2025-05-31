import 'package:onbush/data/models/user/user_model.dart';

abstract class PaymentRemoteDataSource {

  dynamic initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required String sponsorCode,
    required String discountCode,
  });


  Future<UserModel?> verifying({required String transactionId, required String device});

  Future<int> validateSponsorCode({required String sponsorCode});

  Future<int> applyDiscountCode({required String reduceCode});

}
