import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/core/utils/utils.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/usecases/payment/payment_usecase.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  // PaymentCubit() : super(PaymentInitial());
  final PaymentUseCase _paymentUseCase;
  PaymentCubit(this._paymentUseCase) : super(const PaymentInitial());

  Future<void> initPayment({
    required String appareil,
    required String email,
    required String phoneNumber,
    required String paymentService,
    required int amount,
    required String sponsorCode,
    required String discountCode,
  }) async {
    emit(const PaymentLoading());
    try {
      final result = (await _paymentUseCase.initPayment(
          appareil: appareil,
          email: email,
          phoneNumber: phoneNumber,
          paymentService: paymentService,
          amount: amount,
          sponsorCode: sponsorCode,
          discountCode: discountCode));

      result.fold((failure) {
        emit(PaymentFailure(
            message: Utils.extractErrorMessageFromMap(failure,
                {"0": "impossible d'initier la transaction"})));
      }, (success) {
        if (success is UserEntity) {
          emit(PaymentSuccess(user: success));
        } else if (success is String) {
          emit(PaymentSuccess(transactionId: success));
        }
      });
      // print("darrel $transactionId");
    } catch (e) {
      emit(PaymentFailure(
          message: Utils.extractErrorMessageFromMap(
              e, {"0": "imapossible d'initier la transaction"})));
    }
  }

  Future<void> applyDiscountCode({required String reduceCode}) async {
    emit(const PercentStateLoading());
    log("srtange");
    try {
      final result =
          await _paymentUseCase.applyDiscountCode(reduceCode: reduceCode);
      result.fold((failure) {
        emit(PercentStateFailure(message: Utils.extractErrorMessage(failure)));
      }, (success) {
        print(success);
        emit(PercentStateSucess(percent: success));
      });
    } catch (e) {
      emit(PercentStateFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> validateSponsorCode({required String reduceCode}) async {
    emit(const PercentStateLoading());
    try {
      final result =
          await _paymentUseCase.validateSponsorCode(sponsorCode: reduceCode);
      result.fold((failure) {
        emit(PercentStateFailure(message: Utils.extractErrorMessage(failure)));
      }, (success) {
        print(success);

        emit(PercentStateSucess(percent: success));
      });
    } catch (e) {
      emit(PercentStateFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> verifying({required String transactionId}) async {
    emit(const VerifyingPaymentLoading());
    try {
      final user =
          await _paymentUseCase.verifying(transactionId: transactionId);
      user.fold((failure) {

        emit(VerifyingPaymentFailure(
          message: Utils.extractErrorMessageFromMap(failure, {
            "0": "Transaction introuvable",
            "-1": "Transaction echouee",
            "3": "Delai passe",
            "1": "Transaction en cours",
            "-2": "compte client introuvable",
            "-3": "Infos etudiant introuvable"
          }),
        ));
      }, (success) {
        emit(VerifyingPaymentSuccess(user: success!));
      });
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
