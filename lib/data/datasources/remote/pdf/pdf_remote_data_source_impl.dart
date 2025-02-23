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

    _download(url, path, progressController);

    return progressController.stream;
  }

  Future<void> _download(
      String url, String path, StreamController<double> controller) async {
    try {
      await _dioApiData.download(
        url,
        path,
        options: Options(receiveTimeout: const Duration(milliseconds: 50000)),
        onReceiveProgress: (received, total) {
          if (total > 0) {
            final progress = (received / total) * 100;
            controller.add(progress);
          }
        },
      );

      // Signalement de la fin du téléchargement
      controller.add(100.0);
    } catch (e) {
      controller.addError(e);
    } finally {
      controller.close();
    }
  }
}
