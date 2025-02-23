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
  Future<dynamic> login({required String device, required String email}) async {
    try {
      final Response response = await _dioAccountApi.post(
        '/auth/login/user',
        data: {
          "appareil": device,
          "email": email,
        },
      );

      final Map<String, dynamic> data =
          response.data["data"] as Map<String, dynamic>;
      if (!data.containsKey("token")) {
        return data["email"];
      } else {
        return UserModel.fromJson(data);
      }
    } catch (e) {
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

  @override
  Future<void> editProfil(
      {required String device,
      required String studentId,
      required String name,
      required String gender,
      required String avatar,
      required String phone,
      required String level,
      required String language,
      required String email,
      required String birthday,
      required String role}) async {
    try {
      final Response response =
          await _dioAccountApi.post("/auth/update/user", data: {
        "appareil": device,
        "matricule": studentId,
        "nom": name,
        "email": email,
        "telephone": phone,
        "sexe": gender,
        "naissance": birthday,
        "niveau": level,
        "avatar": avatar,
        "lang": language,
        "role": role
      });
    } catch (e) {
      rethrow;
    }
  }
}
