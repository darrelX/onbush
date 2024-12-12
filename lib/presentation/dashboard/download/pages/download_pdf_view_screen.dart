import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:onbush/presentation/dashboard/download/logic/data/pdf_file_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage()
class DownloadPdfViewScreen extends StatefulWidget {
  final PdfFileModel pdfFileModel;
  const DownloadPdfViewScreen({super.key, required this.pdfFileModel});

  @override
  State<DownloadPdfViewScreen> createState() => _DownloadPdfViewScreenState();
}

class _DownloadPdfViewScreenState extends State<DownloadPdfViewScreen> {
  // Bloque les captures d'écran
  void _enableSecureMode() async {
    await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  @override
  void initState() {
    super.initState();
    _enableSecureMode();
  }

  @override 
  void dispose(){
    FlutterWindowManagerPlus.clearFlags(FlutterWindowManagerPlus.FLAG_SECURE);

super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfPdfViewer.file(widget.pdfFileModel.file),
    );
  }
}
