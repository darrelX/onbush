// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AmbassadorSpaceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AmbassadorSpaceScreen(),
      );
    },
    AppInitRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AppInitScreen(),
      );
    },
    ApplicationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ApplicationScreen(),
      );
    },
    CourseRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CourseScreen(),
      );
    },
    DownloadRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DownloadScreen(),
      );
    },
    ForgetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgetPasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ForgetPasswordScreen(
          key: args.key,
          title1: args.title1,
          hasForgottenPassword: args.hasForgottenPassword,
          description: args.description,
          title2: args.title2,
        ),
      );
    },
    HistoryRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HistoryScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    NewPasswordRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NewPasswordScreen(),
      );
    },
    NotificationRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const NotificationScreen(),
      );
    },
    OTPInputRoute.name: (routeData) {
      final args = routeData.argsAs<OTPInputRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OTPInputScreen(
          key: args.key,
          number: args.number,
          hasForgottenPassword: args.hasForgottenPassword,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    PriceRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const PriceScreen(),
      );
    },
    ProfilRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilScreen(),
      );
    },
    TopUpRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TopUpScreen(),
      );
    },
  };
}

/// generated route for
/// [AmbassadorSpaceScreen]
class AmbassadorSpaceRoute extends PageRouteInfo<void> {
  const AmbassadorSpaceRoute({List<PageRouteInfo>? children})
      : super(
          AmbassadorSpaceRoute.name,
          initialChildren: children,
        );

  static const String name = 'AmbassadorSpaceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AppInitScreen]
class AppInitRoute extends PageRouteInfo<void> {
  const AppInitRoute({List<PageRouteInfo>? children})
      : super(
          AppInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppInitRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ApplicationScreen]
class ApplicationRoute extends PageRouteInfo<void> {
  const ApplicationRoute({List<PageRouteInfo>? children})
      : super(
          ApplicationRoute.name,
          initialChildren: children,
        );

  static const String name = 'ApplicationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CourseScreen]
class CourseRoute extends PageRouteInfo<void> {
  const CourseRoute({List<PageRouteInfo>? children})
      : super(
          CourseRoute.name,
          initialChildren: children,
        );

  static const String name = 'CourseRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DownloadScreen]
class DownloadRoute extends PageRouteInfo<void> {
  const DownloadRoute({List<PageRouteInfo>? children})
      : super(
          DownloadRoute.name,
          initialChildren: children,
        );

  static const String name = 'DownloadRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ForgetPasswordScreen]
class ForgetPasswordRoute extends PageRouteInfo<ForgetPasswordRouteArgs> {
  ForgetPasswordRoute({
    Key? key,
    required String title1,
    bool hasForgottenPassword = true,
    required String description,
    required String title2,
    List<PageRouteInfo>? children,
  }) : super(
          ForgetPasswordRoute.name,
          args: ForgetPasswordRouteArgs(
            key: key,
            title1: title1,
            hasForgottenPassword: hasForgottenPassword,
            description: description,
            title2: title2,
          ),
          initialChildren: children,
        );

  static const String name = 'ForgetPasswordRoute';

  static const PageInfo<ForgetPasswordRouteArgs> page =
      PageInfo<ForgetPasswordRouteArgs>(name);
}

class ForgetPasswordRouteArgs {
  const ForgetPasswordRouteArgs({
    this.key,
    required this.title1,
    this.hasForgottenPassword = true,
    required this.description,
    required this.title2,
  });

  final Key? key;

  final String title1;

  final bool hasForgottenPassword;

  final String description;

  final String title2;

  @override
  String toString() {
    return 'ForgetPasswordRouteArgs{key: $key, title1: $title1, hasForgottenPassword: $hasForgottenPassword, description: $description, title2: $title2}';
  }
}

/// generated route for
/// [HistoryScreen]
class HistoryRoute extends PageRouteInfo<void> {
  const HistoryRoute({List<PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NewPasswordScreen]
class NewPasswordRoute extends PageRouteInfo<void> {
  const NewPasswordRoute({List<PageRouteInfo>? children})
      : super(
          NewPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewPasswordRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [NotificationScreen]
class NotificationRoute extends PageRouteInfo<void> {
  const NotificationRoute({List<PageRouteInfo>? children})
      : super(
          NotificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NotificationRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OTPInputScreen]
class OTPInputRoute extends PageRouteInfo<OTPInputRouteArgs> {
  OTPInputRoute({
    Key? key,
    required String? number,
    bool hasForgottenPassword = true,
    List<PageRouteInfo>? children,
  }) : super(
          OTPInputRoute.name,
          args: OTPInputRouteArgs(
            key: key,
            number: number,
            hasForgottenPassword: hasForgottenPassword,
          ),
          initialChildren: children,
        );

  static const String name = 'OTPInputRoute';

  static const PageInfo<OTPInputRouteArgs> page =
      PageInfo<OTPInputRouteArgs>(name);
}

class OTPInputRouteArgs {
  const OTPInputRouteArgs({
    this.key,
    required this.number,
    this.hasForgottenPassword = true,
  });

  final Key? key;

  final String? number;

  final bool hasForgottenPassword;

  @override
  String toString() {
    return 'OTPInputRouteArgs{key: $key, number: $number, hasForgottenPassword: $hasForgottenPassword}';
  }
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PriceScreen]
class PriceRoute extends PageRouteInfo<void> {
  const PriceRoute({List<PageRouteInfo>? children})
      : super(
          PriceRoute.name,
          initialChildren: children,
        );

  static const String name = 'PriceRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfilScreen]
class ProfilRoute extends PageRouteInfo<void> {
  const ProfilRoute({List<PageRouteInfo>? children})
      : super(
          ProfilRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfilRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TopUpScreen]
class TopUpRoute extends PageRouteInfo<void> {
  const TopUpRoute({List<PageRouteInfo>? children})
      : super(
          TopUpRoute.name,
          initialChildren: children,
        );

  static const String name = 'TopUpRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
