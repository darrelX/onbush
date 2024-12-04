part of 'application_cubit.dart';

class ApplicationState extends Equatable {
  final UserModel? user;
  final DataState? speciality;
  // final DataState? speciality;
  const ApplicationState({this.user, required this.speciality});

  @override
  List<Object?> get props => [user, speciality];

  ApplicationState copyWith({UserModel? user, DataState? speciality}) {
    return ApplicationState(user: user ?? this.user, speciality: speciality ?? this.speciality);
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

// final class LogoutFailure extends ApplicationState {
//   final String message;
//   const LogoutFailure({required this.message});

//   @override
//   List<Object?> get props => [super.user, message];
// }

// final class LogoutSuccess extends ApplicationState {
//   const LogoutSuccess();
//   @override
//   List<Object?> get props => [super.user];
// }

// final class LogoutLoading extends ApplicationState {
//   const LogoutLoading();
//   @override
//   List<Object?> get props => [super.user];
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
