import 'package:equatable/equatable.dart';
import 'package:onbush/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/auth/data/repositories/auth_repository.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/utils/utils.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository = getIt.get<AuthRepository>();
  // final prefs = getIt.get<Future<SharedPreferences>>();

  AuthCubit() : super(const AuthInitial());

  login({
    required String phone,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      var user = await repository.login(
        phone: phone,
        password: password,
      );
      emit(LoginSuccess(user: user!));
    } catch (e) {
      emit(LoginFailure(message: Utils.extractErrorMessage(e)));
      rethrow;
    }
  }

  register({
    required String name,
    required String email,
    required DateTime birthDate,
    required int gender,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());
      var user = await repository.register(
        username: name,
        email: email,
        birthDate: birthDate,
        gender: gender,
        phone: phoneNumber,
        password: password,
      );
      emit(RegisterSuccess(user: user!));
    } catch (e) {
      print(e);
      emit(RegisterFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> checkAuthState() async {
    final storage = await repository.prefs!;
    final token = storage.getString('token');
    try {
      emit(CheckAuthStateLoading());
      if (token != null || token!.isEmpty) {
        var user = await repository.getUser();
        emit(CheckAuthStateSuccess(user: user!));
      } else {
        emit(CheckAuthStateFailure(
            message: Utils.extractErrorMessage('User is not authenticated')));
      }
    } catch (e) {
      emit(CheckAuthStateFailure(message: Utils.extractErrorMessage(e)));
    }
  }
}
