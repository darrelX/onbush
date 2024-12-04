import 'package:dio/dio.dart';

class Utils {
  static String extractErrorMessage(
    dynamic error,
  ) {
    try {
      if (error is String) {
        return error;
      }

      if (error is DioException) {
        Response response = error.response!;
        final Map<String, dynamic> data = response.data as Map<String, dynamic>;
        if (data is String) {
          return data.toString();
        }
        return data['message'].toString();
      }

      return error.toString();
    } catch (e) {
      return 'Impossible de traiter l\'erreur';
    }
  }

  static String extractErrorMessageFromMap(
    dynamic error,
    Map<String, String> errorDocumentation,
  ) {
    try {
      String? code;

      // Vérifie si l'erreur est une exception Dio
      if (error is DioException) {
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout) {
          return 'La requête a expiré. Veuillez vérifier votre connexion ou réessayer plus tard.';
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
        return errorDocumentation[code]!;
      }

      // Message par défaut si aucun code n'est trouvé
      return 'Une erreur inconnue s\'est produite';
    } catch (e) {
      return 'Impossible de traiter l\'erreur';
    }
  }
}
