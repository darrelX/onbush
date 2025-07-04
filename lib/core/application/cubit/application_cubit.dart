import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/constants/images/enums/enums.dart';
import 'package:onbush/core/database/key_storage.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/database/local_storage.dart';

part 'application_state.dart';

class ApplicationCubit extends Cubit<ApplicationState> {
  final pref = getIt.get<LocalStorage>();
  // final List<CollegeModel> _listAllColleges = [];
  // final List<SpecialityModel> _listAllSpecialities = [];
  // String? currentRequest;
  // List<CollegeModel> get listAllColleges => _listAllColleges;
  // List<SpecialityModel> get listAllSpecialities => _listAllSpecialities;
  UserEntity? userEntity;

  ApplicationCubit() : super(const ApplicationStateInitial());

  setUser([UserEntity? user]) async {
    if (user != null) {
      userEntity = user;
      pref.setString('token', user.id!);
    }
  }

  // ✅ Enregistrer le genre
  Future<void> setUserGender(String gender) async {
    await pref.setString(StorageKeys.sexe, gender);
    if (gender == "male") {
      pref.setString(StorageKeys.avatar, AppImage.avatar4);
    } else {
      pref.setString(StorageKeys.avatar, AppImage.avatar6);
    }
  }

  // ✅ Récupérer le genre
  Gender getUserGender() {
    final genderStr = pref.getString(StorageKeys.sexe);
    if (genderStr == null) return Gender.male;
    return GenderExtension.fromString(genderStr);
  }

  // Future<void> fetchSubjectModel() async {
  //   emit(state.copyWith(
  //       user: userEntity,
  //       listSubjectModel:
  //           state.listSubjectModel!.copyWith(status: Status.loading)));
  //   try {
  //     final data = await _repository.fetchListSubjectModel(
  //         specialityId: userEntity!.majorSchoolId!);
  //     emit(state.copyWith(
  //         user: userEntity,
  //         listSubjectModel: state.listSubjectModel!
  //             .copyWith(status: Status.success, data: data)));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         user: userEntity,
  //         listSubjectModel: state.listSubjectModel!.copyWith(
  //             status: Status.failure, error: Utils.extractErrorMessage(e))));
  //   }
  // }

  // Future<void> fetchCourseModel(
  //     {required int subjectId, required String category}) async {
  //   emit(state.copyWith(
  //       user: userEntity,
  //       listCourseModel:
  //           state.listCourseModel!.copyWith(status: Status.loading)));
  //   try {
  //     final data = await _repository.fetchListCourseModel(
  //         subjectId: subjectId, category: category);
  //     emit(state.copyWith(
  //         user: userEntity,
  //         listCourseModel: state.listCourseModel!
  //             .copyWith(status: Status.success, data: data)));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         user: userEntity,
  //         listCourseModel: state.listCourseModel!.copyWith(
  //             status: Status.failure, error: Utils.extractErrorMessage(e))));
  //   }
  // }

  // Future<void> addSpecialty() async {
  //   // emit(const SpecialityLoading());
  //   emit(state.copyWith(
  //       user: userEntity,
  //       speciality: state.speciality.copyWith(status: Status.loading)));
  //   try {
  //     SpecialityModel speciality =
  //         (await _repository.fetchSpecialitie(id: userEntity!.majorSchoolId!))!;
  //     emit(state.copyWith(
  //         user: userEntity,
  //         speciality: state.speciality
  //             .copyWith(status: Status.success, data: speciality)));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         user: userEntity,
  //         speciality: state.speciality.copyWith(
  //             status: Status.failure, error: Utils.extractErrorMessage(e))));

  //     // emit(SpecialityFailure(message: Utils.extractErrorMessage(e)));
  //   }
  // }

  // Future<void> logout() async {
  //   emit(state.copyWith(
  //       user: userEntity,
  //       loading: state.loading!.copyWith(status: Status.loading)));
  //   try {
  //     await _repository.logout(
  //         appareil: getIt.get<LocalStorage>().getString('device')!,
  //         email: userEntity!.email!);
  //     pref.remove('token');

  //     emit(state.copyWith(
  //         user: userEntity,
  //         loading: state.loading!.copyWith(status: Status.success)));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         user: userEntity,
  //         loading: state.loading!.copyWith(
  //             status: Status.failure, error: Utils.extractErrorMessage(e))));
  //   }
  // }
}
