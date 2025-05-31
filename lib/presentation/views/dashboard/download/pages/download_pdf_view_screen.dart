import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_file/pdf_file_cubit.dart';
import 'package:onbush/service_locator.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage()
class DownloadPdfViewScreen extends StatefulWidget {
  final PdfFileEntity pdfFileEntity;
  const DownloadPdfViewScreen({super.key, required this.pdfFileEntity});

  @override
  State<DownloadPdfViewScreen> createState() => _DownloadPdfViewScreenState();
}

class _DownloadPdfViewScreenState extends State<DownloadPdfViewScreen> {
  final PdfFileCubit _pdfFileCubit = getIt<PdfFileCubit>();
  final PdfViewerController _pdfViewerController = PdfViewerController();

  // Bloque les captures d'écran

  @override
  void initState() {
    super.initState();
    _enableSecureMode();
    _loadSecurePdf();
  }

  @override
  void dispose() {
    FlutterWindowManagerPlus.clearFlags(FlutterWindowManagerPlus.FLAG_SECURE);
    super.dispose();
  }

  /// Charge un fichier PDF sécurisé avec gestion des erreurs
  Future<void> _loadSecurePdf() async {
    try {
      await _pdfFileCubit.readLocalPdfFile(
        pdfFileEntity: widget.pdfFileEntity,
      );
    } catch (e) {}
  }

  Future<void> _enableSecureMode() async {
    await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _pdfFileCubit,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<PdfFileCubit, PdfFileState>(
            listener: (context, state) {
              if (state is PdfFileFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erreur : ${state.message}")),
                );
              }
            },
            builder: (context, state) {
              if (state is PdfFileLoading) {
                return _buildLoadingIndicator(state.percent);
              }
              if (state is ReadPdfFileSuccess) {
                return SfPdfViewer.file(
                  File(state.pdfFileEntity.filePath!),
                  controller: _pdfViewerController,
                );
              }
              return const Center(child: Text("Aucun fichier disponible"));
            },
          ),
        ),
      ),
    );
  }

  /// Indicateur de chargement avec pourcentage
  Widget _buildLoadingIndicator(double percent) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text("Téléchargement : $percent%"),
        ],
      ),
    );
  }
}
