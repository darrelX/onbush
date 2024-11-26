import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onbush/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/application/cubit/application_cubit.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';

import 'shared/routing/app_router.dart';
import 'shared/theme/app_colors.dart';

@RoutePage()
class AppInitScreen extends StatefulWidget {
  const AppInitScreen({super.key});

  @override
  State<AppInitScreen> createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen> {
  final AuthCubit _cubit = AuthCubit();

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5000), () {
      _cubit.checkAuthState();
    });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        bloc: _cubit,
        listener: (context, state) {
          if (state is CheckAuthStateFailure || state is AuthInitial) {
            context.router.pushAndPopUntil(
              const AuthRoute(),
              predicate: (route) => false,
            );
          }

          if (state is CheckAuthStateSuccess) {
            // getIt.get<ApplicationCubit>().setUser(state.user);
            // context.router.pushAndPopUntil(
            //   const ApplicationRoute(),
            //   predicate: (route) => false,
            // );
            context.router.pushAndPopUntil(
              const AuthRoute(),
              predicate: (route) => false,
            );
          }

          if (state is AuthOnboardingState) {
            context.router.pushAndPopUntil(const OnboardingRoute(),
                predicate: (route) => false);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ZoomIn(
                duration: const Duration(milliseconds: 3200),
                from: 1.5,
                child: Image.asset(
                  'assets/images/onbush.png',
                  width: context.width - 200.w,
                  // color: AppColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
