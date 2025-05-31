import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/onbush_app_bar.dart';
import 'package:onbush/presentation/blocs/pdf/pdf_manager/pdf_manager_cubit.dart';
import 'package:onbush/presentation/views/dashboard/home/pages/home_screen.dart';
import 'package:onbush/service_locator.dart';

@RoutePage()
class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        switch (tabsRouter.activeIndex) {
          case 0:
            return AppBar(
                title: const OnbushAppBar(
                  title: "Home",
                ),
                toolbarHeight: 70.h,
                automaticallyImplyLeading: false);
          case 1:
            return AppBar(
                title: const OnbushAppBar(
                  title: "onbush shop",
                ),
                toolbarHeight: 70.h,
                automaticallyImplyLeading: false);
          case 2:
            return AppBar(
                title: const OnbushAppBar(
                  title: "History",
                ),
                toolbarHeight: 70.h,
                automaticallyImplyLeading: false);
          case 3:
            return AppBar(
                title: const OnbushAppBar(
                  title: "Profil",
                ),
                toolbarHeight: 70.h,
                automaticallyImplyLeading: false);
          default:
            return AppBar();
        }
      },
      routes: const [
        HomeRoute(),
        SubjectRoute(),
        ProfilRoute(),
        AmbassadorSpaceRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        if (tabsRouter.activeIndex == 0) {
          getIt<PdfManagerCubit>().loadAll(maxResults: 3);
        }
        return BottomNivagatorBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}
