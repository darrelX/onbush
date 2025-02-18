import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/local/database_exception.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/college/college_entity.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/speciality/speciality_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/domain/repositories/academic/academic_repository.dart';

class AcademyUsecase {
  final AcademyRepository _academyRepository;

  const AcademyUsecase(this._academyRepository);

  Future<Either<NetworkException, List<CollegeEntity>>> getAllColleges() async {
    return _academyRepository.getAllColleges();
  }

  // 🏫 Trouve un collège spécifique à partir de son identifiant
  Future<Either<NetworkException, CollegeEntity>> getCollegeById(
      {required int collegeId}) async {
    return _academyRepository.getCollegeById(collegeId: collegeId);
  }

  /// Specialities
  // 🔍 Récupère les détails d’une spécialité via son identifiant
  Future<Either<NetworkException, SpecialityEntity>> getSpecialityById(
      {required int specialityId}) {
    return _academyRepository.getSpecialityById(specialityId: specialityId);
  }

  // 📚 Récupère la liste complète des spécialités proposées
  Future<Either<NetworkException, List<SpecialityEntity>>> getAllSpecialities(
      {required int schoolId}) async {
    return _academyRepository.getAllSpecialities(schoolId: schoolId);
  }

  /// Courses
  // 📖 Obtient tous les cours d’une matière donnée, filtrés par catégorie
  Future<Either<NetworkException, List<CourseEntity>>> getAllCourses({
    required int subjectId,
    required String category,
  }) {
    return _academyRepository.getAllCourses(
        subjectId: subjectId, category: category);
  }

  /// Subjects
  /// 🎯 Récupère toutes les matières associées à une spécialité donnée
  Future<Either<NetworkException, List<SubjectEntity>>>
      getSubjectByspecialityId({required int specialityId}) async {
    return _academyRepository.getSubjectByspecialityId(
        specialityId: specialityId);
  }

  /// 🎓 Récupère toutes les matières correspondant au niveau d'étude spécifié
  Future<Either<NetworkException, List<SubjectEntity>>> getSubjectByLevel(
      {required int subjectId, required int level}) async {
    return _academyRepository.getSubjectByLevel(
        subjectId: subjectId, level: level);
  }

  Future<Either<DatabaseException, void>> saveListSubjects(
      List<SubjectEntity> listSubjectEntity) async {
    return _academyRepository.saveListSubjects(listSubjectEntity);
  }

  Future<Either<DatabaseException, List<SubjectEntity>>>
      getAllSavedSubjects() async {
    return _academyRepository.getAllSavedSubjects();
  }

  /// delete a pdf file
  Future<Either<DatabaseException, void>> deleteAllSubjectCache() async {
    return _academyRepository.deleteAllSubjectCache();
  }

  Future<Either<DatabaseException, void>> deleteSubjectId(int subjectId) async {
    return _academyRepository.deleteSubjectId(subjectId);
  }
}
