part of 'pdf_file_cubit.dart';

sealed class PdfFileState extends Equatable {
  const PdfFileState();

  @override
  List<Object> get props => [];
}

final class PdfFileInitial extends PdfFileState {}

final class PdfFileLoading extends PdfFileState {
  final double percent;
  const PdfFileLoading({required this.percent});

  @override
  List<Object> get props => [percent];
}

final class SavePdfFileSuccess extends PdfFileState {
  final PdfFileEntity pdfFileEntity;
  const SavePdfFileSuccess({required this.pdfFileEntity});

  @override
  List<Object> get props => [pdfFileEntity];
}

final class PdfFileFailed extends PdfFileState {
  final String message;
  const PdfFileFailed({required this.message});

  @override
  List<Object> get props => [message];
}

final class FetchPdfFilePending extends PdfFileState {
  const FetchPdfFilePending();

  @override
  List<Object> get props => [];
}

final class FetchPdfFileSuccess extends PdfFileState {
  final List<PdfFileEntity> listPdfFileEntity;
  const FetchPdfFileSuccess({required this.listPdfFileEntity});

  @override
  List<Object> get props => [listPdfFileEntity];
}

final class FetchPdfFileFailure extends PdfFileState {
  final String message;
  const FetchPdfFileFailure({required this.message});

  @override
  List<Object> get props => [message];
}
