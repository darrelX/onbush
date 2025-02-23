import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/mentee/mentee_entity.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';

abstract class AuthRepository {
  Future<Either<NetworkException, UserEntity?>> connexion({
    required String device,
  });

  /// login user with the given device id
  Future<Either<NetworkException, dynamic>> login(
      {required String device, required String email});

  /// register user with the given informations
  Future<Either<NetworkException, void>> registerUser({
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

  Future<Either<NetworkException, void>> logout(
      {required String device, required String email});

  Future<Either<NetworkException, List<MenteeEntity>>> getAllMentees(
      {required String device, required String email});
      
  Future<Either<NetworkException, void>> editProfil(
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
