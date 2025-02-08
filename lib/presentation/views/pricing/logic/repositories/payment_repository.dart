import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:onbush/presentation/views/auth/data/models/user_model.dart';
import 'package:onbush/service_locator.dart';

class PaymentRepository {
  final Dio _dio;
  PaymentRepository() : _dio = getIt<Dio>(instanceName: 'accountApi');

  Future<Either<UserModel, String?>> initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required String sponsorCode,
    required String discountCode,
  }) async {
    try {
      final Response response = await _dio.post('/auth/payment/init', data: {
        "appareil": appareil,
        "email": email,
        "telephone": phoneNumber,
        "service_paiement": paymentService,
        "montant": amount,
        "code_Parrain": sponsorCode,
        "code_reduction": discountCode
      });
      if (response.data['data'] is String) {
        return Right(response.data['data']);
      } else {
        return Left(UserModel.fromJson(response.data['data']));
      }
      // return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> percent({required int code}) async {
    try {
      final Response response = await _dio.get(
        '/code_reduction/$code',
      );
      final int value = response.data['data'];
      if (value == 0) {
        return null;
      } else {
        return value;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel?> verifying({required String transactionId}) async {
    try {
      final Response response = await _dio.post('/auth/payment/status',
          data: {"transaction_id": transactionId});
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }
}
