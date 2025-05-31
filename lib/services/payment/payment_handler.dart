import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/database/key_storage.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/shared/widget/app_snackbar.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/presentation/blocs/payment/payment_cubit.dart';
import 'package:onbush/service_locator.dart';

class PaymentHandler {
  final BuildContext context;
  final PaymentCubit paymentCubit;
  final PageController? pageController;
  final void Function(VoidCallback fn) setState;
  final void Function(bool)? setLoading;
  final void Function(int)? setAmount;
  final VoidCallback? goToApplication;
  final void Function(String transactionId)? goToPaymentPending;
  final VoidCallback? onManualRetry;
  final int maxVerificationAttempts;
  final String? transactionId;
  final void Function()? onCompleted;

  Timer? _verificationTimer;

  bool _hasShownError = false;
  bool _isVerifying = false;
  bool _isfirstTime = false;
  final String _device =
      getIt<LocalStorage>().getString(StorageKeys.deviceId) ?? "";

  PaymentHandler({
    required this.context,
    required this.paymentCubit,
    this.pageController,
    required this.setState,
    this.setLoading,
    this.setAmount,
    this.onCompleted,
    this.goToApplication,
    this.goToPaymentPending,
    this.transactionId,
    this.onManualRetry,
    this.maxVerificationAttempts = 6,
  });

  Future<void> handle(dynamic state, [String? transactionId]) async {
    switch (state.runtimeType) {
      case const (PaymentSuccess):
        await _onPaymentSuccess(state as PaymentSuccess);
        break;
      case const (PaymentFailure):
        _showError((state as PaymentFailure).message);
        break;
      case const (PercentStateFailure):
        _showError("Code de réduction incorrect");
        break;
      case const (PercentStateSucess):
        _onPercentSuccess(state as PercentStateSucess);
        break;
      case const (VerifyingPaymentFailure):
        _onVerifyingFailure(state as VerifyingPaymentFailure);
        break;
      case const (VerifyingPaymentSuccess):
        await _onVerifyingSuccess(
            state as VerifyingPaymentSuccess, transactionId);
        break;
      case const (VerifyingPaymentLoading):
        await _onVerifyingLoading(
            state as VerifyingPaymentLoading, transactionId);
        break;
    }
  }

  Future<void> _onPaymentSuccess(PaymentSuccess state) async {
    if (!context.mounted) return;
    if (state.transactionId.isNotEmpty) {
      {
        _verificationTimer?.cancel();
        _hasShownError = false;
        paymentCubit.close();
        if (context.mounted) goToPaymentPending?.call(state.transactionId);
        // _showSuccess("Vérification de la transaction en cours...");
        // await startVerificationCycle(state.transactionId!);
      }
    }
  }

  Future<void> _startVerificationCycle(
    String transactionId,
  ) async {
    int attempts = 0;

    await paymentCubit.verifying(transactionId: transactionId, device: _device);

    _verificationTimer =
        Timer.periodic(const Duration(seconds: 15), (timer) async {
      attempts++;
      await paymentCubit.verifying(
          transactionId: transactionId, device: _device);

      if (attempts >= maxVerificationAttempts) {
        timer.cancel();
        _isVerifying = false;
        _showError("La vérification a échoué. Veuillez réessayer.");
        onManualRetry?.call();
      }
    });
  }

  void _onPercentSuccess(PercentStateSucess state) {
    setState(() {
      setAmount?.call(state.percent);
      pageController?.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    });
  }

  Future<void> _onVerifyingLoading(
      VerifyingPaymentLoading state, String? transactionId) async {
    if (!context.mounted) return;
    if (!_isfirstTime) {
      await _startVerificationCycle(
        transactionId!,
      );
    }
    _isfirstTime = true;
  }

  void _onVerifyingFailure(VerifyingPaymentFailure state) {
    if (!context.mounted) return;
    if (!(_verificationTimer?.isActive ?? false)) {
      log("message");
      _showError(state.message);
    }
    // if (!_hasShownError) {
    //   _showSuccess(state.message);
    //   _hasShownError = true;
    // }
  }

  Future<void> _onVerifyingSuccess(
      VerifyingPaymentSuccess state, String? transactionId) async {
    if (!context.mounted) return;
    _verificationTimer?.cancel();
    // _isVerifying = false;
    onCompleted?.call();
    _completeTransaction(state.user, transactionId);
  }

  Future<void> _completeTransaction(
      UserEntity user, String? transactionId) async {
    context.read<ApplicationCubit>().setUser(user);
    _showSuccess("Transaction réussie");
    await Future.delayed(const Duration(milliseconds: 1000));
  }

  void _showError(String message) {
    if (context.mounted) {
      AppSnackBar.showError(message: message, context: context);
    }
  }

  void _showSuccess(String message) {
    if (context.mounted) {
      AppSnackBar.showSuccess(message: message, context: context);
    }
  }

  void dispose() {
    _verificationTimer?.cancel();
    _isVerifying = false;
  }
}
