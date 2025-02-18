abstract class PdfRemoteDataSource {
  /// download a pdf file from the given url
  Stream<double>  downloadPdf({
    required String url,
    required String path,
  });
}
