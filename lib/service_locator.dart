import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:onbush/auth/data/repositories/auth_repository.dart';
import 'package:onbush/auth/logic/otp_cubit/otp_bloc.dart';
import 'package:onbush/history/data/repositories/ticket_repository.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/connectivity/bloc/network_cubit.dart';
import 'package:onbush/topup/cubit/transaction_cubit.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/networking/http_logger_interceptor.dart';
import 'shared/networking/token_interceptor.dart';
import 'shared/routing/app_router.dart';

final getIt = GetIt.instance;

void setupLocator() {
  //route
  getIt.registerSingleton<AppRouter>(AppRouter());

  //logger
  getIt.registerSingleton<Logger>(
    Logger(
      printer: PrettyPrinter(colors: true),
    ),
  );

  // SharedPreferences
  getIt.registerLazySingleton<Future<SharedPreferences>>(
      () async => SharedPreferences.getInstance());

  // Dio
  getIt.registerSingleton<Dio>(
    Dio(BaseOptions(
      baseUrl: 'https://api.data.onbush237.com/v1',
      connectTimeout: const Duration(seconds: 12),
      receiveTimeout: const Duration(seconds: 12),
      headers: {
        'Accept': 'application/json',
      },
    ))
      ..interceptors.addAll(
        [
          TokenInterceptor(),
          HttpLoggerInterceptor(),
        ],
      ),
  );

  getIt.registerSingleton<ApplicationCubit>(ApplicationCubit());

  getIt.registerSingleton<AuthRepository>(
    AuthRepository(
        dio: getIt.get<Dio>(), prefs: getIt.get<Future<SharedPreferences>>()),
  );



  getIt.registerSingleton<TransactionCubit>(TransactionCubit());

  getIt.registerSingleton<OtpBloc>(OtpBloc());

  getIt.registerSingleton<NetworkCubit>(NetworkCubit());
}
