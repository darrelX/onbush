import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/presentation/auth/data/models/college_model.dart';
import 'package:onbush/presentation/auth/data/models/specialty_model.dart';
import 'package:onbush/core/application/data/models/course_model.dart';
import 'package:onbush/core/application/data/models/subject_model.dart';
import 'package:onbush/presentation/auth/data/models/user_model.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/application/cubit/data_state.dart';
import 'package:onbush/core/application/data/repositories/application_repository.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/utils/utils.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final _repository = ApplicationRepository();
  final pref = getIt.get<LocalStorage>();
  final List<CollegeModel> _listAllColleges = [];
  final List<Speciality> _listAllSpecialities = [];
  String? currentRequest;
  List<CollegeModel> get listAllColleges => _listAllColleges;
  List<Speciality> get listAllSpecialities => _listAllSpecialities;
  late UserModel _userModel;
  UserModel get userModel => _userModel;

  ApplicationCubit() : super(ApplicationState.initial());

  setUser([UserModel? user]) async {
    if (user != null) {
      _userModel = user;
      emit(ApplicationState.initial().copyWith(user: user));
      pref.setString('token', user.id!);
    }

    // emit(ApplicationStateInitial(user: user!));
  }

  //   Future<void> allColleges() async {
  //   _listAllColleges.clear();
  //   currentRequest = "colleges";
  //   emit(const SearchStateLoading());
  //   try {
  //     _listAllColleges.addAll(List.from(await _repository.allColleges()));
  //     emit(SearchStateSuccess(
  //         listCollegeModel: _listAllColleges,
  //         listSpeciality: _listAllSpecialities));
  //   } catch (e) {
  //     emit(SearchStateFailure(message: e.toString()));
  //   }
  // }

  // Future<void> allSpecialities({required int schoolId}) async {
  //   _listAllSpecialities.clear();
  //   currentRequest = "specialities";

  //   emit(const SearchStateLoading());
  //   try {
  //     _listAllSpecialities
  //         .addAll(List.from(await _repository.allSpecialities(schoolId)));

  //     emit(SearchStateSuccess(
  //         listCollegeModel: _listAllColleges,
  //         listSpeciality: _listAllSpecialities));
  //   } catch (e) {
  //     emit(SearchStateFailure(message: e.toString()));
  //   }
  // }
  Future<void> fetchSubjectModel() async {
    emit(state.copyWith(
        user: _userModel,
        listSubjectModel:
            state.listSubjectModel!.copyWith(status: Status.loading)));
    try {
      final data = await _repository.fetchListSubjectModel(
          specialityId: _userModel.majorSchoolId!);
      emit(state.copyWith(
          user: _userModel,
          listSubjectModel: state.listSubjectModel!
              .copyWith(status: Status.success, data: data)));
    } catch (e) {
      emit(state.copyWith(
          user: _userModel,
          listSubjectModel: state.listSubjectModel!.copyWith(
              status: Status.failure, error: Utils.extractErrorMessage(e))));
    }
  }

  Future<void> fetchCourseModel(
      {required int subjectId, required String category}) async {
    emit(state.copyWith(
        user: _userModel,
        listCourseModel:
            state.listCourseModel!.copyWith(status: Status.loading)));
    try {
      final data = await _repository.fetchListCourseModel(
          subjectId: subjectId, category: category);
      emit(state.copyWith(
          user: _userModel,
          listCourseModel: state.listCourseModel!
              .copyWith(status: Status.success, data: data)));
    } catch (e) {
      emit(state.copyWith(
          user: _userModel,
          listCourseModel: state.listCourseModel!.copyWith(
              status: Status.failure, error: Utils.extractErrorMessage(e))));
    }
  }

  Future<void> addSpecialty() async {
    // emit(const SpecialityLoading());
    emit(state.copyWith(
        user: _userModel,
        speciality: state.speciality.copyWith(status: Status.loading)));
    try {
      Speciality speciality =
          (await _repository.fetchSpecialitie(id: _userModel.majorSchoolId!))!;
      emit(state.copyWith(
          user: _userModel,
          speciality: state.speciality
              .copyWith(status: Status.success, data: speciality)));
    } catch (e) {
      emit(state.copyWith(
          user: _userModel,
          speciality: state.speciality.copyWith(
              status: Status.failure, error: Utils.extractErrorMessage(e))));

      // emit(SpecialityFailure(message: Utils.extractErrorMessage(e)));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(
        user: _userModel,
        loading: state.loading!.copyWith(status: Status.loading)));
    try {
      await _repository.logout(
          appareil: getIt.get<LocalStorage>().getString('device')!,
          email: _userModel.email!);

      emit(state.copyWith(
          user: _userModel,
          loading: state.loading!.copyWith(status: Status.success)));
      pref.remove('token');
    } catch (e) {
      emit(state.copyWith(
          user: _userModel,
          loading: state.loading!.copyWith(
              status: Status.failure, error: Utils.extractErrorMessage(e))));
    }
  }
}
