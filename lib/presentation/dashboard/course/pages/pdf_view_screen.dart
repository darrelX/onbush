import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:onbush/core/application/data/models/course_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage()
class PdfViewScreen extends StatefulWidget {
  final CourseModel courseModel;
  final String category;
  const PdfViewScreen({
    super.key,
    required this.courseModel,
    required this.category,
  });

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  String _pdfUrl = '';
  String? _pdfPath;
  final Dio _dio = Dio();
  double _progress = 0.0; // Variable pour suivre la progression

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
    try {
      // Récupérer le répertoire où enregistrer le fichier PDF
      final Directory pdfDirectory = await getApplicationDocumentsDirectory();
      final String securePdfPath =
          '${pdfDirectory.path}/${widget.courseModel.name}.pdf';
      final file = File(securePdfPath);

      // Utiliser Dio pour télécharger le fichier avec suivi de la progression
      await _dio.download(
        _pdfUrl,
        securePdfPath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            setState(() {
              _progress = received / total;
              print(_progress);
            });
          }
        },
      );

      setState(() {
        _pdfPath = securePdfPath;
      });

      // Affichage d'un message de succès une fois le téléchargement terminé
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Téléchargement du PDF terminé !")),
      );
    } catch (e) {
      // Gérer les erreurs pendant le téléchargement
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur lors du téléchargement : $e")),
      );
    }
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
          // ? const Center(child: Center(child: CircularProgressIndicator()))
          ? Center(child: Text("$_progress"))
          : SfPdfViewer.file(File(_pdfPath!)),
    );
  }
}
