import 'package:onbush/core/application/data/models/course_model.dart';

abstract class CourseRemoteDataSource {
  /// get all availables courses
  Future<List<CourseModel>> getCourses();

  /// returns the course with the given id
  Future<CourseModel> getCourseById({required int courseId});

  /// returns the course with the given level's school
  Future<List<CourseModel>> getCourseByLevel({required int courseId, required int level});

  /// returns all the courses with the given speciality id
  Future<List<CourseModel>> getCourseBySpeciality({required int specialityId});
}