import 'package:onbush/data/models/pdf_file/pdf_file_model.dart';

abstract class PdfLocalDataSource {
  const PdfLocalDataSource();

  /// save pdf file
  Future<void> savePdfFile(PdfFileModel pdfFileId);

  Future<void> updatePdfFile(PdfFileModel updatedPdfFile);

  Future<void> savePdfFileByPath(
      {required String? filePath,
      required String? id,
      required String? category,
      required String? name});

  /// get all availables pdfs
  Future<List<PdfFileModel>> getAllPdfFile({int maxResults = -1});

  Future<PdfFileModel> getPdfFileByPath(String pdfPath,
      {bool isOpened = false});

  /// delete a pdf file
  Future<void> deletePdfFile(String pdfPath);

  /// Returns a boolean indicating whether the pdf file with the given [pdfFIle id] is saved in the local data source.
  Future<bool> isSavedPdfFile(String pdfPath);

  /// Returns a boolean indicating whether the pdf file with the given [pdfFIle id] is already opened in the local data source.
  Future<bool> isOpenedPdfFile(String pdfPath);
}
