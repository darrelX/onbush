part of 'network_cubit.dart';

 class NetworkState extends Equatable {
  final Status status;
  const NetworkState({required this.status});

  @override
  List<Object?> get props => [status];
}


