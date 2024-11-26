part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class OtpSubmitted extends OtpEvent {
  final int otp;
  final String device;
  final String email;
  final String? role;

  const OtpSubmitted(
      {required this.otp, required this.device, required this.email, this.role = "etudiant"});

  @override
  List<Object> get props => [otp, device, email];
}

class OtpReset extends OtpEvent {
  final String phoneNumber;
  final String email;
  final String code;

  const OtpReset(
      {required this.phoneNumber, required this.email, required this.code});
  @override
  List<Object> get props => [phoneNumber, email];
}

class _OtpTick extends OtpEvent {
  final int countDown;
  const _OtpTick({required this.countDown});

  @override
  List<Object> get props => [countDown];
}

class OtpInitialized extends OtpEvent {
  final String phoneNumber;
  final int duration;
  final String email;
  const OtpInitialized(
      {required this.phoneNumber, required this.duration, required this.email});

  @override
  List<Object> get props => [phoneNumber, duration, email];
}

class OtpVerification extends OtpEvent {
  final String transactionId;
  const OtpVerification({required this.transactionId});

  @override
  List<Object> get props => [transactionId];
}
