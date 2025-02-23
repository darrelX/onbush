import 'package:dio/dio.dart';
import 'package:onbush/core/exceptions/network/network_exception.dart';

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
      print(error.runtimeType);

      // Vérifie si l'erreur est une exception Dio
      if (error is DioException) {
        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout) {
          return error.message!;
        }

        Response? response = error.response;
        final Map<String, dynamic> data =
            response!.data as Map<String, dynamic>;
        if (data.containsKey('data')) {
          code = data['data'].toString(); // Récupère le code d'erreur
        }
      } else if (error is Map<String, dynamic> && error.containsKey('data')) {
        code = error['data'].toString(); // Si erreur est un Map directement
      } else if (error is NetworkException) {
        code = error.message;
        print("code $code");
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
