/// Abstract class that defines the contract for OTP (One-Time Password) remote data operations
abstract class OtpRemoteDataSource {
  /// Submits an OTP code for verification
  /// 
  /// Parameters:
  /// - [code] The OTP code to verify
  /// - [email] User's email address
  /// - [device] Device identifier
  /// - [role] User's role (optional)
  /// - [type] Type of OTP verification (defaults to 'register')
  /// 
  /// Returns a Future that completes with the verification result
  Future<dynamic> submit({
    required int code,
    required String email,
    required String device,
    required String? role,
    String type = 'register',
  });

  /// Requests a new OTP code to be sent
  /// 
  /// Parameters:
  /// - [email] User's email address
  /// - [device] Device identifier
  /// - [role] User's role (defaults to "etudiant")
  /// - [type] Type of OTP request (defaults to 'register')
  /// 
  /// Returns a Future that completes when the OTP is sent
  Future<void> reSendOtp({
    required String email,
    required String device,
    String role = "etudiant",
    String type = 'register'
  });
}
