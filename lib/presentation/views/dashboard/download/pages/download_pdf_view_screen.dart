import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage()
class DownloadPdfViewScreen extends StatefulWidget {
  final PdfFileEntity pdfFileEntity;
  const DownloadPdfViewScreen({super.key, required this.pdfFileEntity});

  @override
  State<DownloadPdfViewScreen> createState() => _DownloadPdfViewScreenState();
}

class _DownloadPdfViewScreenState extends State<DownloadPdfViewScreen> {
  // Bloque les captures d'écran
  Future<void> _enableSecureMode() async {
    await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  @override
  void initState() {
    super.initState();
    _enableSecureMode();
  }

  @override
  void dispose() {
    FlutterWindowManagerPlus.clearFlags(FlutterWindowManagerPlus.FLAG_SECURE);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.pdfFileEntity.filePath!);
    return Scaffold(
      body: SfPdfViewer.file(File(widget.pdfFileEntity.filePath!)),
    );
  }
}
