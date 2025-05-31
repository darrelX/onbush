import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class NetworkException extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const NetworkException({required this.message, required this.statusCode});

  factory NetworkException.errorFrom(dynamic error) {
    String message = "Une erreur inconnue s'est produite.";
    int statusCode = 500; // Valeur par défaut

    if (error is DioException) {
      // Vérifier d'abord le type d'erreur Dio

      // Ensuite, si le serveur a répondu, on met à jour message et statusCode
      if (error.response != null) {
        Response response = error.response!;
        final dynamic data = response.data;

        if (data is Map<String, dynamic> && data.containsKey("data")) {
          message = data["data"].toString();
        } else if (data is String) {
          message = "Une erreur réseau inconnue s'est produite.";
        } else {
          message = _handleDioError(error);

          statusCode = _getStatusCodeFromErrorType(error.type);
        }

        statusCode = response.statusCode ?? statusCode;
      } else {
        message = _handleDioError(error);

        statusCode = _getStatusCodeFromErrorType(error.type);
      }
    }

    return NetworkException(message: message, statusCode: statusCode);
  }

  /// Méthode pour récupérer le message d'erreur en fonction du type d'erreur Dio
  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Délai d'attente de la connexion dépassé.";
      case DioExceptionType.sendTimeout:
        return "Délai d'envoi dépassé.";
      case DioExceptionType.receiveTimeout:
        return "Délai de réception dépassé.";
      case DioExceptionType.badCertificate:
        return "Certificat de sécurité invalide.";
      case DioExceptionType.badResponse:
        return "Réponse invalide du serveur.";
      case DioExceptionType.cancel:
        return "Requête annulée.";
      case DioExceptionType.connectionError:
        return "Problème de connexion au réseau.";
      case DioExceptionType.unknown:
        return "Une erreur réseau inconnue s'est produite.";
    }
  }

  /// Méthode pour récupérer le code HTTP en fonction du type d'erreur
  static int _getStatusCodeFromErrorType(DioExceptionType type) {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 408;
      case DioExceptionType.badCertificate:
        return 495;
      case DioExceptionType.badResponse:
        return 500;
      case DioExceptionType.cancel:
        return 499;
      case DioExceptionType.connectionError:
        return 503;
      case DioExceptionType.unknown:
        return 520;
    }
  }

  @override
  List<Object?> get props => [message, statusCode];
}
