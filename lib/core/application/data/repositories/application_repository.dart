import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:onbush/presentation/views/auth/data/models/college_model.dart';
import 'package:onbush/presentation/views/auth/data/models/specialty_model.dart';
import 'package:onbush/core/application/data/models/course_model.dart';
import 'package:onbush/core/application/data/models/subject_model.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/database/local_storage.dart';

class ApplicationRepository {
  final Dio _dioDataApi;
  final Dio _dioAccountApi;
  final LocalStorage prefs;

  ApplicationRepository()
      : _dioDataApi = getIt.get<Dio>(instanceName: 'dataApi'),
        _dioAccountApi = getIt.get<Dio>(instanceName: 'accountApi'),
        prefs = getIt.get<LocalStorage>();

  Future<List<CollegeModel>> allColleges() async {
    try {
      Response response = await _dioAccountApi.get("/etablissements");
      List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((item) => CollegeModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("Failed to get user: ${e.toString()}");
      rethrow;
    }
  }

  Future<SpecialityModel?> fetchSpecialitie({required int id}) async {
    try {
      Response response = await _dioDataApi.get("/filiere/$id");
      return SpecialityModel.fromJson(response.data["data"] as Map<String, dynamic>);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SubjectModel>> fetchListSubjectModel(
      {required int specialityId}) async {
    try {
      Response response =
          await _dioDataApi.get("/filiere/$specialityId/matieres");
      List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((item) => SubjectModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  

  Future<List<CourseModel>> fetchListCourseModel({
    required int subjectId,
    required String category,
    void Function(int, int)? onProgress,
  }) async {
    try {
      Response response = await _dioDataApi.get(
        "/matiere/$subjectId/$category",
        onReceiveProgress: onProgress,
      );
      List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((item) => CourseModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<SpecialityModel>> allSpecialities(int schoolId) async {
    try {
      Response response = await _dioAccountApi.get("/filieres");
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

  Future<void> logout({required String appareil, required String email}) async {
    try {
      Response response = await _dioAccountApi.post("/auth/logout", data: {
        "appareil": appareil,
        "email": email,
      });
    } catch (e) {
      rethrow;
    }
  }
}
