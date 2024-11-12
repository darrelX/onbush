part of 'application_cubit.dart';

sealed class ApplicationState extends Equatable {
  final UserModel? user;
  const ApplicationState({this.user});

  @override
  List<Object?> get props => [user];
}

final class ApplicationStateInitial extends ApplicationState {
  const ApplicationStateInitial({super.user});

  @override
  List<Object?> get props => [super.user];
}

final class ApplicationStateSuccess extends ApplicationState {
  const ApplicationStateSuccess();

  
  @override
  List<Object?> get props => [super.user];
}

final class ApplicationStatePending extends ApplicationState {
  const ApplicationStatePending();

  
  @override
  List<Object?> get props => [super.user];
}

final class ApplicationStateFailure extends ApplicationState {
  const ApplicationStateFailure();

  
  @override
  List<Object?> get props => [super.user];
}