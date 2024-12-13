part of 'mentee_cubit.dart';

sealed class MenteeState extends Equatable {
  const MenteeState();

  @override
  List<Object> get props => [];
}

final class MenteeInitial extends MenteeState {}

final class MenteeFailure extends MenteeState {
  final String message;
  const MenteeFailure({required this.message});

  @override
  List<Object> get props => [message];
}

final class MenteeSuccess extends MenteeState {
  final List<MenteeModel> listMentees;
  const MenteeSuccess({required this.listMentees});

  @override
  List<Object> get props => [listMentees];
}

final class MenteePending extends MenteeState {
  @override
  List<Object> get props => [];
}
