part of 'payment_cubit.dart';

sealed class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

final class PaymentInitial extends PaymentState {
  const PaymentInitial();

  @override
  List<Object> get props => [];
}

final class PaymentLoading extends PaymentState {
  const PaymentLoading();

  @override
  List<Object> get props => [];
}

final class PaymentSuccess extends PaymentState {
  final String transactionId;
  const PaymentSuccess({
    required this.transactionId,
  });

  @override
  List<Object> get props => [transactionId];
}

final class PaymentFailure extends PaymentState {
  final String message;
  const PaymentFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class VerifyingPaymentLoading extends PaymentState {
  const VerifyingPaymentLoading();

  @override
  List<Object> get props => [];
}

final class VerifyingPaymentSuccess extends PaymentState {
  final UserEntity user;
  const VerifyingPaymentSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class VerifyingPaymentFailure extends PaymentState {
  final String message;
  const VerifyingPaymentFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class PercentStateSucess extends PaymentState {
  final int percent;

  const PercentStateSucess({required this.percent});

  @override
  List<Object> get props => [percent];
}

final class PercentStateLoading extends PaymentState {
  const PercentStateLoading();

  @override
  List<Object> get props => [];
}

final class PercentStateFailure extends PaymentState {
  final String message;

  const PercentStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}
