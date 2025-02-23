import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:onbush/data/datasources/remote/speciality/speciality_remote_data_source.dart';
import 'package:onbush/data/models/speciality/speciality_model.dart';

class SpecialityRemoteDataSourceImpl implements SpecialityRemoteDataSource {
  final Dio _dioDataApi;
  SpecialityRemoteDataSourceImpl(
      {required Dio dioDataApi, required Dio dioAccountApi})
      : _dioDataApi = dioDataApi;

  @override
  Future<List<SpecialityModel>> getAllSpecialities(int schoolId) async {
    try {
      Response response = await _dioDataApi.get("/filieres");
      List<dynamic> data = response.data['data'] as List<dynamic>;
      final a = data
          .map((item) => SpecialityModel.fromJson(item as Map<String, dynamic>))
          .where((e) => e.collegeId == schoolId)
          .toList();
      return a;
    } catch (e) {
      log("Failed to get user: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<SpecialityModel> getSpecialityById({required int specialityId}) async {
    try {
      Response response = await _dioDataApi.get("/filiere/$specialityId");
      return SpecialityModel.fromJson(
          response.data["data"] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }
}
