import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/data/datasources/local/pdf/pdf_local_data_source.dart';
import 'package:onbush/data/datasources/remote/pdf/pdf_remote_data_source.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/repositories/pdf/pdf_repository.dart';

class PdfRepositoryImpl implements PdfRepository {
  final PdfRemoteDataSource _pdfRemoteDataSource;
  final PdfLocalDataSource _pdfLocalDataSource;

  PdfRepositoryImpl({
    required PdfRemoteDataSource pdfRemoteDataSource,
    required PdfLocalDataSource pdfLocalDataSource,
  })  : _pdfRemoteDataSource = pdfRemoteDataSource,
        _pdfLocalDataSource = pdfLocalDataSource;

  /// download pdf file from an external server

  @override
  Future<Either<NetworkException, Stream<double>>> downloadPdf({
    required String url,
    required String path,
  }) async {
    try {
      final result = _pdfRemoteDataSource.downloadPdf(url: url, path: path);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  /// save pdf file\
  @override
  Future<Either<DatabaseException, void>> savePdfFile(
      PdfFileEntity pdfFileEntity) async {
    try {
      final result =
          _pdfLocalDataSource.savePdfFile(pdfFileEntity.toPdfFileModel());
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  /// get all availables pdfs
  @override
  Future<Either<DatabaseException, List<PdfFileEntity>>> getAllPdfFile(
      {int maxResults = -1}) async {
    try {
      final result =
          await _pdfLocalDataSource.getAllPdfFile(maxResults: maxResults);

      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  /// delete a pdf file
  @override
  Future<Either<DatabaseException, void>> deletePdfFile(String pdfPath) async {
    try {
      final result = await _pdfLocalDataSource.deletePdfFile(pdfPath);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  /// Returns a boolean indicating whether the pdf file with the given [pdfFIle id] is saved in the local data source.
  @override
  Future<Either<DatabaseException, bool>> isSavedPdfFile(String pdfPath) async {
    try {
      final result = await _pdfLocalDataSource.isSavedPdfFile(pdfPath);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  /// Returns a boolean indicating whether the pdf file with the given [pdfFIle id] is already opened in the local data source.
  @override
  Future<Either<DatabaseException, bool>> isOpenedPdfFile(
      String pdfPath) async {
    try {
      final result = await _pdfLocalDataSource.isOpenedPdfFile(pdfPath);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  @override
  Future<Either<DatabaseException, void>> savePdfFileByPath(
      {required String filePath,
      required String id,
      required String category,
      required String name}) async {
    try {
      final result = await _pdfLocalDataSource.savePdfFileByPath(
          id: id, filePath: filePath, category: category, name: name);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  @override
  Future<Either<DatabaseException, PdfFileEntity>> getPdfFileByPath(
      {required String pdfPath, bool isOpened = false}) async {
    try {
      final result = await _pdfLocalDataSource.getPdfFileByPath(pdfPath,
          isOpened: isOpened);
      return Right(result.toEntity());
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  Future<Either<DatabaseException, void>> updatePdfFile(
      PdfFileEntity updatedPdfFile) async {
    try {
      final result = await _pdfLocalDataSource
          .updatePdfFile(updatedPdfFile.toPdfFileModel());
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }
}
