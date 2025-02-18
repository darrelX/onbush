import 'package:equatable/equatable.dart';

/// Exception personnalisée pour les erreurs liées à SharedPreferences.
class DatabaseException extends Equatable implements Exception {
  final String message;

  const DatabaseException(this.message);

  @override
  List<Object?> get props => [message];

  /// Constructeur pour générer une exception à partir d'une erreur de SharedPreferences.
  factory DatabaseException.fromError(dynamic error) {
    return DatabaseException("Erreur SharedPreferences : ${error.toString()}");
  }
}
