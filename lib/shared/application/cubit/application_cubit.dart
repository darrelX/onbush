import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/auth/data/models/user_model.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/application/repositories/application_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final _repository = ApplicationRepository();
  final pref = getIt.get<Future<SharedPreferences>>();
  ApplicationCubit() : super(const ApplicationStateInitial());

  setUser([UserModel? userModel]) async {
    final prefs = await pref;
    if (userModel != null) {
      emit(ApplicationStateInitial(user: userModel));
    }
    final user = await _repository.getUser(prefs.getString('token')!);
    emit(ApplicationStateInitial(user: user));
  }

  dynamic deposit(
      String method, int amount, int userId, String phoneNumber) async {
    try {
      final Map<String, dynamic> response = await _repository.deposit(
          method: method,
          amount: amount,
          userId: userId,
          phoneNumber: phoneNumber);
      setUser();
      if (response['status'] == 0) {
        emit(const ApplicationStatePending());
      }

      // return status['status'];
    } catch (e) {
      emit(const ApplicationStateFailure());
    }
  }

  logout() async {
    final SharedPreferences prefs =
        await getIt.get<Future<SharedPreferences>>();
    prefs.remove('token');
  }
}
