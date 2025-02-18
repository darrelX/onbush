import 'dart:async';
import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/pdf/pdf_remote_data_source.dart';

class PdfRemoteDataSourceImpl implements PdfRemoteDataSource {
  final Dio _dioApiData;

  PdfRemoteDataSourceImpl(this._dioApiData);

  @override
  Stream<double> downloadPdf({required String url, required String path}) {
    final StreamController<double> progressController =
        StreamController<double>();

    try {
      _dioApiData.download(
        url,
        path,
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress =
                double.parse(((received / total) * 100).toStringAsFixed(2));
            progressController.add(progress);
          }
        },
      ).then((_) {
        progressController.add(100.0); // Signale la fin du téléchargement
        progressController.close();
      }).catchError((e) {
        progressController.addError("Erreur lors du téléchargement: $e");
        progressController.close();
      });
    } catch (e) {
      progressController.addError("Erreur inattendue: $e");
      progressController.close();
    }

    return progressController.stream;
  }
}
