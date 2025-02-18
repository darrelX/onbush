import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class NetworkException extends Equatable implements Exception {
  late final String message;
  late final int? statusCode;
  NetworkException.extractErrorMessage(
    dynamic error,
  ) {
    try {
      if (error is String) {
        message =  error;
      }

      if (error is DioException) {
        Response response = error.response!;
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data is String) {
          message = data.toString();
        }
        message = data['message'].toString();
      }

      message = error.toString();
    } catch (e) {
      message = 'Impossible de traiter l\'erreur';
    }
  }

  NetworkException.extractErrorMessageFromMap(
    dynamic error,
    Map<String, String> errorDocumentation,
  ) {
    try {
      String? code;

      // Vérifie si l'erreur est une exception Dio
      if (error is DioException) {
           statusCode = error.response!.statusCode!;
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout) {
          message = 'La requête a expiré. Veuillez vérifier votre connexion ou réessayer plus tard.';
        }

        Response? response = error.response;
        final Map<String, dynamic> data =
            response!.data as Map<String, dynamic>;
        if (data.containsKey('data')) {
          code = data['data'].toString(); // Récupère le code d'erreur
        }
      } else if (error is Map<String, dynamic> && error.containsKey('data')) {
        code = error['data'].toString(); // Si erreur est un Map directement
      }

      // Associe le code d'erreur à un message
      if (code != null && errorDocumentation.containsKey(code)) {
        message =  errorDocumentation[code]!;
      }

      // Message par défaut si aucun code n'est trouvé
      message =  'Une erreur inconnue s\'est produite';
    } catch (e) {
      message =  'Impossible de traiter l\'erreur';
    }
  }

  @override
  List<Object?> get props => [message, statusCode];
}
