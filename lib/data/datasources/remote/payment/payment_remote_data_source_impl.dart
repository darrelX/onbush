import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/payment/payment_remote_data_source.dart';
import 'package:onbush/data/models/user/user_model.dart';

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Dio _dioAccountApi;
  PaymentRemoteDataSourceImpl(this._dioAccountApi);

  @override
  Future<UserModel?> verifying({required String transactionId}) async {
    try {
      final Response response = await _dioAccountApi.post(
          '/auth/payment/status',
          data: {"transaction_id": transactionId});
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  dynamic initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required String sponsorCode,
    required String discountCode,
  }) async {
    try {
      final Response response =
          await _dioAccountApi.post('/auth/payment/init', data: {
        "appareil": appareil,
        "email": email,
        "telephone": phoneNumber,
        "service_paiement": paymentService,
        "montant": amount,
        "code_Parrain": sponsorCode,
        "code_reduction": discountCode
      });
      if (response.data['data'] is String) {
        return response.data['data'];
      } else {
        return UserModel.fromJson(response.data['data']);
      }
      // return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> validateSponsorCode({required String sponsorCode}) async {
    try {
      final Response response = await _dioAccountApi.get(
        '/code_parrain/$sponsorCode/montant',
      );
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> applyDiscountCode({required String reduceCode}) async {
    try {
      final Response response = await _dioAccountApi.get(
        '/code_reduction/$reduceCode/montant',
      );
      return response.data['data'];
    } catch (e) {
      rethrow;
    }
  }
}
