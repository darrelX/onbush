import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/core/utils/utils.dart';
import 'package:onbush/presentation/dashboard/profil/data/models/mentee_model.dart';
import 'package:onbush/presentation/dashboard/profil/data/repositories/mentee_repository.dart';

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
}
