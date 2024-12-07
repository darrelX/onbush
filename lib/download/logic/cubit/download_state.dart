part of 'download_cubit.dart';

sealed class DownloadState extends Equatable {
  const DownloadState();

  @override
  List<Object> get props => [];
}

final class DownloadInitial extends DownloadState {}

final class DownloadFailure extends DownloadState {
  final String message;
  const DownloadFailure({required this.message});

    @override
  List<Object> get props => [message];
}

final class DownloadSuccess extends DownloadState {
  final List<PdfFileModel> listPdfModel;
  const DownloadSuccess({required this.listPdfModel});

    @override
  List<Object> get props => [listPdfModel];

}

final class DownloadLoading extends DownloadState {
  const DownloadLoading();

    @override
  List<Object> get props => [];
}
