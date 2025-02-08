import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/core/utils/utils.dart';
import 'package:onbush/presentation/views/dashboard/profil/data/models/mentee_model.dart';
import 'package:onbush/presentation/views/dashboard/profil/data/repositories/mentee_repository.dart';

part 'mentee_state.dart';

class MenteeCubit extends Cubit<MenteeState> {
  final MenteeRepository _menteeRepository = MenteeRepository();
  MenteeCubit() : super(MenteeInitial());

  Future<void> getListMentee(
      {required String email, required String appareil}) async {
    emit(MenteePending());
    try {
      final List<MenteeModel> result = await _menteeRepository.getListGetMentee(
          appareil: appareil, email: email);
      emit(MenteeSuccess(listMentees: result));
    } catch (e) {
      emit(MenteeFailure(message: Utils.extractErrorMessage(e)));
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
      final result = await _menteeRepository.editProfil(
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
      emit(EditSuccess());
    } catch (e) {
      emit(EditFailure(message: Utils.extractErrorMessage(e)));
    }
  }
}
