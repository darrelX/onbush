import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onbush/auth/presentation/pages/new_password_screen.dart';
import 'package:onbush/onboarding/pages/price_screen.dart';
import 'package:onbush/course/course_screen.dart';
import 'package:onbush/download/download_screen.dart';
import 'package:onbush/notification/notification_scren.dart';
import 'package:onbush/onboarding/pages/onboarding_screen.dart';
import 'package:onbush/profil/pages/ambassador_space_screen.dart';
import 'package:onbush/profil/pages/profil_screen.dart';
import '../../app_init_screen.dart';
import '../../auth/presentation/pages/auth_screen.dart';
import '../../topup/presentation/topup_screen.dart';
import '../pages/application_screen.dart';
import '../../history/presentation/pages/history_screen.dart';
import '../../home/pages/home_screen.dart';
import '../../auth/presentation/pages/profil_screen.dart';
import 'package:onbush/auth/presentation/pages/otp_input_screen.dart';
import 'package:onbush/auth/presentation/pages/forget_password_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: AppInitRoute.page,
          initial: true,
        ),
        AutoRoute(
          page: ApplicationRoute.page,
          path: '/dashboard',
          children: [
            AutoRoute(
              path: '',
              page: HomeRoute.page,
            ),
            AutoRoute(
              path: 'courses',
              page: CourseRoute.page,
            ),
            AutoRoute(
              path: 'history',
              page: HistoryRoute.page,
            ),
            AutoRoute(
              path: 'profil',
              page: ProfilRoute.page,
            ),
          ],
        ),
        CustomRoute(
          page: LoginRoute.page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOut,
            );

            return SlideTransition(
              position: tween.animate(curvedAnimation),
              child: child,
            );
          },
          durationInMilliseconds: 500,
        ),
        AutoRoute(page: OTPInputRoute.page),
        AutoRoute(page: DownloadRoute.page),
        AutoRoute(page: AmbassadorSpaceRoute.page),
        AutoRoute(page: ForgetPasswordRoute.page),
        AutoRoute(page: NewPasswordRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: PriceRoute.page),
      ];
}
