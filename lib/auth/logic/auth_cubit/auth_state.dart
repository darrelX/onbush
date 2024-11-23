part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

final class LoginLoading extends AuthState {}

final class LoginFailure extends AuthState {
  final String message;
  const LoginFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoginSuccess extends AuthState {
  final UserModel user;
  const LoginSuccess({required this.user});
  @override
  List<Object> get props => [user];
}

final class RegisterLoading extends AuthState {}

final class RegisterFailure extends AuthState {
  final String message;
  const RegisterFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class RegisterSuccess extends AuthState {
  const RegisterSuccess();
  @override
  List<Object> get props => [];
}

final class CheckAuthStateLoading extends AuthState {}

final class CheckAuthStateFailure extends AuthState {
  final String message;
  const CheckAuthStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CheckAuthStateSuccess extends AuthState {
  // final UserModel user;
  const CheckAuthStateSuccess();
  @override
  List<Object> get props => [];
}

final class AuthOnboardingState extends AuthState {
  const AuthOnboardingState();

  @override
  List<Object> get props => [];
}

final class SearchStateLoading extends AuthState {
  const SearchStateLoading();

  @override
  List<Object> get props => [];
}

final class SearchStateFailure extends AuthState {
  final String message;
  const SearchStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class SearchStateSuccess extends AuthState {
  final List<CollegeModel> listCollegeModel;
  final List<SpecialtieModel> listSpecialtieModel;

  const SearchStateSuccess(
      {required this.listCollegeModel, required this.listSpecialtieModel});

  @override
  List<Object> get props => [listCollegeModel, listSpecialtieModel];
}
