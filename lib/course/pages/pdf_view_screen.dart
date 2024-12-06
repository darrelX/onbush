import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class PdfViewScreen extends StatefulWidget {
  final String pdfUrl;
  const PdfViewScreen({super.key, required this.pdfUrl});

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String _pdfUrl = '';
  String? _pdfPath;

  // Bloque les captures d'écran
  void _enableSecureMode() async {
    await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  // Charge un fichier PDF sécurisé
  Future<void> _loadSecurePdf() async {
    final directory = await getApplicationDocumentsDirectory();
    final securePdfPath = '${directory.path}/se_cure.pdf';
    final file = File(securePdfPath);

    // Télécharge le fichier PDF depuis le lien internet et l'écrase toujours
    final response = await http.get(Uri.parse(_pdfUrl));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Impossible de télécharger le fichier PDF');
    }
    // final byteData =
    //     await DefaultAssetBundle.of(context).load('assets/sample.pdf');
    // await file.writeAsBytes(byteData.buffer.asUint8List());
    setState(() {
      _pdfPath = securePdfPath;
    });
  }

  @override
  void dispose() {
    FlutterWindowManagerPlus.clearFlags(FlutterWindowManagerPlus.FLAG_SECURE);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pdfUrl = widget.pdfUrl;
    _enableSecureMode();
    _loadSecurePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pdfPath == null
          ? const Center(child: Center(child: CircularProgressIndicator()))
          : SfPdfViewer.file(File(_pdfPath!)),
    );
  }
}
