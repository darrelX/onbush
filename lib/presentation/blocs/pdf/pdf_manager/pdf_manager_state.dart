part of 'pdf_manager_cubit.dart';

sealed class PdfManagerState extends Equatable {
  const PdfManagerState();

  @override
  List<Object> get props => [];
}

class PdfManagerInitial extends PdfManagerState {
  @override
  List<Object> get props => [];
}

class PdfManagerLoading extends PdfManagerState {
  @override
  List<Object> get props => [];
}

class PdfManagerLoaded extends PdfManagerState {
  final List<PdfFileEntity> filtered;
  final List<PdfFileEntity> all;

  const PdfManagerLoaded({required this.filtered, required this.all});

  @override
  List<Object> get props => [filtered, all];
}

class PdfManagerError extends PdfManagerState {
  final String message;

  const PdfManagerError({required this.message});

  @override
  List<Object> get props => [message];
}

class PdfManagerEmpty extends PdfManagerState {
  final String message;

  const PdfManagerEmpty({required this.message});

  @override
  List<Object> get props => [message];
}
