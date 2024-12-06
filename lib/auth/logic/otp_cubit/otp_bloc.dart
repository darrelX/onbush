import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/auth/data/repositories/otp_repository.dart';
import 'package:onbush/shared/utils/utils.dart';

part 'otp_state.dart';
part 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;
  static const int totalDuration = 90;
  final OtpRepository _repository;
  int _currentDuration = totalDuration;

  OtpBloc()
      : _repository = OtpRepository(),
        super(const OtpInitial(countDown: totalDuration)) {
    _startTimer();
    on<OtpSubmitted>(_onSubmit);
    on<OtpReset>(_onReset);
    on<OtpInitialized>(_onInitialized);
    on<OtpVerification>(_onVerification);
    on<_OtpTick>(_onTick); // Utilisation d'un event spécifique au timer
  }

  Future<void> _onSubmit(OtpSubmitted event, Emitter<OtpState> emit) async {
    if (state is OtpSentInProgress) {
      emit(OtpVerifying(countDown: state.countDown));
    }
    try {
      await _repository.submit(
        type: event.type,
          email: event.email,
          code: event.otp,
          device: event.device,
          role: event.role);
      // if (status) {
      //   _timer?.cancel();
      emit(const OtpVerificationSuccess(countDown: totalDuration));
      // } else {
      //   emit(const OtpVerificationFailure(
      //       errorMessage: 'Echec', countDown: totalDuration));
      // }
    } catch (e) {
      emit(OtpSendFailure(
          errorMessage: Utils.extractErrorMessageFromMap(e, {
            "0": "Confirmation introuvable",
            "-1": "Probleme d'enregistrement"
          }),
          countDown: totalDuration));
    }
  }

  Future<void> _onVerification(
      OtpVerification event, Emitter<OtpState> emit) async {
    try {
      // await _repository.
    } catch (e) {
      emit(OtpVerificationFailure(
          errorMessage: Utils.extractErrorMessageFromMap(e, {
            "0": "Transaction introuvable",
            "-1": "Transaction echouee",
            "3": "Delai passe",
            "1": "Transaction en cours",
            "-2": "compte client introuvable",
            "-3": "Infos etudiant introuvable"
          }),
          countDown: totalDuration));
    }
  }

  Future<void> _onInitialized(
      OtpInitialized event, Emitter<OtpState> emit) async {
    _timer?.cancel();
    emit(const OtpLoadingState(countDown: totalDuration));
    _startTimer();
  }

  void _startTimer() {
    _currentDuration = totalDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDuration--;
      add(_OtpTick(countDown: _currentDuration));
      // }
    });
  }

  Future<void> _onTick(_OtpTick event, Emitter<OtpState> emit) async {
    emit(event.countDown > 0
        ? OtpSentInProgress(countDown: event.countDown)
        : const OtpExpired());
    if (event.countDown <= 0) {
      _timer?.cancel();
    }
  }

  Future<void> _onReset(OtpReset event, Emitter<OtpState> emit) async {
    _timer?.cancel();

    if (state is OtpExpired || state is OtpVerificationFailure) {
      emit(const OtpVerifying(countDown: 0));
      try {
        await _repository.reSendOtp(
            type: event.type,
            device: event.device,
            email: event.email,
            code: event.code);
        _startTimer();
        emit(OtpSentInProgress(countDown: _currentDuration));
      } catch (e) {
        emit(OtpSendFailure(
            errorMessage: Utils.extractErrorMessageFromMap(e, {
              "0": "enregistrement introuvable ou code expiré",
              "-1": "	Un problème d'enregistrement est survenu"
            }),
            countDown: totalDuration));
      }
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
