import 'package:onbush/presentation/views/auth/data/models/college_model.dart';

/// Abstract class for remote data source of college entity.
abstract class CollegeRemoteDataSource {
  /// get all availables collegess
  Future<List<CollegeModel>> getColleges();

  /// returns the college with the given id
  Future<CollegeModel> getCollegeById({required int collegeId});

  /// returns the college with the given level's school
  Future<List<CollegeModel>> getCollegeByLevel({required int collegeId, required int level});
}