class UserRegistrationIncompleteException implements Exception {
  final String message;
  UserRegistrationIncompleteException([this.message = "User registration incomplete"]);

  @override
  String toString() => message;
}
