import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/repositories/pdf/pdf_repository.dart';

class PdfUseCase {
  final PdfRepository _pdfRepository;

  PdfUseCase(this._pdfRepository);

  /// Télécharge un PDF et le sauvegarde automatiquement après un succès.
  Future<Either<NetworkException, Stream<double>>> downloadAndSavePdf({
    required String url,
    required String path,
    required String category,
    required String name,
  }) async {
    try {
      print("Début du téléchargement...");

      final downloadResult =
          await _pdfRepository.downloadPdf(url: url, path: path);

      return downloadResult.fold(
        (failure) {
          print("Échec du téléchargement (downloadPdf renvoie une erreur)");
          return Left(failure);
        },
        (progressStream) {
          final StreamController<double> controller =
              StreamController<double>();

          try {
            progressStream.listen(
              (progress) async {
                print("Progression: $progress%");
                controller.add(progress);

                if (progress >= 100.0) {
                  print("Téléchargement terminé, sauvegarde en cours...");

                  final saveResult = await _pdfRepository.savePdfFileByPath(
                    filePath: path,
                    name: name,
                    category: category,
                  );

                  saveResult.fold(
                    (failure) {
                      print("Erreur lors de la sauvegarde : $failure");
                      controller.addError(failure);
                      controller.close();
                    },
                    (_) {
                      print("Sauvegarde réussie !");
                      controller.close();
                    },
                  );
                }
              },
              onError: (error) {
                print("Erreur détectée dans le Stream : $error");
                controller.addError(
                    NetworkException.errorFrom(error));
                controller.close();
                return Left(NetworkException.errorFrom(error));
              },
              onDone: () {
                print("Téléchargement terminé avec succès.");
                controller.close();
              },
              cancelOnError:
                  true, // Ferme automatiquement le stream en cas d'erreur
            );
          } catch (e) {
            print("Erreur lors de l'écoute du flux de progression : $e");

            controller.addError(NetworkException.errorFrom(e));
            controller.close();
            return Left(NetworkException.errorFrom(e));
          }

          return Right(controller.stream);
        },
      );
    } catch (e, stackTrace) {
      print("Exception interceptée : $e");
      print("StackTrace : $stackTrace");
      return Left(NetworkException.errorFrom(e));
    }
  }

  Future<Either<DatabaseException, void>> savePdfFile(
      PdfFileEntity pdfFileEntity) async {
    return _pdfRepository.savePdfFile(pdfFileEntity);
  }

  Future<Either<DatabaseException, List<PdfFileEntity>>> getAllPdfFile(
      {int maxResults = -1}) async {
    return _pdfRepository.getAllPdfFile(maxResults: maxResults);
  }

  Future<Either<DatabaseException, void>> deletePdfFile(String path) async {
    return _pdfRepository.deletePdfFile(path);
  }

  Future<Either<DatabaseException, bool>> isSavedPdfFile(String pdfPath) async {
    return _pdfRepository.isSavedPdfFile(pdfPath);
  }

  Future<Either<DatabaseException, bool>> isOpenedPdfFile(
      String pdfPath) async {
    return _pdfRepository.isOpenedPdfFile(pdfPath);
  }

  Future<Either<DatabaseException, PdfFileEntity>> getPdfFileByPath(
      String pdfPath,
      {bool isOpened = false}) async {
    return _pdfRepository.getPdfFileByPath(
        pdfPath: pdfPath, isOpened: isOpened);
  }
}
