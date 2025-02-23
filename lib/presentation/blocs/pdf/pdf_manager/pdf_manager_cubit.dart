// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
// import 'package:onbush/domain/usecases/pdf/pdf_usecase.dart';

// part 'pdf_manager_state.dart';

// class PdfFileManagerCubit extends Cubit<PdfManagerState> {
//   final PdfUseCase _pdfUseCase;

//   PdfFileManagerCubit(this._pdfUseCase) : super(PdfManagerInitial());

//   Future<void> fetchPdfFiles({int maxResults = 3}) async {
//     emit(PdfFileManagerLoading());
//     try {
//       final result = await _pdfUseCase.getAllPdfFile(maxResults: maxResults);
//       result.fold((failure) {
//         emit(PdfFileManagerFailure(message: failure.message));
//       }, (success) {
//         emit(PdfFileManagerSuccess(listPdfFileEntity: success));
//       });
//     } catch (e) {
//       emit(PdfFileManagerFailure(message: e.toString()));
//     }
//   }

//   void addOrUpdatePdfFile(PdfFileEntity pdfFile) {
//     if (state is PdfFileManagerSuccess) {
//       final currentList = List<PdfFileEntity>.from(
//           (state as PdfFileManagerSuccess).listPdfFileEntity);
      
//       // Vérifier si le fichier existe déjà
//       final index = currentList.indexWhere((file) => file.path == pdfFile.path);
//       if (index != -1) {
//         currentList[index] = pdfFile; // Mise à jour
//       } else {
//         currentList.add(pdfFile); // Ajout
//       }
      
//       emit(PdfFileManagerSuccess(listPdfFileEntity: currentList));
//     }
//   }
// }
