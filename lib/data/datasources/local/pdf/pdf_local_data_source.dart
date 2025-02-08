import 'package:onbush/data/datasources/local/_collection/pdf/pdf_file_collection.dart';

abstract class PdfLocalDataSource {
  const PdfLocalDataSource();

  /// save pdf file
  Future<void> savePdfFile(PdfFileCollection pdfFileId);

  /// get all availables pdfs
  Future<List<PdfFileCollection>> getAllPdfFile();

  /// delete a pdf file
  Future<void> deletePdfFile(String pdfPath);

  /// Returns a boolean indicating whether the pdf file with the given [pdfFIle id] is saved in the local data source.
  Future<bool> isSavedPdfFile(String pdfPath);

  /// Returns a boolean indicating whether the pdf file with the given [pdfFIle id] is already opened in the local data source.
  Future<bool> isOpenedPdfFile(String pdfPath);

}
