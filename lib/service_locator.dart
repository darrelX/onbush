import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:onbush/data/datasources/local/pdf/pdf_local_data_source.dart';
import 'package:onbush/data/datasources/local/pdf/pdf_local_data_source_impl.dart';
import 'package:onbush/data/datasources/local/subject/subject_local_data_source.dart';
import 'package:onbush/data/datasources/local/subject/subject_local_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/college/college_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/college/college_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/course/course_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/course/course_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/mentee/mentee_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/mentee/mentee_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/otp/otp_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/otp/otp_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/payment/payment_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/payment/payment_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/pdf/pdf_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/pdf/pdf_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/speciality/speciality_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/speciality/speciality_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/subject/subject_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/subject/subject_remote_data_source_impl.dart';
import 'package:onbush/data/datasources/remote/user/user_remote_data_source.dart';
import 'package:onbush/data/datasources/remote/user/user_remote_data_source_impl.dart';
import 'package:onbush/data/repositories/academic/academic_repository_impl.dart';
import 'package:onbush/data/repositories/auth/auth_repository_impl.dart';
import 'package:onbush/data/repositories/otp/otp_repository_impl.dart';
import 'package:onbush/data/repositories/payment/payment_repository_impl.dart';
import 'package:onbush/data/repositories/pdf/pdf_repository_impl.dart';
import 'package:onbush/domain/repositories/academic/academic_repository.dart';
import 'package:onbush/domain/repositories/auth/auth_repository.dart';
import 'package:onbush/domain/repositories/otp/otp_repository.dart';
import 'package:onbush/domain/repositories/payment/payment_repository.dart';
import 'package:onbush/domain/repositories/pdf/pdf_repository.dart';
import 'package:onbush/domain/usecases/academic/academic_usecase.dart';
import 'package:onbush/domain/usecases/auth/auth_usecase.dart';
import 'package:onbush/domain/usecases/otp/otp_usecase.dart';
import 'package:onbush/domain/usecases/payment/payment_usecase.dart';
import 'package:onbush/domain/usecases/pdf/pdf_usecase.dart';
import 'package:onbush/presentation/blocs/academic/academy/academy_cubit.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_file_cubit.dart';
import 'package:onbush/presentation/views/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/presentation/views/otp_screen/logic/otp_cubit/otp_bloc.dart';
import 'package:onbush/presentation/views/dashboard/download/logic/cubit/download_cubit.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:logger/logger.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/presentation/views/pricing/logic/cubit/payment_cubit.dart';

import 'core/networking/http_logger_interceptor.dart';
import 'core/networking/token_interceptor.dart';
import 'core/routing/app_router.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt
    //route
    ..registerSingleton<AppRouter>(AppRouter())
    ..registerSingleton<Logger>(
      Logger(
        printer: PrettyPrinter(colors: true),
      ),
    )

    // SharedPreferences
    ..registerSingleton<LocalStorage>(LocalStorage())

    // Dio
    ..registerLazySingleton<Dio>(
      () => Dio(BaseOptions(
        baseUrl: '${dotenv.env['API_ACCOUNT']}',
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ))
        ..interceptors.addAll([
          TokenInterceptor(),
          HttpLoggerInterceptor(),
        ]),
      instanceName: 'accountApi',
    )
    ..registerLazySingleton<Dio>(
      () => Dio(BaseOptions(
        baseUrl: '${dotenv.env['API_DATA']}',
        connectTimeout: const Duration(seconds: 12),
        receiveTimeout: const Duration(seconds: 12),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ))
        ..interceptors.addAll([
          TokenInterceptor(),
          HttpLoggerInterceptor(),
        ]),
      instanceName: 'dataApi',
    )

    //* Datasources
    ..registerLazySingleton<PdfLocalDataSource>(
        () => PdfLocalDataSourceImpl(localStorage: getIt<LocalStorage>()))
    ..registerLazySingleton<CollegeRemoteDataSource>(
        () => CollegeRemoteDataSourceImpl(getIt<Dio>(instanceName: 'dataApi')))
    ..registerLazySingleton<CourseRemoteDataSource>(
        () => CourseRemoteDataSourceImpl(
                dioDataApi: getIt<Dio>(
              instanceName: 'dataApi',
            )))
    ..registerLazySingleton<MenteeRemoteDataSource>(
        () => MenteeRemoteDataSourceImpl(
                dioApiData: getIt<Dio>(
              instanceName: 'dataApi',
            )))
    ..registerLazySingleton<PaymentRemoteDataSource>(
        () => PaymentRemoteDataSourceImpl(getIt<Dio>(
              instanceName: 'accountApi',
            )))
    ..registerLazySingleton<PdfRemoteDataSource>(
        () => PdfRemoteDataSourceImpl(getIt<Dio>(
              instanceName: 'dataApi',
            )))
    ..registerLazySingleton<SpecialityRemoteDataSource>(
        () => SpecialityRemoteDataSourceImpl(
            dioDataApi: getIt<Dio>(
              instanceName: 'dataApi',
            ),
            dioAccountApi: getIt<Dio>(
              instanceName: 'accountApi',
            )))
    ..registerLazySingleton<SubjectRemoteDataSource>(
        () => SubjectRemoteDataSourceImpl(getIt<Dio>(
              instanceName: 'dataApi',
            )))
    ..registerLazySingleton<SubjectLocalDataSource>(
        () => SubjectLocalDataSourceImpl(getIt<LocalStorage>()))
    ..registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(
                dioAccountApi: getIt<Dio>(
              instanceName: 'accountApi',
            )))
    ..registerLazySingleton<OtpRemoteDataSource>(
        () => OtpRemoteDataSourceImpl(getIt<Dio>(
              instanceName: 'accountApi',
            )))

    //* Repositories
    ..registerLazySingleton<OtpRepository>(() => OtpRepositoryImpl(getIt()))
    ..registerLazySingleton<AcademyRepository>(() => AcademyRepositoryImpl(
        subjectLocalDataSource: getIt(),
        collegeRemoteDataSource: getIt(),
        specialityRemoteDataSource: getIt(),
        courseRemoteDataSource: getIt(),
        subjectRemoteDataSource: getIt()))
    ..registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
        userRemoteDataSource: getIt(), menteeRemoteDataSource: getIt()))
    ..registerLazySingleton<PdfRepository>(() => PdfRepositoryImpl(
        pdfRemoteDataSource: getIt(), pdfLocalDataSource: getIt()))
    ..registerLazySingleton<PaymentRepository>(
        () => PaymentRepositoryImpl(getIt()))

    //* UseCases
    ..registerLazySingleton<AcademyUsecase>(() => AcademyUsecase(getIt()))
    ..registerLazySingleton<AuthUseCase>(() => AuthUseCase(getIt()))
    ..registerLazySingleton<PdfUseCase>(() => PdfUseCase(getIt()))
    ..registerLazySingleton<OtpUseCase>(() => OtpUseCase(getIt()))
    ..registerLazySingleton<PaymentUseCase>(() => PaymentUseCase(getIt()))

    //* Bloccs
    ..registerLazySingleton<AuthCubit>(
      () => AuthCubit(getIt()),
    )
    ..registerLazySingleton<ApplicationCubit>(() => ApplicationCubit())
    ..registerSingleton<OtpBloc>(
        OtpBloc(otpUseCase: getIt<OtpUseCase>(), repository: getIt()))
    ..registerSingleton<DownloadCubit>(DownloadCubit())
    ..registerSingleton<PaymentCubit>(PaymentCubit(getIt()))
    ..registerLazySingleton<AcademyCubit>(() => AcademyCubit(getIt()))
    ..registerLazySingleton<PdfFileCubit>(() => PdfFileCubit(getIt()));


  // ..registerSingleton<NetworkCubit>(NetworkCubit());
}
