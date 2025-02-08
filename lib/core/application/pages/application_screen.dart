import 'package:auto_route/auto_route.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onbush/core/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/onbush_app_bar.dart';

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
                automaticallyImplyLeading: false

                // actions: [
                //   SvgPicture.asset(
                //     'assets/icons/settings.svg',
                //   ),
                //   const Gap(10),
                // ],
                );
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
        return BottomNivagatorBar(
          selectedIndex: tabsRouter.activeIndex,
          onDestinationSelected: tabsRouter.setActiveIndex,
        );
      },
    );
  }
}

