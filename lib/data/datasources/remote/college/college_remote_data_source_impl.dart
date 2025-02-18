import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/college/college_remote_data_source.dart';
import 'package:onbush/data/models/college/college_model.dart';

class CollegeRemoteDataSourceImpl extends CollegeRemoteDataSource {
  final Dio _dioDataApi;

  CollegeRemoteDataSourceImpl(this._dioDataApi);

  @override
  Future<List<CollegeModel>> getAllColleges() async {
    try {
      Response response = await _dioDataApi.get("/etablissements");
      List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((item) => CollegeModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  @override 
  Future<CollegeModel> getCollegeById({required int collegeId}) async {
    try {
      Response response = await _dioDataApi.get("/etablissements/$collegeId");
      return CollegeModel.fromJson(response.data['data'] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

}
