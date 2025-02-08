import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/data/datasources/local/_collection/pdf/pdf_file_collection.dart';
import 'package:onbush/data/datasources/local/pdf/pdf_local_data_source_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late PdfLocalDataSourceImpl pdfLocalDataSource;
  late LocalStorage localStorage;
  late MockSharedPreferences mockSharedPreferences;

  const String keyPdfFiles = "pdf_file";

  const PdfFileCollection testPdf = PdfFileCollection(
    id: 2,
    name: "Test PDF1",
    filePath: "/documents/test.pdf",
    category: "Education",
    date: "2024-02-08",
    isOpened: false,
  );

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localStorage = LocalStorage(sharedPreferences: mockSharedPreferences);
    pdfLocalDataSource = PdfLocalDataSourceImpl(localStorage);
  });

  tearDown(() {
    reset(mockSharedPreferences);
  });

  group("📂 savePdfFile", () {
    test("Ne duplique pas un fichier PDF déjà enregistré", () async {
      final existingPdfList = [jsonEncode(testPdf.toJson())];

      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(existingPdfList);
      when(() => mockSharedPreferences.setStringList(any(), any()))
          .thenAnswer((_) async => true);

      await pdfLocalDataSource.savePdfFile(testPdf);

      verifyNever(() => mockSharedPreferences.setStringList(any(), any()));
    });

    test("Gère les erreurs correctement", () async {
      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenThrow(Exception("Storage error"));

      expectLater(
        () async => await pdfLocalDataSource.savePdfFile(testPdf),
        throwsException,
      );
    });
  });

  group("📂 getAllPdfFile", () {
    test("Retourne une liste vide si aucun fichier n'est enregistré", () async {
      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(null);

      final result = await pdfLocalDataSource.getAllPdfFile();

      expect(result, isEmpty);
    });

    test("Retourne la liste des fichiers enregistrés", () async {
      final storedPdfs = [jsonEncode(testPdf.toJson())];

      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(storedPdfs);

      final result = await pdfLocalDataSource.getAllPdfFile();

      expect(result, [testPdf]);
    });
  });

  group("🗑 deletePdfFile", () {
    test("Supprime un fichier existant", () async {
      final existingPdfList = [jsonEncode(testPdf.toJson())];

      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(existingPdfList);
      when(() => mockSharedPreferences.setStringList(any(), any()))
          .thenAnswer((_) async => true);

      await pdfLocalDataSource.deletePdfFile(testPdf.filePath!);

      await untilCalled(
          () => mockSharedPreferences.setStringList(any(), any()));

      verify(() => mockSharedPreferences.setStringList(keyPdfFiles, []))
          .called(1);
    });

    test("Gère les erreurs correctement", () async {
      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenThrow(Exception("Storage error"));

      expectLater(
        () async => await pdfLocalDataSource.deletePdfFile(testPdf.filePath!),
        throwsException,
      );
    });
  });

  group("🔎 isSavedPdfFile", () {
    test("Retourne true si le fichier est enregistré", () async {
      final storedPdfs = [jsonEncode(testPdf.toJson())];

      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(storedPdfs);

      final result = await pdfLocalDataSource.isSavedPdfFile(testPdf.filePath!);

      expect(result, isTrue);
    });

    test("Retourne false si le fichier n'est pas enregistré", () async {
      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(null);

      final result = await pdfLocalDataSource.isSavedPdfFile(testPdf.filePath!);

      expect(result, isFalse);
    });
  });

  group("📖 isOpenedPdfFile", () {
    test("Retourne true si le fichier a été ouvert", () async {
      final openedPdf = testPdf.copyWith(isOpened: true);
      final storedPdfs = [jsonEncode(openedPdf.toJson())];

      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(storedPdfs);

      final result =
          await pdfLocalDataSource.isOpenedPdfFile(testPdf.filePath!);

      expect(result, isTrue);
    });

    test("Retourne false si le fichier n'a pas été ouvert", () async {
      final storedPdfs = [jsonEncode(testPdf.toJson())];

      when(() => mockSharedPreferences.getStringList(keyPdfFiles))
          .thenReturn(storedPdfs);

      final result =
          await pdfLocalDataSource.isOpenedPdfFile(testPdf.filePath!);

      expect(result, isFalse);
    });
  });
}
