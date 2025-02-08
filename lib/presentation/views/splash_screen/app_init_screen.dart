import 'package:animate_do/animate_do.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/presentation/views/auth/logic/auth_cubit/auth_cubit.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/extensions/context_extensions.dart';

import '../../../core/routing/app_router.dart';

@RoutePage()
class AppInitScreen extends StatefulWidget {
  const AppInitScreen({super.key});

  @override
  State<AppInitScreen> createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    context
        .read<AuthCubit>()
        .connexion();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          print("state $state");
          if (state is CheckAuthStateFailure || state is AuthInitial) {
            context.router.pushAndPopUntil(
              const AuthRoute(),
              predicate: (route) => false,
            );
          }

          if (state is CheckAuthStateSuccess) {
            // await context.getIt<>();
            getIt.get<ApplicationCubit>().setUser(state.user);
            context.router.pushAndPopUntil(
              const ApplicationRoute(),
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
            //     AppButton(
            //       onPressed: (){
            //             context
            // .read<AuthCubit>()
            // .connexion(appareil: getIt<LocalStorage>().getString('device')!);
            //       },
            //       text: "papa",
            //     )
          ],
        ),
      ),
    );
  }
}
