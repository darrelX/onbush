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
      final args = routeData.argsAs<CourseRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CourseScreen(
          key: args.key,
          subjectEntity: args.subjectEntity,
          category: args.category,
        ),
      );
    },
    CourseSelectionMenuRoute.name: (routeData) {
      final args = routeData.argsAs<CourseSelectionMenuRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: CourseSelectionMenuScreen(
          key: args.key,
          subjectEntity: args.subjectEntity,
        ),
      );
    },
    DownloadPdfViewRoute.name: (routeData) {
      final args = routeData.argsAs<DownloadPdfViewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: DownloadPdfViewScreen(
          key: args.key,
          pdfFileEntity: args.pdfFileEntity,
        ),
      );
    },
    DownloadRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DownloadScreen(),
      );
    },
    EditAvatarRoute.name: (routeData) {
      final args = routeData.argsAs<EditAvatarRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditAvatarScreen(
          key: args.key,
          avatarList: args.avatarList,
        ),
      );
    },
    EditProfilRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfilScreen(),
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
          type: args.type,
          email: args.email,
        ),
      );
    },
    OnboardingRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OnboardingScreen(),
      );
    },
    PdfViewRoute.name: (routeData) {
      final args = routeData.argsAs<PdfViewRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PdfViewScreen(
          key: args.key,
          courseEntity: args.courseEntity,
          category: args.category,
        ),
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
    SubjectRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SubjectScreen(),
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
class CourseRoute extends PageRouteInfo<CourseRouteArgs> {
  CourseRoute({
    Key? key,
    required SubjectEntity subjectEntity,
    required String category,
    List<PageRouteInfo>? children,
  }) : super(
          CourseRoute.name,
          args: CourseRouteArgs(
            key: key,
            subjectEntity: subjectEntity,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'CourseRoute';

  static const PageInfo<CourseRouteArgs> page = PageInfo<CourseRouteArgs>(name);
}

class CourseRouteArgs {
  const CourseRouteArgs({
    this.key,
    required this.subjectEntity,
    required this.category,
  });

  final Key? key;

  final SubjectEntity subjectEntity;

  final String category;

  @override
  String toString() {
    return 'CourseRouteArgs{key: $key, subjectEntity: $subjectEntity, category: $category}';
  }
}

/// generated route for
/// [CourseSelectionMenuScreen]
class CourseSelectionMenuRoute
    extends PageRouteInfo<CourseSelectionMenuRouteArgs> {
  CourseSelectionMenuRoute({
    Key? key,
    required SubjectEntity subjectEntity,
    List<PageRouteInfo>? children,
  }) : super(
          CourseSelectionMenuRoute.name,
          args: CourseSelectionMenuRouteArgs(
            key: key,
            subjectEntity: subjectEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'CourseSelectionMenuRoute';

  static const PageInfo<CourseSelectionMenuRouteArgs> page =
      PageInfo<CourseSelectionMenuRouteArgs>(name);
}

class CourseSelectionMenuRouteArgs {
  const CourseSelectionMenuRouteArgs({
    this.key,
    required this.subjectEntity,
  });

  final Key? key;

  final SubjectEntity subjectEntity;

  @override
  String toString() {
    return 'CourseSelectionMenuRouteArgs{key: $key, subjectEntity: $subjectEntity}';
  }
}

/// generated route for
/// [DownloadPdfViewScreen]
class DownloadPdfViewRoute extends PageRouteInfo<DownloadPdfViewRouteArgs> {
  DownloadPdfViewRoute({
    Key? key,
    required PdfFileEntity pdfFileEntity,
    List<PageRouteInfo>? children,
  }) : super(
          DownloadPdfViewRoute.name,
          args: DownloadPdfViewRouteArgs(
            key: key,
            pdfFileEntity: pdfFileEntity,
          ),
          initialChildren: children,
        );

  static const String name = 'DownloadPdfViewRoute';

  static const PageInfo<DownloadPdfViewRouteArgs> page =
      PageInfo<DownloadPdfViewRouteArgs>(name);
}

class DownloadPdfViewRouteArgs {
  const DownloadPdfViewRouteArgs({
    this.key,
    required this.pdfFileEntity,
  });

  final Key? key;

  final PdfFileEntity pdfFileEntity;

  @override
  String toString() {
    return 'DownloadPdfViewRouteArgs{key: $key, pdfFileEntity: $pdfFileEntity}';
  }
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
/// [EditAvatarScreen]
class EditAvatarRoute extends PageRouteInfo<EditAvatarRouteArgs> {
  EditAvatarRoute({
    Key? key,
    required List<String> avatarList,
    List<PageRouteInfo>? children,
  }) : super(
          EditAvatarRoute.name,
          args: EditAvatarRouteArgs(
            key: key,
            avatarList: avatarList,
          ),
          initialChildren: children,
        );

  static const String name = 'EditAvatarRoute';

  static const PageInfo<EditAvatarRouteArgs> page =
      PageInfo<EditAvatarRouteArgs>(name);
}

class EditAvatarRouteArgs {
  const EditAvatarRouteArgs({
    this.key,
    required this.avatarList,
  });

  final Key? key;

  final List<String> avatarList;

  @override
  String toString() {
    return 'EditAvatarRouteArgs{key: $key, avatarList: $avatarList}';
  }
}

/// generated route for
/// [EditProfilScreen]
class EditProfilRoute extends PageRouteInfo<void> {
  const EditProfilRoute({List<PageRouteInfo>? children})
      : super(
          EditProfilRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfilRoute';

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
    String type = 'register',
    required String email,
    List<PageRouteInfo>? children,
  }) : super(
          OTPInputRoute.name,
          args: OTPInputRouteArgs(
            key: key,
            type: type,
            email: email,
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
    this.type = 'register',
    required this.email,
  });

  final Key? key;

  final String type;

  final String email;

  @override
  String toString() {
    return 'OTPInputRouteArgs{key: $key, type: $type, email: $email}';
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
/// [PdfViewScreen]
class PdfViewRoute extends PageRouteInfo<PdfViewRouteArgs> {
  PdfViewRoute({
    Key? key,
    required CourseEntity courseEntity,
    required String category,
    List<PageRouteInfo>? children,
  }) : super(
          PdfViewRoute.name,
          args: PdfViewRouteArgs(
            key: key,
            courseEntity: courseEntity,
            category: category,
          ),
          initialChildren: children,
        );

  static const String name = 'PdfViewRoute';

  static const PageInfo<PdfViewRouteArgs> page =
      PageInfo<PdfViewRouteArgs>(name);
}

class PdfViewRouteArgs {
  const PdfViewRouteArgs({
    this.key,
    required this.courseEntity,
    required this.category,
  });

  final Key? key;

  final CourseEntity courseEntity;

  final String category;

  @override
  String toString() {
    return 'PdfViewRouteArgs{key: $key, courseEntity: $courseEntity, category: $category}';
  }
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

/// generated route for
/// [SubjectScreen]
class SubjectRoute extends PageRouteInfo<void> {
  const SubjectRoute({List<PageRouteInfo>? children})
      : super(
          SubjectRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubjectRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
