import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_windowmanager_plus/flutter_windowmanager_plus.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_file/pdf_file_cubit.dart';
import 'package:onbush/service_locator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

@RoutePage()
class PdfViewScreen extends StatefulWidget {
  final CourseEntity courseEntity;
  final String category;

  const PdfViewScreen({
    super.key,
    required this.courseEntity,
    required this.category,
  });

  @override
  State<PdfViewScreen> createState() => _PdfViewScreenState();
}

class _PdfViewScreenState extends State<PdfViewScreen> {
  late final PdfFileCubit _pdfFileCubit;
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    _pdfFileCubit = getIt<PdfFileCubit>();
    _enableSecureMode();
    _loadSecurePdf();
  }

  @override
  void dispose() {
    FlutterWindowManagerPlus.clearFlags(FlutterWindowManagerPlus.FLAG_SECURE);
    super.dispose();
  }

  /// Bloque les captures d'écran
  Future<void> _enableSecureMode() async {
    await FlutterWindowManagerPlus.addFlags(
        FlutterWindowManagerPlus.FLAG_SECURE);
  }

  /// Charge un fichier PDF sécurisé avec gestion des erreurs
  Future<void> _loadSecurePdf() async {
    try {
      await _pdfFileCubit.readPdfFile(
        category: widget.category,
        name: widget.courseEntity.name!,
      );
    } catch (e) {
      debugPrint("Erreur lors du chargement du PDF : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _pdfFileCubit,
      child: Scaffold(
        body: BlocConsumer<PdfFileCubit, PdfFileState>(
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
