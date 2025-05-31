import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/course/course_remote_data_source.dart';
import 'package:onbush/data/models/course/course_model.dart';

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final Dio _dioDataApi;

  CourseRemoteDataSourceImpl({required Dio dioDataApi})
      : _dioDataApi = dioDataApi;

  @override
  Future<List<CourseModel>> getAllCourses({
    required int subjectId,
    required String category,
  }) async {
    try {
      Response response = await _dioDataApi.get(
        "/matiere/$subjectId/$category",
      );
      List<dynamic> data = response.data['data'] as List<dynamic>;
      // return data
      //     .map((item) => CourseModel.fromJson(item as Map<String, dynamic>))
      //     .toList();
      return data.expand((json) => CourseModel.fromJsonList(json)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
