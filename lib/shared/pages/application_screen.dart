import 'package:auto_route/auto_route.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/onbush_app_bar.dart';


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
            );
          case 1:
            return AppBar(
              title: const OnbushAppBar(
                title: "onbush shop",
              ),
              toolbarHeight: 70.h,
            );
          case 2:
            return AppBar(
              title: const OnbushAppBar(
                title: "History",
              ),
              toolbarHeight: 70.h,
            );
          case 3:
            return AppBar(
              title: const Text("Profile"),
              toolbarHeight: 70.h,
              actions: [
                SvgPicture.asset(
                  'assets/icons/settings.svg',
                ),
                const Gap(10),
              ],
            );
          default:
            return AppBar();
        }
      },
      routes: const [
        HomeRoute(),
        ShopRoute(),
        HistoryRoute(),
        ProfileRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return FlashyTabBar(
          selectedIndex: tabsRouter.activeIndex,
          showElevation: true,
          onItemSelected: tabsRouter.setActiveIndex,
          backgroundColor: _.theme.scaffoldBackgroundColor,
          items: [
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
              ),
              title: SvgPicture.asset(
                'assets/icons/home.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
            FlashyTabBarItem(
              icon: Image.asset(
                'assets/icons/shop.png',
                height: 25,
                width: 25,
              ),
              title: Image.asset(
                'assets/icons/shop.png',
                height: 30,
                width: 30,
                color: AppColors.primary,
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                'assets/icons/history.svg',
              ),
              title: SvgPicture.asset(
                'assets/icons/history.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
            FlashyTabBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
              ),
              title: SvgPicture.asset(
                'assets/icons/profile.svg',
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
              ),
              activeColor: AppColors.primary,
              inactiveColor: AppColors.icon,
            ),
          ],
        );
      },
    );
  }
}
