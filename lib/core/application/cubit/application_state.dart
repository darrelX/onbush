part of 'application_cubit.dart';

class ApplicationState extends Equatable {
  final UserEntity? user;
  final DataState<SpecialityModel> speciality;
  final DataState<List<SubjectModel>>? listSubjectModel;
  final DataState<List<CourseModel>>? listCourseModel;
  final DataState<void>? loading;
  // final DataState? speciality;
  const ApplicationState(
      {this.user,
      required this.loading,
      required this.speciality,
      required this.listSubjectModel,
      required this.listCourseModel});

  @override
  List<Object?> get props =>
      [user, speciality, listSubjectModel, listCourseModel, loading];

  ApplicationState copyWith(
      {UserEntity? user,
      DataState<SpecialityModel>? speciality,
      DataState<void>? loading,
      DataState<List<CourseModel>>? listCourseModel,
      DataState<List<SubjectModel>>? listSubjectModel}) {
    return ApplicationState(
      loading: loading ?? this.loading,
        listSubjectModel: listSubjectModel ?? this.listSubjectModel,
        user: user ?? this.user,
        listCourseModel: listCourseModel ?? this.listCourseModel,
        speciality: speciality ?? this.speciality);
  }

  static ApplicationState initial() {
    return ApplicationState
    (
      loading: DataState<void>(),
        listCourseModel: DataState<List<CourseModel>>(),
        user: null,
        speciality: DataState<SpecialityModel>(),
        listSubjectModel: DataState<List<SubjectModel>>());
  }
}

// final class ApplicationStateInitial extends ApplicationState {
//   const ApplicationStateInitial({super.user, super.speciality});

//   @override
//   List<Object?> get props => [super.user, super.speciality];
// }

// final class ApplicationStateSuccess extends ApplicationState {
//   const ApplicationStateSuccess({super.user, super.speciality});

//   @override
//   List<Object?> get props => [super.user, super.speciality];
// }

// final class ApplicationStatePending extends ApplicationState {
//   const ApplicationStatePending({super.user, super.speciality});

//   @override
//   List<Object?> get props => [super.user, super.speciality];
// }

// final class ApplicationStateFailure extends ApplicationState {
//   const ApplicationStateFailure({super.user, super.speciality});

//   @override
//   List<Object?> get props => [super.user, super.speciality];
// }



// final class SpecialityLoading extends ApplicationState {
//   const SpecialityLoading();

//   @override
//   List<Object?> get props => [super.user];
// }

// final class SpecialityFailure extends ApplicationState {
//   final String message;
//   const SpecialityFailure({required this.message});

//   @override
//   List<Object?> get props => [super.user, message];
// }

// final class SpecialitySuccess extends ApplicationState {
//   final Speciality speciality;
//   const SpecialitySuccess({required this.speciality});

//   @override
//   List<Object?> get props => [super.user, speciality];
// }
