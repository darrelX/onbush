import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/data/datasources/local/subject/subject_local_data_source.dart';
import 'package:onbush/data/datasources/remote/college/college_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/course/course_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/speciality/speciality_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/subject/subject_remote_data_source.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/domain/repositories/academic/academic_repository.dart';

class AcademyRepositoryImpl implements AcademyRepository {
  final CourseRemoteDataSource _courseRemoteDataSource;
  final SpecialityRemoteDataSource _specialityRemoteDataSource;
  final SubjectRemoteDataSource _subjectRemoteDataSource;
  final CollegeRemoteDataSource _collegeRemoteDataSource;
  final SubjectLocalDataSource _subjectLocalDataSource;

  AcademyRepositoryImpl(
      {required CollegeRemoteDataSource collegeRemoteDataSource,
      required SpecialityRemoteDataSource specialityRemoteDataSource,
      required SubjectLocalDataSource subjectLocalDataSource,
      required CourseRemoteDataSource courseRemoteDataSource,
      required SubjectRemoteDataSource subjectRemoteDataSource})
      : _courseRemoteDataSource = courseRemoteDataSource,
        _subjectLocalDataSource = subjectLocalDataSource,
        _specialityRemoteDataSource = specialityRemoteDataSource,
        _subjectRemoteDataSource = subjectRemoteDataSource,
        _collegeRemoteDataSource = collegeRemoteDataSource;

  /// Colleges
  // 🎓 Récupère la liste complète des collèges disponibles
  @override
  Future<Either<NetworkException, List<CollegeEntity>>> getAllColleges() async {
    try {
      final result = await _collegeRemoteDataSource.getAllColleges();
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  // 🏫 Trouve un collège spécifique à partir de son identifiant
  @override
  Future<Either<NetworkException, CollegeEntity>> getCollegeById(
      {required int collegeId}) async {
    try {
      final result =
          await _collegeRemoteDataSource.getCollegeById(collegeId: collegeId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  /// Specialities
  // 🔍 Récupère les détails d’une spécialité via son identifiant
  @override
  Future<Either<NetworkException, SpecialityEntity>> getSpecialityById(
      {required int specialityId}) async {
    try {
      final result = await _specialityRemoteDataSource.getSpecialityById(
          specialityId: specialityId);
      return Right(result.toEntity());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  // 📚 Récupère la liste complète des spécialités proposées
  @override
  Future<Either<NetworkException, List<SpecialityEntity>>> getAllSpecialities(
      {required int schoolId}) async {
    try {
      final result =
          await _specialityRemoteDataSource.getAllSpecialities(schoolId);

      return Right(result.map((elt) => elt.toEntity()).toList());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  /// Courses
  // 📖 Obtient tous les cours d’une matière donnée, filtrés par catégorie
  @override
  Future<Either<NetworkException, List<CourseEntity>>> getAllCourses({
    required int subjectId,
    required String category,
  }) async {
    try {
      final result = await _courseRemoteDataSource.getAllCourses(
          subjectId: subjectId, category: category);
      return Right(result.map((elt) => elt.toEntity()).toList());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  /// Subjects
  /// 🎯 Récupère toutes les matières associées à une spécialité donnée
  @override
  Future<Either<NetworkException, List<SubjectEntity>>>
      getSubjectByspecialityId({required int specialityId}) async {
    try {
      final result = await _subjectRemoteDataSource.getSubjectByspecialityId(
          specialityId: specialityId);
      return Right(result.map((elt) => elt.toEntity()).toList());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  /// 🎓 Récupère toutes les matières correspondant au niveau d'étude spécifié
  @override
  Future<Either<NetworkException, List<SubjectEntity>>> getSubjectByLevel(
      {required int subjectId, required int level}) async {
    try {
      final result = await _subjectRemoteDataSource.getSubjectByLevel(
          subjectId: subjectId, level: level);
      return Right(result.map((elt) => elt.toEntity()).toList());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  @override
  Future<Either<DatabaseException, void>> saveListSubjects(
      List<SubjectEntity> listSubjectEntity) async {
    try {
      final result = await _subjectLocalDataSource.saveListSubjects(
          listSubjectEntity
              .map((subject) => subject.toSubjectModel())
              .toList());
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  @override
  Future<Either<DatabaseException, List<SubjectEntity>>>
      getAllSavedSubjects() async {
    try {
      final result = await _subjectLocalDataSource.getAllSavedSubjects();
      return Right(result.map((subject) => subject.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  /// delete a pdf file
  @override
  Future<Either<DatabaseException, void>> deleteAllSubjectCache() async {
    try {
      final result = await _subjectLocalDataSource.deleteAllSubjectCache();
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }

  @override
  Future<Either<DatabaseException, void>> deleteSubjectId(int subjectId) async {
    try {
      final result = await _subjectLocalDataSource.deleteSubjectId(subjectId);
      return Right(result);
    } catch (e) {
      return Left(DatabaseException.fromError(e));
    }
  }
}
