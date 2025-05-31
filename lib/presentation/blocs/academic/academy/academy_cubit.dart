import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/usecases/academic/academic_usecase.dart';
import 'package:onbush/domain/usecases/pdf/pdf_usecase.dart';
import 'package:onbush/service_locator.dart';

part 'academy_state.dart';

class AcademyCubit extends Cubit<AcademyState> {
  final AcademyUsecase _academyUsecase;
  final PdfUseCase _pdfUseCase;
  AcademyCubit(this._academyUsecase, this._pdfUseCase)
      : super(AcademyInitial());

  final List<CollegeEntity> _listAllColleges = [];
  final List<SpecialityEntity> _listAllSpecialities = [];
  final List<SubjectEntity> _listSubjectEntity = [];
  final List<CourseEntity> _listCourseEntity = [];

  String? currentRequest;

  List<CollegeEntity> get listAllColleges => _listAllColleges;
  List<SpecialityEntity> get listAllSpecialities => _listAllSpecialities;
  List<SubjectEntity> get listSubjectEntity => _listSubjectEntity;
  List<CourseEntity> get listCourseEntity => _listCourseEntity;

  final UserEntity? userEntity = getIt<ApplicationCubit>().userEntity;

  Future<void> allColleges() async {
    _listAllColleges.clear();
    currentRequest = "colleges";
    emit(const SearchStateLoading());

    try {
      final result = await _academyUsecase.getAllColleges();
      result.fold(
        (failure) => emit(SearchStateFailure(message: failure.message)),
        (colleges) {
          _listAllColleges.addAll(colleges);
          emit(SearchStateSuccess(
            listCollegeEntity: _listAllColleges,
            listSpeciality: _listAllSpecialities,
          ));
        },
      );
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }

  Future<void> allSpecialities({required int schoolId}) async {
    _listAllSpecialities.clear();
    currentRequest = "specialities";

    emit(const SearchStateLoading());
    try {
      final result =
          await _academyUsecase.getAllSpecialities(schoolId: schoolId);
      result.fold(
        (failure) => emit(SearchStateFailure(message: failure.message)),
        (specialities) {
          _listAllSpecialities.addAll(specialities);
          emit(SearchStateSuccess(
            listCollegeEntity: _listAllColleges,
            listSpeciality: _listAllSpecialities,
          ));
        },
      );
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }

  Future<void> fetchSubjectEntity() async {
    _listSubjectEntity.clear();
    emit(const SubjectStateLoading());

    try {
      final result = await _academyUsecase.getSubjectByspecialityId(
          specialityId: userEntity!.majorSchoolId!);
      result.fold(
        (failure) => emit(SubjectStateFailure(message: failure.message)),
        (subjects) {
          _listSubjectEntity.addAll(subjects);
          emit(SubjectStateSuccess(listSubjectEntity: _listSubjectEntity));
        },
      );
    } catch (e) {
      emit(SubjectStateFailure(message: e.toString()));
    }
  }

  Future<void> fetchCourseEntity({
    required int subjectId,
    required String category,
    bool fullRefresh = true, // Ajout du paramètre
  }) async {
    if (fullRefresh) {
      listCourseEntity
          .clear(); // On vide la liste uniquement si on refait un appel à l'API
      emit(const CourseStateLoading());
    }

    try {
      // Récupération des fichiers PDF stockés en local (base de données)
      final Either<DatabaseException, List<PdfFileEntity>> savePdfFileResult =
          await _pdfUseCase.getAllPdfFile();

      List<CourseEntity> updatedCourses = [];

      if (fullRefresh) {
        // Récupération des cours depuis l'API uniquement si `fullRefresh` est vrai
        final Either<NetworkException, List<CourseEntity>> result =
            await _academyUsecase.getAllCourses(
          subjectId: subjectId,
          category: category,
        );

        result.fold(
          (failure) => emit(CourseStateFailure(message: failure.message)),
          (courses) {
            updatedCourses = _updateCourseStatus(courses, savePdfFileResult);

            listCourseEntity.addAll(updatedCourses);
            emit(CourseStateSuccess(listCourseEntity: listCourseEntity));
          },
        );
      } else {
        // Mise à jour des statuts des cours déjà chargés avec la base de données locale
        updatedCourses =
            _updateCourseStatus(listCourseEntity, savePdfFileResult);
        listCourseEntity
          ..clear()
          ..addAll(updatedCourses);
        emit(CourseStateSuccess(listCourseEntity: listCourseEntity));
      }
    } catch (e) {
      emit(CourseStateFailure(message: e.toString()));
    }
  }

  /// **Méthode privée pour mettre à jour le statut des cours à partir des fichiers enregistrés en local**
  List<CourseEntity> _updateCourseStatus(
    List<CourseEntity> courses,
    Either<DatabaseException, List<PdfFileEntity>> savePdfFileResult,
  ) {
    return courses.map((course) {
      Status status = Status.notDownloaded;

      savePdfFileResult.fold(
        (error) {
          return null;
        }, // Si la base de données échoue, on garde le statut par défaut
        (savedFiles) {
          final matchingFile = savedFiles.firstWhere(
            (file) => file.id == course.id,
            orElse: () => PdfFileEntity(name: '', filePath: '', category: ''),
          );

          if (matchingFile.name!.isNotEmpty) {
            log(matchingFile.isOpened.toString());
            status =
                matchingFile.isOpened ? Status.isOpened : Status.downloaded;
          }
        },
      );

      return CourseEntity(
        id: course.id,
        name: course.name,
        pdfUrl: course.pdfUrl,
        courseId: course.courseId,
        pdfEpreuve: course.pdfEpreuve,
        pdfCorrige: course.pdfCorrige,
        status: status,
      );
    }).toList();
  }

  Future<void> addSpecialty({required int majorSchoolId}) async {
    emit(const SearchStateLoading());

    try {
      final result =
          await _academyUsecase.getSpecialityById(specialityId: majorSchoolId);
      result.fold(
        (failure) => emit(SearchStateFailure(message: failure.message)),
        (speciality) {
          _listAllSpecialities.add(speciality);
          emit(SearchStateSuccess(
            listCollegeEntity: _listAllColleges,
            listSpeciality: _listAllSpecialities,
          ));
        },
      );
    } catch (e) {
      emit(SearchStateFailure(message: e.toString()));
    }
  }
}
