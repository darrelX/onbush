import 'package:equatable/equatable.dart';

sealed class DataState extends Equatable {
  const DataState();

  @override
  List<Object?> get props => [];
}

class DataInitial extends DataState {
  const DataInitial();

  @override
  List<Object?> get props => [];
}

class DataLoading extends DataState {
  const DataLoading();

  @override
  List<Object?> get props => [];
}

class DataFailure extends DataState {
  final String message;
  const DataFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class DataSuccess<T> extends DataState {
  final T data;
  const DataSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}
