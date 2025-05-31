import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/usecases/pdf/pdf_usecase.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_manager/pdf_manager_cubit.dart';
import 'package:path_provider/path_provider.dart';

part 'pdf_file_state.dart';

class PdfFileCubit extends Cubit<PdfFileState> {
  final PdfUseCase _pdfUseCase;
  StreamSubscription<double>? _downloadSubscription;
  final List<PdfFileEntity> listPdfFileEntity = [];
  final PdfManagerCubit _pdfManagerCubit; // 👈 Injecte-le ici

  PdfFileCubit(this._pdfUseCase, this._pdfManagerCubit)
      : super(PdfFileInitial());

  Future<String> _getSecurePdfPath({
    required String category,
    required String courseName,
  }) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final pdfDirectory = Directory("${directory.path}/$category");

      // Retourne le chemin sécurisé du fichier PDF
      return '${pdfDirectory.path}/$courseName.pdf';
    } catch (e) {
      return "";
    }
  }

  Future<void> downloadAndSaveFile({
    required String url,
    required String category,
    required String name,
    required String id,
  }) async {
    try {
      String path =
          await _getSecurePdfPath(category: category, courseName: name);
      // Vérifier si le PDF existe déjà
      final existingFile = await _pdfUseCase.getPdfFileByPath(path);

      existingFile.fold(
        (failure) async {
          // Si le fichier n'existe pas, on lance le téléchargement
          emit(const PdfFileLoading(percent: 0));

          final result = await _pdfUseCase.downloadAndSavePdf(
              id: id, url: url, path: path, category: category, name: name);

          result.fold((failure) {
            emit(PdfFileFailed(message: failure.message));
          }, (success) {
            _downloadSubscription?.cancel();
            _downloadSubscription = success.listen((progress) async {
              emit(PdfFileLoading(percent: progress));
              if (progress >= 100) {
                _downloadSubscription?.cancel();
                emit(const SavePdfFileSuccess());
              }
            }, onError: (failure) {
              emit(PdfFileFailed(message: failure.message));
            });
          });
        },
        (pdfFileEntity) async {
          await _pdfManagerCubit.loadAll();
          // Le fichier existe déjà, on émet directement le succès
          emit(const SavePdfFileSuccess());
        },
      );
    } catch (e) {
      emit(PdfFileFailed(message: e.toString()));
    }
  }

  Future<void> readPdfFile(
      {required String category,
      required String name,
      required String id}) async {
    try {
      String path =
          await _getSecurePdfPath(category: category, courseName: name);
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

  Future<void> readLocalPdfFile({required PdfFileEntity pdfFileEntity}) async {
    try {
      print("Reading PDF file: ${pdfFileEntity}");
      final existingFile = await _pdfUseCase
          .getPdfFileByPath(pdfFileEntity.filePath!, isOpened: true);

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
        _pdfManagerCubit.loadAll();

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
