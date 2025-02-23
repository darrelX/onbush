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

final class LoginLoading extends AuthState {
  const LoginLoading();
  @override
  List<Object> get props => [];
}

final class LoginFailure extends AuthState {
  final String message;
  const LoginFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class LoginSuccess extends AuthState {
  final UserEntity user;
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

final class CheckAuthStateLoading extends AuthState {
  const CheckAuthStateLoading();

  @override
  List<Object> get props => [];
}

final class CheckAuthStateFailure extends AuthState {
  final String message;
  const CheckAuthStateFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class CheckAuthStateSuccess extends AuthState {
  final UserEntity user;
  const CheckAuthStateSuccess({required this.user});
  @override
  List<Object> get props => [user];
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
  final List<CollegeEntity> listCollegeModel;
  final List<SpecialityEntity> listSpeciality;

  const SearchStateSuccess(
      {required this.listCollegeModel, required this.listSpeciality});

  @override
  List<Object> get props => [listCollegeModel, listSpeciality];
}

final class OTpStateSuccess extends AuthState {
  final String type;
  final String email;
  const OTpStateSuccess({required this.type, required this.email});

  @override
  List<Object> get props => [type, email];
}

final class EditSuccess extends AuthState {
  @override
  List<Object> get props => [];
}

final class EditLoading extends AuthState {
  @override
  List<Object> get props => [];
}

final class EditFailure extends AuthState {
  final String message;
  const EditFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class MenteeFailure extends AuthState {
  final String message;
  const MenteeFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class MenteeSuccess extends AuthState {
  final List<MenteeEntity> listMentees;
  const MenteeSuccess({required this.listMentees});

  @override
  List<Object> get props => [listMentees];
}

final class MenteePending extends AuthState {
  @override
  List<Object> get props => [];
}

final class LogoutFailure extends AuthState {
  final String message;
  const LogoutFailure({required this.message});
  @override
  List<Object> get props => [message];
}

final class LogoutPending extends AuthState {
  @override
  List<Object> get props => [];
}

final class LogoutSuccess extends AuthState {
  @override
  List<Object> get props => [];
}
