import 'package:onbush/data/models/college/college_model.dart';

/// Abstract class for remote data source of college entity.
abstract class CollegeRemoteDataSource {
  /// get all availables collegess
  Future<List<CollegeModel>> getAllColleges();

  /// returns the college with the given id
  Future<CollegeModel> getCollegeById({required int collegeId});

}
