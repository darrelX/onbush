import 'package:onbush/data/models/course/course_model.dart';

abstract class CourseRemoteDataSource {
  /// get all availables courses
  Future<List<CourseModel>> getAllCourses({
    required int subjectId,
    required String category,
  });
}
