part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpSubmitted extends OtpEvent {
  final int otp;
  final String type;
  final String device;
  final String email;
  final String? role;

  const OtpSubmitted(
      {required this.otp, required this.type, required this.device, required this.email, this.role = "etudiant"});

  @override
  List<Object> get props => [otp, device, email];
}

class OtpReset extends OtpEvent {
  final String type;
  final String device;
  final String email;

  const OtpReset(
      {required this.type, required this.device, required this.email, });
  @override
  List<Object> get props => [type, email, device,];
}

class _OtpTick extends OtpEvent {
  final int countDown;
  const _OtpTick({required this.countDown});

  @override
  List<Object> get props => [countDown];
}

class OtpInitialized extends OtpEvent {

  const OtpInitialized(
      );

  @override
  List<Object> get props => [];
}

class OtpVerification extends OtpEvent {
  final String transactionId;
  const OtpVerification({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}
