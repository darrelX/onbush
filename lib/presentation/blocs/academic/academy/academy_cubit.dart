import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/usecases/academic/academic_usecase.dart';
import 'package:onbush/service_locator.dart';

part 'academy_state.dart';

class AcademyCubit extends Cubit<AcademyState> {
  final AcademyUsecase _academyUsecase;
  AcademyCubit(this._academyUsecase) : super(AcademyInitial());

  final List<CollegeEntity> _listAllColleges = [];
  final List<SpecialityEntity> _listAllSpecialities = [];
  final List<SubjectEntity> _listSubjectEntity = [];
  final List<CourseEntity> _listCourseEntity = [];

  String? currentRequest;

  List<CollegeEntity> get listAllColleges => _listAllColleges;
  List<SpecialityEntity> get listAllSpecialities => _listAllSpecialities;
  List<SubjectEntity> get listSubjectEntity => _listSubjectEntity;
  List<CourseEntity> get listCourseEntity => _listCourseEntity;

  final UserEntity? userEntity = getIt<ApplicationCubit>().userEntity;

  Future<void> allColleges() async {
    _listAllColleges.clear();
    currentRequest = "colleges";
    emit(const SearchStateLoading());

    try {
      final result = await _academyUsecase.getAllColleges();
      result.fold(
        (failure) => emit(SearchStateFailure(message: failure.message)),
        (colleges) {
          _listAllColleges.addAll(colleges);
          emit(SearchStateSuccess(
            listCollegeEntity: _listAllColleges,
            listSpeciality: _listAllSpecialities,
          ));
        },
      );
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
      result.fold(
        (failure) => emit(SearchStateFailure(message: failure.message)),
        (specialities) {
          _listAllSpecialities.addAll(specialities);
          emit(SearchStateSuccess(
            listCollegeEntity: _listAllColleges,
            listSpeciality: _listAllSpecialities,
          ));
        },
      );
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }

  Future<void> fetchSubjectEntity() async {
    _listSubjectEntity.clear();
    emit(const SubjectStateLoading());

    try {
      final result = await _academyUsecase.getSubjectByspecialityId(
          specialityId: userEntity!.majorSchoolId!);
      result.fold(
        (failure) => emit(SubjectStateFailure(message: failure.message)),
        (subjects) {
          _listSubjectEntity.addAll(subjects);
          emit(SubjectStateSuccess(listSubjectEntity: _listSubjectEntity));
        },
      );
    } catch (e) {
      emit(SubjectStateFailure(message: e.toString()));
    }
  }

  Future<void> fetchCourseEntity(
      {required int subjectId, required String category}) async {
    listCourseEntity.clear();
    emit(const CourseStateLoading());

    try {
      final result = await _academyUsecase.getAllCourses(
          subjectId: subjectId, category: category);
      result.fold(
        (failure) => emit(CourseStateFailure(message: failure.message)),
        (courses) {
          listCourseEntity.addAll(courses);
          emit(CourseStateSuccess(listCourseEntity: _listCourseEntity));
        },
      );
    } catch (e) {
      emit(CourseStateFailure(message: e.toString()));
    }
  }

  Future<void> addSpecialty({required int majorSchoolId}) async {
    emit(const SearchStateLoading());

    try {
      final result =
          await _academyUsecase.getSpecialityById(specialityId: majorSchoolId);
      result.fold(
        (failure) => emit(SearchStateFailure(message: failure.message)),
        (speciality) {
          _listAllSpecialities.add(speciality);
          emit(SearchStateSuccess(
            listCollegeEntity: _listAllColleges,
            listSpeciality: _listAllSpecialities,
          ));
        },
      );
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }

}
