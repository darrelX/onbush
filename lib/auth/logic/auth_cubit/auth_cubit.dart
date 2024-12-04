import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/auth/data/models/college_model.dart';
import 'package:onbush/auth/data/models/specialty_model.dart';
import 'package:onbush/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/auth/data/repositories/auth_repository.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/local/local_storage.dart';
import 'package:onbush/shared/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  final LocalStorage _prefs;
  final List<CollegeModel> _listAllColleges = [];
  final List<Speciality> _listAllSpecialities = [];
  String? currentRequest;

  List<CollegeModel> get listAllColleges => _listAllColleges;
  List<Speciality> get listAllSpecialities => _listAllSpecialities;

  AuthCubit()
      : _repository = AuthRepository(),
        _prefs = getIt.get<LocalStorage>(),
        super(const AuthInitial());

  Future<void> login({
    required String appareil,
    required String email,
  }) async {
    emit(const LoginLoading());
    try {
      var user = await _repository.login(
        appareil: appareil,
        email: email,
      );
      emit(LoginSuccess(user: user!));
    } on DioException catch (e) {
      emit(LoginFailure(
          message: Utils.extractErrorMessageFromMap(
              e, {"0": "telephone ou pass incorrest", "-1": "compte bloque"})));
      // rethrow;
    }
  }

  Future<void> register({
    required String name,
    required String device,
    required String phone,
    required String academiclevel,
    required String role,
    required int academicLevel,
    required int majorStudy,
    required int schoolId,
    required String studentId,
    required String email,
    required String birthDate,
    required String gender,
  }) async {
    try {
      emit(RegisterLoading());
      await _repository.register(
        username: name,
        email: email,
        birthDate: birthDate,
        gender: gender,
        phone: phone,
        device: device,
        studentId: studentId,
        academicLevel: academicLevel,
        schoolId: schoolId,
        majorStudy: majorStudy,
        role: role,
      );
      emit(const RegisterSuccess());
    } on DioException catch (e) {
      // print(e);
      emit(RegisterFailure(
          message: Utils.extractErrorMessageFromMap(e, {
        "0": "Un probleme est survenu",
        "-1": "Email deja utilise",
        "-2": "Telephone deja utilise",
        "-3": "Utilisateur non reconnu"
      })));
    }
  }

  Future<void> checkAuthState() async {
    // final storage = await _repository.prefs!;
    final String? token = _prefs.getString('token');

    try {
      emit(const CheckAuthStateLoading());

      if (token != null) {
      } else if (token == null) {
        emit(const AuthOnboardingState());
      } else {
        emit(CheckAuthStateFailure(
            message: Utils.extractErrorMessage('User is not authenticated')));
      }
    } on DioException catch (e) {
      emit(CheckAuthStateFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> connexion() async {
    final String? token = _prefs.getString('device');
    emit(const CheckAuthStateLoading());
    try {
      if (token == null) {
        emit(const AuthOnboardingState());
      } else {
        UserModel user = (await _repository.connexion(appareil: token))!;
        emit(CheckAuthStateSuccess(user: user));
      }
    } on DioException catch (e) {
      emit(CheckAuthStateFailure(message: Utils.extractErrorMessage(e)));
    }
    // emit(const ConnexionSuccess());
  }

  Future<void> allColleges() async {
    _listAllColleges.clear();
    currentRequest = "colleges";
    emit(const SearchStateLoading());
    try {
      _listAllColleges.addAll(List.from(await _repository.allColleges()));
      emit(SearchStateSuccess(
          listCollegeModel: _listAllColleges,
          listSpeciality: _listAllSpecialities));
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }

  Future<void> allSpecialities({required int schoolId}) async {
    _listAllSpecialities.clear();
    currentRequest = "specialities";

    emit(const SearchStateLoading());
    try {
      _listAllSpecialities
          .addAll(List.from(await _repository.allSpecialities(schoolId)));

      emit(SearchStateSuccess(
          listCollegeModel: _listAllColleges,
          listSpeciality: _listAllSpecialities));
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }
}
