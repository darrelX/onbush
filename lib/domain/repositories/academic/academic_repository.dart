import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';

abstract class AcademyRepository {
  /// Colleges
  // 🎓 Récupère la liste complète des collèges disponibles
  Future<Either<NetworkException, List<CollegeEntity>>> getAllColleges();

  // 🏫 Trouve un collège spécifique à partir de son identifiant
  Future<Either<NetworkException, CollegeEntity>> getCollegeById(
      {required int collegeId});

  /// Specialities
  // 🔍 Récupère les détails d’une spécialité via son identifiant
  Future<Either<NetworkException, SpecialityEntity>> getSpecialityById(
      {required int specialityId});

  // 📚 Récupère la liste complète des spécialités proposées
  Future<Either<NetworkException, List<SpecialityEntity>>> getAllSpecialities(
      {required int schoolId});

  /// Courses
  // 📖 Obtient tous les cours d’une matière donnée, filtrés par catégorie
  Future<Either<NetworkException, List<CourseEntity>>> getAllCourses({
    required int subjectId,
    required String category,
  });

  /// Subjects

  ///* remote
  /// 🎯 Récupère toutes les matières associées à une spécialité donnée
  Future<Either<NetworkException, List<SubjectEntity>>>
      getSubjectByspecialityId({required int specialityId});

  /// 🎓 Récupère toutes les matières correspondant au niveau d'étude spécifié
  Future<Either<NetworkException, List<SubjectEntity>>> getSubjectByLevel(
      {required int subjectId, required int level});

  ///* local
  Future<Either<DatabaseException, void>> saveListSubjects(
      List<SubjectEntity> listSubjectEntity);

  Future<Either<DatabaseException, List<SubjectEntity>>> getAllSavedSubjects();

  /// delete a pdf file
  Future<Either<DatabaseException, void>> deleteAllSubjectCache();

  Future<Either<DatabaseException, void>> deleteSubjectId(int subjectId);
}
