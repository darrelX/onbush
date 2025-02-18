import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:onbush/presentation/views/auth/data/models/college_model.dart';
import 'package:onbush/presentation/views/auth/data/models/specialty_model.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/database/local_storage.dart';
// Assurez-vous que cet import est nécessaire
import '../models/user_model.dart';

class AuthRepository {
  final Dio _dioAccountApi;
  final Dio _dioDataApi;
  final LocalStorage _prefs;

  AuthRepository()
      : _dioAccountApi = getIt.get<Dio>(instanceName: 'accountApi'),
        _prefs = getIt.get<LocalStorage>(),
        _dioDataApi = getIt.get<Dio>(instanceName: 'dataApi');

  // Future<UserModel?> _saveTokenAndFetchUser(String token) async {
  //   SharedPreferences storage = await prefs!;
  //   storage.setString('token', token);
  //   return getUser();
  // }

  // Future<UserModel?> getUser() async {
  //   // SharedPreferences storage = await prefs!;
  //   String? token = _prefs.getString('token');

  //   if (token == null) {
  //     log("No token found in storage.");
  //     return null;
  //   }

  //   try {
  //     Response response = await _dioAccountApi.get(
  //       '/auth/user',
  //       options: Options(headers: {'Authorization': 'Bearer $token'}),
  //     );
  //     return UserModel.fromJson(response.data);
  //   } catch (e) {
  //     log("Failed to get user: ${e.toString()}");
  //     rethrow;
  //   }
  // }

  Future<UserModel>? connexion({
    required String appareil,
  }) async {
    try {
      Response response = await _dioAccountApi.get(
        '/connexion/$appareil/active',
      );
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  // Future<Either<bool, UserModel>> connexion({
  //   required String appareil,
  // }) async {
  //   try {
  //     Response response = await _dioAccountApi.get(
  //       '/connexion/$appareil/active',
  //     );
  //     if (response.data['data'] is String) {
  //       return const Left(false);
  //     } else {
  //       return Right(UserModel.fromJson(response.data["data"]));
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<Either<bool, UserModel>> login({
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
      final Map<String, dynamic> result =
          response.data["data"] as Map<String, dynamic>;
      if (!result.containsKey("token")) {
        return const Left(true);
      } else {
        return Right(UserModel.fromJson(response.data["data"]));
      }
      // return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      log("Login error: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> register({
    required String username,
    required String device,
    required String studentId,
    required int academyLevel,
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
          "niveau": academyLevel,
          "matricule": studentId,
          "nom": username,
          "sexe": gender,
          "email": email,
          "naissance": birthDate,
          "telephone": phone,
          "etablissement_id": schoolId,
          "role": role,
          "filiere_id": majorStudy,
          "code_Parrain": 0,
        },
      );
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

  Future<List<SpecialityModel>> allSpecialities(int schoolId) async {
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
}
