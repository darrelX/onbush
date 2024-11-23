import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:onbush/auth/data/repositories/auth_repository.dart';
import 'package:onbush/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/auth/logic/otp_cubit/otp_bloc.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/connectivity/bloc/network_cubit.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/networking/http_logger_interceptor.dart';
import 'shared/networking/token_interceptor.dart';
import 'shared/routing/app_router.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt

    // SharedPreferences
    ..registerSingleton<Future<SharedPreferences>>(
        SharedPreferences.getInstance())

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
    ..registerSingleton<ApplicationCubit>(ApplicationCubit())
    ..registerSingleton<AuthCubit>(
      AuthCubit(),
    )
    ..registerSingleton<OtpBloc>(OtpBloc())
    ..registerSingleton<NetworkCubit>(NetworkCubit());
}
