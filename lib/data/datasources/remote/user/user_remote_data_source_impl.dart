import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:onbush/core/exceptions/auth/auth_exception.dart';
import 'package:onbush/data/datasources/remote/user/user_remote_data_source.dart';
import 'package:onbush/data/models/user/user_model.dart';

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio _dioAccountApi;

  UserRemoteDataSourceImpl({required Dio dioAccountApi})
      : _dioAccountApi = dioAccountApi;

  @override
  Future<UserModel?> connexion({
    required String device,
  }) async {
    try {
      Response response = await _dioAccountApi.get(
        '/connexion/$device/active',
      );
      return UserModel.fromJson(response.data["data"]);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel?> login(
      {required String device, required String email}) async {
    try {
      final Response response = await _dioAccountApi.post(
        '/auth/login/user',
        data: {
          "device": device,
          "email": email,
        },
      );

      final Map<String, dynamic> data =
          response.data["data"] as Map<String, dynamic>;
      if (!data.containsKey("token")) {
        log("L'utilisateur n'a pas finalisé son inscription.");
        throw UserRegistrationIncompleteException();
      }

      return UserModel.fromJson(data);
    } catch (e) {
      log("Login error: $e");
      rethrow;
    }
  }

  @override
  Future<void> registerUser({
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
          "device": device,
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

  @override
  Future<void> logout({required String device, required String email}) async {
    try {
      Response response = await _dioAccountApi.post("/auth/logout", data: {
        "appareil": device,
        "email": email,
      });
    } catch (e) {
      rethrow;
    }
  }
}
