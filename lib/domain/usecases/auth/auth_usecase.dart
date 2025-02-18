import 'package:dartz/dartz.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';
import 'package:onbush/domain/entities/mentee/mentee_entity.dart';
import 'package:onbush/domain/entities/user/user_entity.dart';
import 'package:onbush/domain/repositories/auth/auth_repository.dart';

class AuthUseCase {
  final AuthRepository _authRepository;

  AuthUseCase(this._authRepository);
  Future<Either<NetworkException, UserEntity?>> connexion({
    required String device,
  }) async {
    return _authRepository.connexion(device: device);
  }

  /// login user with the given device id
  Future<Either<NetworkException, UserEntity?>> login(
      {required String device, required String email}) async {
    return _authRepository.login(device: device, email: email);
  }

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
  }) async {
    return _authRepository.registerUser(
        username: username,
        device: device,
        studentId: studentId,
        academyLevel: academyLevel,
        schoolId: schoolId,
        majorStudy: majorStudy,
        role: role,
        email: email,
        birthDate: birthDate,
        gender: gender,
        phone: phone);
  }

  Future<Either<NetworkException, void>> logout(
      {required String device, required String email}) async {
    return _authRepository.logout(device: device, email: email);
  }

  Future<Either<NetworkException, List<MenteeEntity>>> getAllMentees(
      {required String device, required String email}) async {
    return _authRepository.getAllMentees(device: device, email: email);
  }
}
