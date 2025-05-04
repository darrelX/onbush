import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/usecases/pdf/pdf_usecase.dart';
import 'package:path_provider/path_provider.dart';

part 'pdf_file_state.dart';

class PdfFileCubit extends Cubit<PdfFileState> {
  final PdfUseCase _pdfUseCase;
  StreamSubscription<double>? _downloadSubscription;
  final List<PdfFileEntity> listPdfFileEntity = [];

  PdfFileCubit(this._pdfUseCase) : super(PdfFileInitial());

  PdfFileCubit create() {
    return PdfFileCubit(_pdfUseCase);
  }

  Future<String> _getSecurePdfPath(String category, String courseName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final pdfDirectory = Directory("${directory.path}/$category");

      // Retourne le chemin sécurisé du fichier PDF
      return '${pdfDirectory.path}/$courseName.pdf';
    } catch (e) {
      print("Erreur lors de la récupération du chemin du PDF: $e");
      return "";
    }
  }

  Future<void> downloadAndSaveFile({
    required String url,
    required String category,
    required String name,
  }) async {
    try {
      String path = await _getSecurePdfPath(category, name);
      // Vérifier si le PDF existe déjà
      final existingFile = await _pdfUseCase.getPdfFileByPath(path);

      existingFile.fold(
        (failure) async {
          // Si le fichier n'existe pas, on lance le téléchargement
          emit(const PdfFileLoading(percent: 0));

          final result = await _pdfUseCase.downloadAndSavePdf(
              url: url, path: path, category: category, name: name);

          result.fold((failure) {
            emit(PdfFileFailed(message: failure.message));
          }, (success) {
            _downloadSubscription?.cancel();
            _downloadSubscription = success.listen((progress) async {
              emit(PdfFileLoading(percent: progress));
              if (progress >= 100) {
                // final pdfFileEntity = await _pdfUseCase.getPdfFileByPath(path);

                // pdfFileEntity.fold(
                //   (failure) {
                //     emit(PdfFileFailed(message: failure.message));
                //   },
                //   (success) {
                //     _downloadSubscription?.cancel();
                //     emit(SavePdfFileSuccess(pdfFileEntity: success));
                //   },
                // );
                _downloadSubscription?.cancel();
                emit(const SavePdfFileSuccess());
              }
            }, onError: (failure) {
              print("error");
              emit(PdfFileFailed(message: failure.message));
            });
          });
        },
        (pdfFileEntity) {
          // Le fichier existe déjà, on émet directement le succès
          emit(const SavePdfFileSuccess());
        },
      );
    } catch (e) {
      emit(PdfFileFailed(message: e.toString()));
    }
  }

  Future<void> readPdfFile(
      {required String category, required String name}) async {
    try {
      String path = await _getSecurePdfPath(category, name);
      // Vérifier si le PDF existe déjà
      final existingFile =
          await _pdfUseCase.getPdfFileByPath(path, isOpened: true);
      existingFile.fold((failure) {
        emit(PdfFileFailed(message: failure.toString()));
      }, (pdfFileEntity) {
        emit(ReadPdfFileSuccess(pdfFileEntity: pdfFileEntity));
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
        final result = success
            .where((pdfFileEntity) => pdfFileEntity.isOpened == true)
            .toList();
        listPdfFileEntity.addAll(result);
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
