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

      // Gestion des erreurs Dio
      if (error is NetworkException) {
        if (errorDocumentation.containsKey(error.message.toString())) {
          return errorDocumentation[error.message.toString()]!;
        }
        return error.message;
      }

      // Erreur sous forme de Map directement
      else if (error is Map<String, dynamic>) {
        code = error['data']?.toString();
      }

      // Associe le code d'erreur à un message de documentation
      if (code != null && errorDocumentation.containsKey(code)) {
        return errorDocumentation[code]!;
      }

      return 'Une erreur inconnue s\'est produite';
    } catch (_) {
      return 'Impossible de traiter l\'erreur';
    }
  }
}
