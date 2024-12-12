import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/presentation/dashboard/download/logic/data/pdf_file_model.dart';
import 'package:onbush/core//utils/utils.dart';
import 'package:path_provider/path_provider.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadInitial());

  /// Récupère les métadonnées d'un fichier et retourne sa date de dernière modification.
  Future<int?> _getFileModifiedDate(String filePath) async {
    final now = DateTime.now();
    try {
      final File file = File(filePath);

      if (await file.exists()) {
        final FileStat stats = await file.stat();
        return now.difference(stats.modified).inHours;
      } else {
        print('Le fichier n\'existe pas : $filePath');
        return null;
      }
    } catch (e) {
      print('Erreur lors de la récupération des métadonnées du fichier : $e');
      return null;
    }
  }

  /// Charge tous les fichiers PDF à partir d'un répertoire, y compris ses sous-dossiers.
  Future<List<File>> _loadAllPdfFilesFromDirectory(Directory directory) async {
    final List<File> pdfFiles = [];
    try {
      final List<FileSystemEntity> entities =
          directory.listSync(recursive: true);

      for (var entity in entities) {
        if (entity is File && entity.path.toLowerCase().endsWith('.pdf')) {
          pdfFiles.add(entity);
        }
      }
    } catch (e) {
      print('Erreur lors de l\'exploration des fichiers PDF : $e');
    }
    return pdfFiles;
  }

  /// Déduit la catégorie (nom du dossier parent) à partir du chemin du fichier.
  String _getCategoryFromFilePath(String filePath) {
    final List<String> parts = filePath.split('/');
    if (parts.length >= 2) {
      return parts[parts.length - 2]; // Le dossier parent du fichier
    }
    return 'Unknown';
  }

  /// Convertit une liste de fichiers en modèles `PdfFileModel`.
  Future<List<PdfFileModel>> _convertFilesToPdfFileModel(
      List<File> files) async {
    final List<PdfFileModel> pdfModels = [];
    try {
      for (var file in files) {
        final modifiedDate = (await _getFileModifiedDate(file.path));
        final category = _getCategoryFromFilePath(file.path);
        pdfModels.add(
          PdfFileModel(
            file: file,
            category: category, // Catégorie générique pour tous les fichiers.
            date: modifiedDate!,
            name: file.path.split('/').last,
          ),
        );
      }
    } catch (e) {
      print('Erreur lors de la conversion des fichiers en modèles : $e');
      rethrow;
    }
    return pdfModels;
  }

  /// Récupère tous les fichiers PDF depuis le répertoire principal de l'application.
  Future<List<PdfFileModel>> loadAllPdfsFromAppDirectory() async {
    try {
      // Obtenez le répertoire principal de l'application.
      final Directory appDirectory = await getApplicationDocumentsDirectory();

      // Chargez tous les fichiers PDF de manière récursive.
      final List<File> allPdfFiles =
          await _loadAllPdfFilesFromDirectory(appDirectory);

      // Convertissez les fichiers PDF en modèles `PdfFileModel`.
      final List<PdfFileModel> pdfModels =
          await _convertFilesToPdfFileModel(allPdfFiles);

      return pdfModels;
    } catch (e) {
      print('Erreur lors du chargement des PDF : $e');
      return [];
    }
  }

  Future<List<String>> getFoldersInAppDirectory() async {
    try {
      // Obtenez le répertoire principal de l'application.
      final Directory appDirectory = await getApplicationDocumentsDirectory();

      // Liste les sous-dossiers du répertoire principal.
      final List<FileSystemEntity> entities = appDirectory.listSync();

      // Filtre uniquement les dossiers et retourne leurs noms.
      final List<String> folderNames = entities
          .whereType<Directory>() // Filtrer uniquement les dossiers.
          .map((directory) =>
              directory.path.split('/').last) // Obtenir le nom du dossier.
          .toList();
      folderNames.remove('flutter_assets');

      return folderNames;
    } catch (e) {
      print('Erreur lors de la récupération des dossiers : $e');
      return [];
    }
  }

  /// Télécharge les fichiers PDF de tous les sous-dossiers et met à jour l'état.
  Future<void> downloadAllPdfs() async {
    emit(const DownloadLoading());
    try {
      final List<PdfFileModel> pdfModels = await loadAllPdfsFromAppDirectory();
      emit(DownloadSuccess(listPdfModel: pdfModels));
    } catch (e) {
      final errorMessage = Utils.extractErrorMessage(e);
      print('Erreur dans `downloadAllPdfs` : $errorMessage');
      emit(DownloadFailure(message: errorMessage));
    }
  }
}
