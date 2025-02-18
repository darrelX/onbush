import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/usecases/pdf/pdf_usecase.dart';

part 'pdf_file_state.dart';

class PdfFileCubit extends Cubit<PdfFileState> {
  final PdfUseCase _pdfUseCase;
  StreamSubscription<double>? _downloadSubscription;
  final List<PdfFileEntity> listPdfFileEntity = [];

  int percent = 0;
  PdfFileCubit(this._pdfUseCase) : super(PdfFileInitial());

  Future<void> downloadAndSaveFile(
      {required String url,
      required String path,
      required String category,
      required String name}) async {
    try {
      emit(const PdfFileLoading(percent: 0));

      final result = await _pdfUseCase.downloadAndSavePdf(
          url: url, path: path, category: category, name: name);

      result.fold((failure) {
        emit(PdfFileFailed(message: failure.toString()));
      }, (success) {
        _downloadSubscription?.cancel();
        _downloadSubscription = success.listen((progress) async {
          emit(PdfFileLoading(percent: progress));
          if (progress >= 100) {
            final pdfFileEntity = await _pdfUseCase.getPdfFileByPath(path);

            pdfFileEntity.fold((failure) {
              emit(PdfFileFailed(message: failure.message));
            }, (success) {
              _downloadSubscription?.cancel();
              emit(SavePdfFileSuccess(pdfFileEntity: success));
            });
          }
        });
      });
    } catch (e) {
      emit(PdfFileFailed(message: e.toString()));
    }
  }

  Future<void> getPdfFile({int maxResults = 3}) async {
    emit(const FetchPdfFilePending());
    try {
      listPdfFileEntity.clear();
      final result = await _pdfUseCase.getAllPdfFile(maxResults: maxResults);
      result.fold((failure) {
        emit(FetchPdfFileFailure(message: failure.message));
      }, (success) {
        listPdfFileEntity.addAll(success);
        emit(FetchPdfFileSuccess(listPdfFileEntity: success));
      });
    } catch (e) {
      emit(FetchPdfFileFailure(message: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _downloadSubscription?.cancel();
    return super.close();
  }
}
