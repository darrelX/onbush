import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:onbush/core/database/key_storage.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/service_locator.dart';

class TokenInterceptor extends QueuedInterceptor {
  final prefs = getIt.get<LocalStorage>();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var token = prefs.getString(StorageKeys.authToken);
    if (token != null) {
      log("Current token $token", name: "TokenInterceptor+onRequest");
      options.headers["userKey"] = token;
    }

    // try {
    //   options.data ??= <String, dynamic>{};
    //   if (options.method != "GET") {
    //     options.data['_method'] = options.method;
    //     options.method = 'POST';
    //   }
    // } catch (e) {
    //
    // }

    return handler.next(options);
  }

  // @override
  // void onError(DioError err, ErrorInterceptorHandler handler) async {
  //   if (err.type == DioErrorType.response &&
  //       (err.response?.statusCode == 403 || err.response?.statusCode == 401)) {
  //     var options = err.requestOptions;
  //     try {
  //       var newToken = await getIt.get<AuthRepository>().refreshToken();
  //       var dio = getIt.get<Dio>(instanceName: ktik);

  //       if (newToken != null) {
  //         options.headers["Authorization"] = "Bearer $newToken";
  //         dio.fetch(options).then(
  //           (response) {
  //             return response;
  //           },
  //           onError: (e) {
  //             handler.reject(e);
  //           },
  //         );
  //       }
  //     } catch (e) {
  //       return handler.reject(err);
  //     }

  //     debug
  //   }

  //   return handler.next(err);
  // }
}
