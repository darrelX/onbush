import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/data/datasources/remote/mentee/mentee_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/user/user_remote_data_source.dart';
import 'package:onbush/domain/entities/mentee/mentee_entity.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/repositories/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserRemoteDataSource _userRemoteDataSource;
  final MenteeRemoteDataSource _menteeRemoteDataSource;

  AuthRepositoryImpl(
      {required UserRemoteDataSource userRemoteDataSource,
      required MenteeRemoteDataSource menteeRemoteDataSource})
      : _userRemoteDataSource = userRemoteDataSource,
        _menteeRemoteDataSource = menteeRemoteDataSource;

  @override
  Future<Either<NetworkException, UserEntity?>> connexion({
    required String device,
  }) async {
    try {
      final result = await _userRemoteDataSource.connexion(device: device);
      return Right(result?.toEntity());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  /// login user with the given device id
  @override
  Future<Either<NetworkException, dynamic>> login(
      {required String device, required String email}) async {
    try {
      final result =
          await _userRemoteDataSource.login(device: device, email: email);
      if (result is String) {
        return Right(result);
      } else {
        return Right(result?.toEntity());
      }
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  /// register user with the given informations
  @override
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
  }) async {
    try {
      final result = await _userRemoteDataSource.registerUser(
          username: username,
          device: device,
          studentId: studentId,
          academyLevel: academyLevel,
          gender: gender,
          schoolId: schoolId,
          majorStudy: majorStudy,
          phone: phone,
          role: role,
          email: email,
          birthDate: birthDate);
      return Right(result);
    } catch (e) {
      print(e);
      return Left(NetworkException.errorFrom(e));
    }
  }

  @override
  Future<Either<NetworkException, void>> logout(
      {required String device, required String email}) async {
    try {
      final result =
          await _userRemoteDataSource.logout(device: device, email: email);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  @override
  Future<Either<NetworkException, List<MenteeEntity>>> getAllMentees(
      {required String device, required String email}) async {
    try {
      final result = await _menteeRemoteDataSource.getAllMentees(
          device: device, email: email);
      return Right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }

  @override
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
      required String role}) async {
    try {
      final result = await _userRemoteDataSource.editProfil(
          device: device,
          studentId: studentId,
          name: name,
          gender: gender,
          avatar: avatar,
          phone: phone,
          level: level,
          language: language,
          email: email,
          birthday: birthday,
          role: role);
      return Right(result);
    } catch (e) {
      return Left(NetworkException.errorFrom(e));
    }
  }
}
