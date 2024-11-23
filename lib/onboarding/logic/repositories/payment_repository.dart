import 'package:dio/dio.dart';
import 'package:onbush/auth/data/models/user_model.dart';
import 'package:onbush/service_locator.dart';

class PaymentRepository {
  final Dio _dio;
  PaymentRepository() : _dio = getIt<Dio>(instanceName: 'accountApi');

  Future<String?> initPayment ({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required int sponsorCode,
    required int discountCode,
  }) async {
    try {
      final Response response = await _dio.post('/auth/payment/init', data: {
        "appareil": appareil,
        "email": email,
        "telephone": phoneNumber,
        "service_paiement": paymentService,
        "montant": amount,
        "code_parrain": sponsorCode,
        "code_reduction": discountCode
      });
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> verifying({required String transactionId}) async {
    try {
      final Response response = await _dio.post('/auth/payment/status', data: {
        "transaction_id": transactionId
      });
      return UserModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
