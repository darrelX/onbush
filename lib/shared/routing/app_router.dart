import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onbush/auth/presentation/pages/new_password_screen.dart';

import '../../app_init_screen.dart';
import '../../auth/presentation/pages/login_screen.dart';
import '../../auth/presentation/pages/register_screen.dart';
import '../../game/presentation/pages/game_screen.dart';
import '../../topup/presentation/topup_screen.dart';
import '../pages/application_screen.dart';
import '../../history/presentation/pages/history_screen.dart';
import '../pages/home_screen.dart';
import '../../auth/presentation/pages/profile_screen.dart';
import '../../shop/presentation/pages/shop_screen.dart';
import 'package:onbush/history/presentation/pages/history_game_screen.dart';
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
              path: 'shop',
              page: ShopRoute.page,
            ),
            AutoRoute(
              path: 'history',
              page: HistoryRoute.page,
            ),
            AutoRoute(
              path: 'profile',
              page: ProfileRoute.page,
            ),
          ],
        ),
        AutoRoute(
          page: GameRoute.page,
        ),
        AutoRoute(
          page: LoginRoute.page,
        ),
        AutoRoute(page: HistoryGameRoute.page),
        AutoRoute(page: OTPInputRoute.page),
        AutoRoute(
          page: RegisterRoute.page,
        ),
        AutoRoute(
          page: TopUpRoute.page,
        ),
        AutoRoute(page: ForgetPasswordRoute.page),
        AutoRoute(page: NewPasswordRoute.page),
        AutoRoute(page: OTPInputRoute.page),
      ];
}
