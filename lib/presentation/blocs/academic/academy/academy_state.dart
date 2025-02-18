part of 'academy_cubit.dart';

sealed class AcademyState extends Equatable {
  const AcademyState();

  @override
  List<Object> get props => [];
}

final class AcademyInitial extends AcademyState {}

final class SearchStateSuccess extends AcademyState {
  final List<CollegeEntity> listCollegeEntity;
  final List<SpecialityEntity> listSpeciality;

  const SearchStateSuccess(
      {required this.listCollegeEntity, required this.listSpeciality});

  @override
  List<Object> get props => [listCollegeEntity, listSpeciality];
}

final class SearchStateLoading extends AcademyState {
  const SearchStateLoading();

  @override
  List<Object> get props => [];
}

final class SearchStateFailure extends AcademyState {
  final String message;
  const SearchStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class SubjectStateSuccess extends AcademyState {
  final List<SubjectEntity> listSubjectEntity;
  const SubjectStateSuccess({required this.listSubjectEntity});

  @override
  List<Object> get props => [listSubjectEntity];
}

final class SubjectStateLoading extends AcademyState {
  const SubjectStateLoading();

  @override
  List<Object> get props => [];
}

final class SubjectStateFailure extends AcademyState {
  final String message;

  const SubjectStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CourseStateSuccess extends AcademyState {
  final List<CourseEntity> listCourseEntity;
  const CourseStateSuccess({required this.listCourseEntity});

  @override
  List<Object> get props => [listCourseEntity];
}

final class CourseStateLoading extends AcademyState {
  const CourseStateLoading();

  @override
  List<Object> get props => [];
}

final class CourseStateFailure extends AcademyState {
  final String message;

  const CourseStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}
