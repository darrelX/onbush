import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/usecases/pdf/pdf_usecase.dart';

part 'pdf_manager_state.dart';

class PdfManagerCubit extends Cubit<PdfManagerState> {
  final PdfUseCase _pdfUseCase;

  List<PdfFileEntity> allPdfs = [];

  PdfManagerCubit(this._pdfUseCase) : super(PdfManagerInitial());

  /// Charge tous les PDF
  Future<void> loadAll({int maxResults = -1}) async {
    emit(PdfManagerLoading());
    try {
      final result = await _pdfUseCase.getAllPdfFile(maxResults: maxResults);
      result.fold(
        (failure) {
          emit(PdfManagerError(message: failure.message));
        },
        (pdfs) {
          allPdfs = pdfs;

          emit(PdfManagerLoaded(filtered: pdfs, all: pdfs));
        },
      );
    } catch (e) {
      emit(PdfManagerError(message: e.toString()));
    }
  }

  /// Applique un filtre sur les PDF déjà chargés
  void applyFilter({String? category, String searchQuery = ''}) {
    if (state is! PdfManagerLoaded) return;

    final filtered = allPdfs.where((pdf) {
      final matchCategory =
          category == null || category == "Tout" || pdf.category == category;
      final matchSearch =
          pdf.name?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false;
      return matchCategory && matchSearch;
    }).toList();

    emit(PdfManagerLoaded(filtered: filtered, all: allPdfs));
  }

  /// Met à jour ou ajoute un PDF existant (après un download, par exemple)
  void updateOrAdd(PdfFileEntity pdf) {
    final index = allPdfs.indexWhere((p) => p.filePath == pdf.filePath);
    if (index != -1) {
      allPdfs[index] = pdf;
    } else {
      allPdfs.add(pdf);
    }

    // Réappliquer le filtre actuel
    if (state is PdfManagerLoaded) {
      applyFilter();
    } else {
      emit(PdfManagerLoaded(filtered: allPdfs, all: allPdfs));
    }
  }

  void clear() {
    allPdfs.clear();
    emit(PdfManagerInitial());
  }
}
