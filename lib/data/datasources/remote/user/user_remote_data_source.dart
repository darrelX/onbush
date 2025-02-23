import 'package:onbush/data/models/user/user_model.dart';

abstract class UserRemoteDataSource {
  const UserRemoteDataSource();

  Future<UserModel?> connexion({
    required String device,
  });

  /// login user with the given device id
  Future<dynamic> login({required String device, required String email});

  /// register user with the given informations
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
  });

  Future<void> logout({required String device, required String email});

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
      required String role});
}
