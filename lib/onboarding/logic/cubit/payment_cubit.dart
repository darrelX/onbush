import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/auth/data/models/user_model.dart';
import 'package:onbush/onboarding/logic/repositories/payment_repository.dart';
import 'package:onbush/shared/utils/utils.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final PaymentRepository _paymentRepository;
  PaymentCubit()
      : _paymentRepository = PaymentRepository(),
        super(const PaymentInitial());

  Future<void> initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required int sponsorCode,
    required int discountCode,
  }) async {
    emit(const PaymentLoading());
    try {
      final String transactionId = (await _paymentRepository.initPayment(
          appareil: appareil,
          email: email,
          phoneNumber: phoneNumber,
          paymentService: paymentService,
          amount: amount,
          sponsorCode: sponsorCode,
          discountCode: discountCode))!;
      print("darrel $transactionId");

      emit(PaymentSuccess(transactionId: transactionId));
    } catch (e) {
      emit(PaymentFailure(
          message: Utils.extractErrorMessageFromMap(
              e, {"0": "imapossible d'initier la transaction"})));
    }
  }

  Future<void> verifying({required String transactionId}) async {
    emit(const VerifyingPaymentLoading());
    try {
      final user =
          await _paymentRepository.verifying(transactionId: transactionId);
      emit(VerifyingPaymentSuccess(user: user!));
    } catch (e) {
      emit(VerifyingPaymentFailure(
        message: Utils.extractErrorMessageFromMap(e, {
          "0": "Transaction introuvable",
          "-1": "Transaction echouee",
          "3": "Delai passe",
          "1": "Transaction en cours",
          "-2": "compte client introuvable",
          "-3": "Infos etudiant introuvable"
        }),
      ));
    }
  }
}
