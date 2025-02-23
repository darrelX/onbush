part of 'application_cubit.dart';

sealed class ApplicationState extends Equatable {
  final UserEntity? user;

  // final DataState? speciality;
  const ApplicationState({this.user});

  @override
  List<Object?> get props => [user];
}

final class ApplicationStateInitial extends ApplicationState {
  const ApplicationStateInitial({super.user, });

  @override
  List<Object?> get props => [super.user, ];
}

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
