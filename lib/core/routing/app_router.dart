import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onbush/domain/entities/course/course_entity.dart';
import 'package:onbush/domain/entities/pdf_file/pdf_file_entity.dart';
import 'package:onbush/domain/entities/subject/subject_entity.dart';
import 'package:onbush/presentation/views/dashboard/course/pages/course_screen.dart';
import 'package:onbush/presentation/views/dashboard/course/pages/course_selected_menu_screen.dart';
import 'package:onbush/presentation/views/dashboard/course/pages/pdf_view_screen.dart';
import 'package:onbush/presentation/views/dashboard/download/pages/download_pdf_view_screen.dart';
import 'package:onbush/presentation/views/dashboard/profil/pages/edit_avatar_screen.dart';
import 'package:onbush/presentation/views/dashboard/profil/pages/edit_profil_screen.dart';
import 'package:onbush/presentation/views/pricing/pages/price_screen.dart';
import 'package:onbush/presentation/views/dashboard/course/pages/subject_screen.dart';
import 'package:onbush/presentation/views/dashboard/download/pages/download_screen.dart';
import 'package:onbush/presentation/views/dashboard/notification/pages/notification_scren.dart';
import 'package:onbush/presentation/views/onboarding/pages/onboarding_screen.dart';
import 'package:onbush/presentation/views/dashboard/profil/pages/ambassador_space_screen.dart';
import 'package:onbush/presentation/views/dashboard/profil/pages/language_screen.dart';
import 'package:onbush/presentation/views/dashboard/profil/pages/profil_screen.dart';
import '../../presentation/views/splash_screen/app_init_screen.dart';
import '../../presentation/views/auth/pages/auth_screen.dart';
import '../application/pages/application_screen.dart';
import '../../presentation/views/dashboard/history/pages/history_screen.dart';
import '../../presentation/views/dashboard/home/pages/home_screen.dart';
import 'package:onbush/presentation/views/otp_screen/pages/otp_input_screen.dart';

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
              path: 'subject',
              page: SubjectRoute.page,
            ),
            AutoRoute(path: 'ammbassador', page: AmbassadorSpaceRoute.page),
            AutoRoute(
              path: 'profil',
              page: ProfilRoute.page,
            ),
          ],
        ),
        // CustomRoute(
        //   page: AuthRoute.page,
        //   transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //     var tween = Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
        //     var curvedAnimation = CurvedAnimation(
        //       parent: animation,
        //       curve: Curves.easeInOut,
        //     );

        //     return SlideTransition(
        //       position: tween.animate(curvedAnimation),
        //       child: child,
        //     );
        //   },
        //   durationInMilliseconds: 300,
        // ),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: OTPInputRoute.page),
        AutoRoute(page: DownloadRoute.page),

        // AutoRoute(page: ForgetPasswordRoute.page),
        // AutoRoute(page: NewPasswordRoute.page),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: PriceRoute.page),
        AutoRoute(page: NotificationRoute.page),
        AutoRoute(page: LanguageRoute.page),
        AutoRoute(page: CourseRoute.page),
        AutoRoute(page: CourseSelectionMenuRoute.page),
        AutoRoute(page: PdfViewRoute.page),
        AutoRoute(page: DownloadPdfViewRoute.page),
        AutoRoute(page: EditProfilRoute.page),
        AutoRoute(page: EditAvatarRoute.page),
      ];
}
