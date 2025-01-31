import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/presentation/auth/data/models/user_model.dart';
import 'package:onbush/presentation/otp_screen/logic/repositories/otp_repository.dart';
import 'package:onbush/core//utils/utils.dart';

part 'otp_state.dart';
part 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  static const int totalDuration = 90;

  final OtpRepository _repository;
  Timer? _timer;
  int _currentDuration = totalDuration;

  OtpBloc({required OtpRepository repository})
      : _repository = repository,
        super(const OtpInitial(countDown: totalDuration)) {
    on<OtpSubmitted>(_onSubmit);
    on<OtpReset>(_onReset);
    on<OtpInitialized>(_onInitialized);
    on<OtpVerification>(_onVerification);
    on<_OtpTick>(_onTick);
  }

  /// Soumission de l'OTP
  Future<void> _onSubmit(OtpSubmitted event, Emitter<OtpState> emit) async {
    if (state is OtpSentInProgress) {
      emit(OtpVerifying(countDown: state.countDown));
    }
    try {
      final result = await _repository.submit(
        type: event.type,
        email: event.email,
        code: event.otp,
        device: event.device,
        role: event.role,
      );
      result.fold((ifLeft) {
      emit( OtpVerificationSuccess(countDown: totalDuration, user: ifLeft!));

      }, (ifRight) {
      emit( const OtpVerificationSuccess(countDown: totalDuration, user: null));

      });
      _cancelTimer();
    } catch (e) {
      emit(OtpSendFailure(
        errorMessage: _mapErrorToMessage(e, {
          "0": "Confirmation introuvable",
          "-1": "Problème d'enregistrement",
        }),
        countDown: totalDuration,
      ));
    }
  }

  /// Initialisation de l'OTP
  Future<void> _onInitialized(
      OtpInitialized event, Emitter<OtpState> emit) async {
    _cancelTimer();
    // emit(const OtpLoadingState(countDown: totalDuration));
    _startTimer();
  }

  /// Vérification de l'OTP
  Future<void> _onVerification(
      OtpVerification event, Emitter<OtpState> emit) async {
    try {
      // Ajouter votre logique de vérification ici
    } catch (e) {
      emit(OtpVerificationFailure(
        errorMessage: _mapErrorToMessage(e, {
          "0": "Transaction introuvable",
          "-1": "Transaction échouée",
          "3": "Délai dépassé",
        }),
        countDown: totalDuration,
      ));
    }
  }

  /// Réinitialisation de l'OTP
  Future<void> _onReset(OtpReset event, Emitter<OtpState> emit) async {
    _cancelTimer();

    if (state is OtpExpired || state is OtpVerificationFailure) {
      // emit(const OtpVerifying(countDown: 0));
      try {
        await _repository.reSendOtp(
          type: event.type,
          device: event.device,
          email: event.email,
        );
        add(const OtpInitialized());
        // emit(OtpSentInProgress(countDown: _currentDuration));
      } catch (e) {
        emit(OtpSendFailure(
          errorMessage: _mapErrorToMessage(e, {
            "0": "Enregistrement introuvable ou code expiré",
            "-1": "Problème d'enregistrement",
          }),
          countDown: totalDuration,
        ));
      }
    }
  }

  /// Gestion du timer
  void _startTimer() {
    _currentDuration = totalDuration;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _currentDuration--;
      add(_OtpTick(countDown: _currentDuration));
    });
  }

  /// Arrêt du timer
  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  /// Tick du timer
  Future<void> _onTick(_OtpTick event, Emitter<OtpState> emit) async {
    emit(event.countDown > 0
        ? OtpSentInProgress(countDown: event.countDown)
        : const OtpExpired());

    if (event.countDown <= 0) {
      _cancelTimer();
    }
  }

  /// Fermeture du Bloc
  @override
  Future<void> close() {
    _cancelTimer();
    return super.close();
  }

  /// Utilitaire pour mapper les erreurs à des messages
  String _mapErrorToMessage(dynamic error, Map<String, String> errorMap) {
    return Utils.extractErrorMessageFromMap(error, errorMap) ??
        "Une erreur inattendue est survenue";
  }
}
