import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/repositories/pdf/pdf_repository.dart';

class PdfUseCase {
  final PdfRepository _pdfRepository;

  PdfUseCase(this._pdfRepository);

  /// Télécharge un PDF et le sauvegarde automatiquement après un succès.
  Future<Either<DatabaseException, Stream<double>>> downloadAndSavePdf({
    required String url,
    required String path,
    required String category,
    required String name,
  }) async {
    // Lancer le téléchargement
    final downloadResult =
        await _pdfRepository.downloadPdf(url: url, path: path);

    return downloadResult.fold(
      // Si le téléchargement échoue, retourner l'erreur immédiatement
      (failure) => Left(failure),
      (progressStream) {
        // Créer un StreamController pour suivre la progression
        final StreamController<double> controller = StreamController<double>();

        progressStream.listen(
          (progress) async {
            controller.add(progress); // Émettre la progression actuelle

            // Vérifier si le téléchargement est terminé (100%)
            if (progress >= 100.0) {
              // Sauvegarde du fichier
              final saveResult = await _pdfRepository.savePdfFileByPath(
                filePath: path,
                name: name,
                category: category,
              );

              saveResult.fold(
                (failure) {
                  controller
                      .addError(failure); // Émettre une erreur dans le Stream
                  controller.close();
                },
                (_) => controller.close(), // Fermer le Stream après succès
              );
            }
          },
          onError: (error) {
            controller.addError(
                DatabaseException("Erreur de téléchargement : $error"));
            controller.close();
          },
          onDone: () => controller.close(),
        );

        return Right(controller.stream);
      },
    );
  }

  Future<Either<DatabaseException, void>> savePdfFile(
      PdfFileEntity pdfFileEntity) async {
    return _pdfRepository.savePdfFile(pdfFileEntity);
  }

  Future<Either<DatabaseException, List<PdfFileEntity>>> getAllPdfFile({int maxResults = -1}) async {
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
      String pdfPath) async {
    return _pdfRepository.getPdfFileByPath(pdfPath : pdfPath);
  }
}
