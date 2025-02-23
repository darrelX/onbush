import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';

abstract class PdfRepository {
  Future<Either<NetworkException, Stream<double>>> downloadPdf({
    required String url,
    required String path,
  });

  Future<Either<DatabaseException, void>> savePdfFile(
      PdfFileEntity pdfFileEntity);

  Future<Either<DatabaseException, List<PdfFileEntity>>> getAllPdfFile(
      {int maxResults = -1});

  Future<Either<DatabaseException, void>> deletePdfFile(String path);

  Future<Either<DatabaseException, bool>> isSavedPdfFile(String pdfPath);

  Future<Either<DatabaseException, bool>> isOpenedPdfFile(String pdfPath);

  Future<Either<DatabaseException, void>> savePdfFileByPath(
      {required String filePath,
      required String category,
      required String name});

  Future<Either<DatabaseException, PdfFileEntity>> getPdfFileByPath(
      {required String pdfPath, bool isOpened = false});
}
