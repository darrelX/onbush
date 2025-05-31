import 'package:equatable/equatable.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/database/key_storage.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';
import 'package:onbush/domain/entities/mentee/mentee_entity.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/usecases/academic/academic_usecase.dart';
import 'package:onbush/domain/usecases/auth/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core//utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LocalStorage _prefs;
  final AuthUseCase _authUseCase;
  final AcademyUsecase _academyUsecase;
  final List<CollegeEntity> _listAllColleges = [];
  final List<SpecialityEntity> _listAllSpecialities = [];
  String? currentRequest;

  List<CollegeEntity> get listAllColleges => _listAllColleges;
  List<SpecialityEntity> get listAllSpecialities => _listAllSpecialities;

  final ApplicationCubit _applicationCubit = getIt<ApplicationCubit>();

  AuthCubit(this._authUseCase, this._academyUsecase)
      : _prefs = getIt.get<LocalStorage>(),
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
      result.fold((failure) {
        emit(LoginFailure(
            message: Utils.extractErrorMessageFromMap(
                failure, {"0": "compte introuvable", "-1": "compte bloqué"})));
      }, (success) {
        if (success is String) {
          emit(OTpStateSuccess(email: email, type: 'login'));
        } else {
          emit(LoginSuccess(user: success!));
        }
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
        academyLevel: academyLevel,
        schoolId: schoolId,
        majorStudy: majorStudy,
        role: role,
      );

      result.fold((failure) {
        emit(RegisterFailure(
            message: Utils.extractErrorMessageFromMap(failure, {
          "0": "Un probleme est survenu",
          "-1": "Email deja utilise",
          "-2": "Telephone deja utilise",
          "-3": "Utilisateur non reconnu"
        })));
      }, (success) {
        emit(const RegisterSuccess());
      });
    } catch (e) {
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
        user.fold((failure) {
          emit(CheckAuthStateFailure(
              message: Utils.extractErrorMessageFromMap(failure, {
            "0": "Un probleme est survenu",
            "-1": "Email déjà utilisé",
            "-2": "Téléphone déjà utilisé",
            "-3": "Utilisateur non reconnu"
          })));
        }, (success) {
          emit(CheckAuthStateSuccess(user: success!));
        });
      }
    } catch (e) {
      emit(CheckAuthStateFailure(
          message: Utils.extractErrorMessageFromMap(e, {
        "0": "Un probleme est survenu",
        "-1": "Email déjà utilisé",
        "-2": "Téléphone déjà utilisé",
        "-3": "Utilisateur non reconnu"
      })));
    }
    // emit(const ConnexionSuccess());
  }

  Future<void> allColleges() async {
    _listAllColleges.clear();
    currentRequest = "colleges";
    emit(const SearchStateLoading());
    try {
      final result = await _academyUsecase.getAllColleges();
      result.fold((failure) {
        emit(SearchStateFailure(message: failure.message));
      }, (success) {
        _listAllColleges.addAll(List.from(success));
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
          await _academyUsecase.getAllSpecialities(schoolId: schoolId);
      result.fold((failure) {
        emit(SearchStateFailure(message: failure.message));
      }, (success) {
        _listAllSpecialities.addAll(List.from(success));
        emit(SearchStateSuccess(
            listCollegeModel: _listAllColleges,
            listSpeciality: _listAllSpecialities));
      });
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }

  Future<void> editProfil(
      {required String device,
      required String studentId,
      required String name,
      required String gender,
      required String avatar,
      required String phone,
      required String level,
      required String language,
      required String email,
      required String birthday,
      required String role}) async {
    emit(EditLoading());
    try {
      final result = await _authUseCase.editProfil(
        device: device,
        studentId: studentId,
        birthday: birthday,
        name: name,
        gender: gender,
        phone: phone,
        level: level,
        language: language,
        avatar: avatar,
        email: email,
        role: role,
      );
      result.fold((failure) {
        emit(EditFailure(message: Utils.extractErrorMessage(failure)));
      }, (sucess) {
        _applicationCubit.userEntity = _applicationCubit.userEntity?.copyFrom(
          id: device,
          studentId: studentId,
          birthday: birthday,
          name: name,
          gender: gender,
          phoneNumber: phone,
          academyLevel: int.parse(level),
          language: language,
          avatar: avatar,
          email: email,
          role: role,
        );
        emit(EditSuccess());
      });
    } catch (e) {
      emit(EditFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> getListMentee(
      {required String email, required String device}) async {
    emit(MenteePending());
    try {
      final result =
          await _authUseCase.getAllMentees(device: device, email: email);
      result.fold((failure) {
        emit(MenteeFailure(message: Utils.extractErrorMessage(failure)));
      }, (success) {
        emit(MenteeSuccess(listMentees: success));
      });
    } catch (e) {
      emit(MenteeFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> logout() async {
    emit(LogoutPending());
    try {
      final result = await _authUseCase.logout(
          device: getIt.get<LocalStorage>().getString('device')!,
          email: _applicationCubit.userEntity!.email!);
      result.fold((failure) {
        emit(LogoutFailure(message: failure.message));
      }, (success) async {
        await _prefs.remove(StorageKeys.authToken);
        await _prefs.remove(StorageKeys.pdfFile);
        emit(LogoutSuccess());
      });
    } catch (e) {
      emit(LogoutFailure(message: e.toString()));
    }
  }
}
