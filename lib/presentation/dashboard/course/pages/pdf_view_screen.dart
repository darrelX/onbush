import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:onbush/core/application/data/models/course_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:http/http.dart' as http;

@RoutePage()
class PdfViewScreen extends StatefulWidget {
  final CourseModel courseModel;
  final String category;
  const PdfViewScreen(
      {super.key, required this.courseModel, required this.category,});

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
    final pdfDirection = Directory("${directory.path}/${widget.category}");

    // Vérifiez s'il existe, sinon créez-le
    if (!await pdfDirection.exists()) {
      await pdfDirection.create(recursive: true);
      print('Dossier créé: $pdfDirection');
      _createFile(pdfDirection);
    } else {
      _createFile(pdfDirection);
      print('Le dossier existe déjà: $pdfDirection');
    }
  }

  Future<void> _createFile(Directory pdfDirection) async {
    final securePdfPath = '${pdfDirection.path}/${widget.courseModel.name}.pdf';
    final file = File(securePdfPath);

    // Télécharge le fichier PDF depuis le lien internet et l'écrase toujours
    final response = await http.get(Uri.parse(_pdfUrl));
    if (response.statusCode == 200) {
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Impossible de télécharger le fichier PDF');
    }
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
    _pdfUrl = widget.courseModel.pdf;
    _enableSecureMode();
    _loadSecurePdf();
  }

  @override
  Widget build(BuildContext context) {
    print(_pdfPath);
    return Scaffold(
      body: _pdfPath == null
          ? const Center(child: Center(child: CircularProgressIndicator()))
          : SfPdfViewer.file(File(_pdfPath!)),
    );
  }
}
