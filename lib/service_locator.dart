import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:onbush/presentation/otp_screen/logic/repositories/otp_repository.dart';
import 'package:onbush/presentation/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/presentation/otp_screen/logic/otp_cubit/otp_bloc.dart';
import 'package:onbush/presentation/dashboard/download/logic/cubit/download_cubit.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:logger/logger.dart';
import 'package:onbush/core/database/local_storage.dart';

import 'core/networking/http_logger_interceptor.dart';
import 'core/networking/token_interceptor.dart';
import 'core/routing/app_router.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt

    // SharedPreferences
    ..registerSingleton<LocalStorage>(LocalStorage())

    // Dio
    ..registerSingleton<Dio>(
        Dio(BaseOptions(
          baseUrl: '${dotenv.env['API_ACCOUNT']}',
          connectTimeout: const Duration(seconds: 12),
          receiveTimeout: const Duration(seconds: 12),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          },
        ))
          ..interceptors.addAll(
            [
              TokenInterceptor(),
              HttpLoggerInterceptor(),
            ],
          ),
        instanceName: 'accountApi')
    ..registerSingleton<Dio>(
        Dio(BaseOptions(
          baseUrl: '${dotenv.env['API_DATA']}',
          connectTimeout: const Duration(seconds: 12),
          receiveTimeout: const Duration(seconds: 12),
          headers: {
            'accept': 'application/json',
            'Content-Type': 'application/json'
          },
        ))
          ..interceptors.addAll(
            [
              TokenInterceptor(),
              HttpLoggerInterceptor(),
            ],
          ),
        instanceName: 'dataApi')

    //route
    ..registerSingleton<AppRouter>(AppRouter())

    //logger
    ..registerSingleton<Logger>(
      Logger(
        printer: PrettyPrinter(colors: true),
      ),
    )
    //cubit
    ..registerSingleton<ApplicationCubit>(ApplicationCubit())
    ..registerSingleton<AuthCubit>(
      AuthCubit(),
    )
    ..registerSingleton<OtpBloc>(OtpBloc(repository: OtpRepository()))
    ..registerSingleton<DownloadCubit>(DownloadCubit());

  // ..registerSingleton<NetworkCubit>(NetworkCubit());
}
