import 'package:equatable/equatable.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/usecases/academic/academic_usecase.dart';
import 'package:onbush/domain/usecases/auth/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/presentation/views/auth/data/repositories/auth_repository.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core//utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _repository;
  final LocalStorage _prefs;
  final AuthUseCase _authUseCase;
  final AcademyUsecase _AcademyUsecase;
  final List<CollegeEntity> _listAllColleges = [];
  final List<SpecialityEntity> _listAllSpecialities = [];
  String? currentRequest;

  List<CollegeEntity> get listAllColleges => _listAllColleges;
  List<SpecialityEntity> get listAllSpecialities => _listAllSpecialities;

  AuthCubit(this._authUseCase, this._AcademyUsecase)
      : _repository = AuthRepository(),
        _prefs = getIt.get<LocalStorage>(),
        super(const AuthInitial());

  Future<void> login({
    required String appareil,
    required String email,
  }) async {
    emit(const LoginLoading());
    try {
      final result = await _authUseCase.login(
        device: appareil,
        email: email,
      );
      result.fold((ifLeft) {
        emit(OTpStateSuccess(email: email, type: 'login'));
      }, (ifRight) {
        emit(LoginSuccess(user: ifRight!));
      });
    } catch (e) {
      emit(LoginFailure(
          message: Utils.extractErrorMessageFromMap(
              e, {"0": "telephone ou pass incorrect", "-1": "compte bloque"})));
      // rethrow;
    }
  }

  Future<void> register({
    required String name,
    required String device,
    required String phone,
    required String role,
    required int academyLevel,
    required int majorStudy,
    required int schoolId,
    required String studentId,
    required String email,
    required String birthDate,
    required String gender,
  }) async {
    try {
      emit(RegisterLoading());

      final result = await _authUseCase.registerUser(
        username: name,
        email: email,
        birthDate: birthDate,
        gender: gender,
        phone: phone,
        device: device,
        studentId: studentId,
      academyLevel :academyLevel,
        schoolId: schoolId,
        majorStudy: majorStudy,
        role: role,
      );

      result.fold((ifLeft) {
        emit(RegisterFailure(
            message: Utils.extractErrorMessageFromMap(ifLeft, {
          "0": "Un probleme est survenu",
          "-1": "Email deja utilise",
          "-2": "Telephone deja utilise",
          "-3": "Utilisateur non reconnu"
        })));
      }, (ifRight) {
        emit(const RegisterSuccess());
      });
    } catch (e) {
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
    } catch (e) {
      emit(CheckAuthStateFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> connexion() async {
    final String? token = _prefs.getString('token');
    emit(const CheckAuthStateLoading());
    try {
      if (token == null || token.isEmpty) {
        emit(const AuthOnboardingState());
      } else {
        final user = (await _authUseCase.connexion(
            device: getIt.get<LocalStorage>().getString('device')!));
        user.fold((ifLeft) {
          emit(CheckAuthStateFailure(
              message: Utils.extractErrorMessage(ifLeft.message)));
        }, (ifRight) {
          emit(CheckAuthStateSuccess(user: ifRight!));
        });
      }
    } catch (e) {
      emit(CheckAuthStateFailure(message: Utils.extractErrorMessage(e)));
    }
    // emit(const ConnexionSuccess());
  }

  Future<void> allColleges() async {
    _listAllColleges.clear();
    currentRequest = "colleges";
    emit(const SearchStateLoading());
    try {
      final result = await _AcademyUsecase.getAllColleges();
      result.fold((ifLeft) {
        emit(SearchStateFailure(message: ifLeft.message));
      }, (ifRight) {
        _listAllColleges.addAll(List.from(ifRight));
        emit(SearchStateSuccess(
            listCollegeModel: _listAllColleges,
            listSpeciality: _listAllSpecialities));
      });
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }

  Future<void> allSpecialities({required int schoolId}) async {
    _listAllSpecialities.clear();
    currentRequest = "specialities";

    emit(const SearchStateLoading());
    try {
      final result =
          await _AcademyUsecase.getAllSpecialities(schoolId: schoolId);
      result.fold((ifLeft) {
        emit(SearchStateFailure(message: ifLeft.message));
      }, (ifRight) {
        _listAllSpecialities.addAll(List.from(ifRight));
        emit(SearchStateSuccess(
            listCollegeModel: _listAllColleges,
            listSpeciality: _listAllSpecialities));
      });
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }
}
