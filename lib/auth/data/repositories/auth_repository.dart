import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:onbush/auth/data/models/college_model.dart';
import 'package:onbush/auth/data/models/specialtie_model.dart';
import 'package:onbush/service_locator.dart';
// Assurez-vous que cet import est nécessaire
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthRepository {
  final Dio _dioAccountApi;
  final Dio _dioDataApi;
  final Future<SharedPreferences>? prefs;

  AuthRepository()
      : _dioAccountApi = getIt.get<Dio>(instanceName: 'accountApi'),
        prefs = SharedPreferences.getInstance(),
        _dioDataApi = getIt.get<Dio>(instanceName: 'dataApi');

  // Future<UserModel?> _saveTokenAndFetchUser(String token) async {
  //   SharedPreferences storage = await prefs!;
  //   storage.setString('token', token);
  //   return getUser();
  // }

  Future<UserModel?> getUser() async {
    SharedPreferences storage = await prefs!;
    String? token = storage.getString('token');

    if (token == null) {
      log("No token found in storage.");
      return null;
    }

    try {
      Response response = await _dioAccountApi.get(
        '/auth/user',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return UserModel.fromJson(response.data);
    } catch (e) {
      log("Failed to get user: ${e.toString()}");
      rethrow;
    }
  }

  Future<UserModel?> login({
    required String appareil,
    required String email,
  }) async {
    try {
      Response response = await _dioAccountApi.post(
        '/auth/login/user',
        data: {
          "appareil": appareil,
          "email": email,
        },
      );
      // print("darrel ${UserModel.fromJson(response.data["data"]).avatar}");
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      log("Login error: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> register({
    required String username,
    required String device,
    required String studentId,
    required int academicLevel,
    required int schoolId,
    required int majorStudy,
    required String role,
    required String email,
    required String birthDate,
    required String gender,
    required String phone,
  }) async {
    try {
      final Response response = await _dioAccountApi.post(
        '/auth/register/user',
        data: {
          "appareil": device,
          "niveau": academicLevel,
          "matricule": studentId,
          "nom": username,
          "sexe": gender,
          "email": email,
          "naissance": birthDate,
          "telephone": phone,
          "etablissement_id": schoolId,
          "role": role,
          "filiere_id": majorStudy,
          "code_parrain": 0,
        },
      );
      // return user!;
      // if (response.data != null && response.data['token'] != null) {
      //   return _saveTokenAndFetchUser(response.data['token']);
      // } else {
      //   log("Registration failed: Token is missing from the response.");
      //   return null;
      // }
    } catch (e) {
      log("Registration error: ${e.toString()}");
      rethrow;
    }
  }

  Future<List<CollegeModel>> allColleges() async {
    try {
      Response response = await _dioDataApi.get("/etablissements");
      List<dynamic> data = response.data['data'] as List<dynamic>;
      return data
          .map((item) => CollegeModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log("Failed to get user: ${e.toString()}");
      rethrow;
    }
  }

  Future<List<SpecialtieModel>> allSpecialities(int schoolId) async {
    try {
      Response response = await _dioDataApi.get("/filieres");
      List<dynamic> data = response.data['data'] as List<dynamic>;
      final a = data
          .map((item) => SpecialtieModel.fromJson(item as Map<String, dynamic>))
          .where((e) => e.collegeId == schoolId)
          .toList();
      print(a);
      print(a[0].name);
      return a;
    } catch (e) {
      log("Failed to get user: ${e.toString()}");
      rethrow;
    }
  }
}
