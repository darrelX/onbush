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
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
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
    LanguageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguageScreen(),
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
          email: args.email,
          device: args.device,
          number: args.number,
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
      final args = routeData.argsAs<PriceRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PriceScreen(
          key: args.key,
          email: args.email,
        ),
      );
    },
    ProfilRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilScreen(),
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
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

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
/// [LanguageScreen]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
      : super(
          LanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageRoute';

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
    required String email,
    required String device,
    required String? number,
    List<PageRouteInfo>? children,
  }) : super(
          OTPInputRoute.name,
          args: OTPInputRouteArgs(
            key: key,
            email: email,
            device: device,
            number: number,
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
    required this.email,
    required this.device,
    required this.number,
  });

  final Key? key;

  final String email;

  final String device;

  final String? number;

  @override
  String toString() {
    return 'OTPInputRouteArgs{key: $key, email: $email, device: $device, number: $number}';
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
class PriceRoute extends PageRouteInfo<PriceRouteArgs> {
  PriceRoute({
    Key? key,
    required String email,
    List<PageRouteInfo>? children,
  }) : super(
          PriceRoute.name,
          args: PriceRouteArgs(
            key: key,
            email: email,
          ),
          initialChildren: children,
        );

  static const String name = 'PriceRoute';

  static const PageInfo<PriceRouteArgs> page = PageInfo<PriceRouteArgs>(name);
}

class PriceRouteArgs {
  const PriceRouteArgs({
    this.key,
    required this.email,
  });

  final Key? key;

  final String email;

  @override
  String toString() {
    return 'PriceRouteArgs{key: $key, email: $email}';
  }
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
