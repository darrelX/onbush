import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';

class BottomNivagatorBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onDestinationSelected;
  const BottomNivagatorBar({
    super.key,
    this.selectedIndex = 0,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                  color: AppColors.primary, fontWeight: FontWeight.bold);
            }
            return const TextStyle(
                color: AppColors.black); // Couleur pour les non-sélectionnés
          },
        ),
      ),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        indicatorColor: context.theme.scaffoldBackgroundColor,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 30,
              width: 30,
              colorFilter: const ColorFilter.mode(
                AppColors.sponsorButton,
                BlendMode.srcIn,
              ),
            ),
            selectedIcon: SvgPicture.asset(
              'assets/icons/home-active.svg',
              height: 30,
              width: 30,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/course_inactive.svg',
              height: 30,
              width: 30,
            ),
            selectedIcon: SvgPicture.asset(
              'assets/icons/course_inactive.svg',
              height: 30,
              width: 30,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Course',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/user.svg',
              height: 30,
              width: 30,
            ),
            selectedIcon: SvgPicture.asset(
              'assets/icons/user.svg',
              height: 30,
              width: 30,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profil',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/icons/ambassador.svg',
              height: 30,
              width: 30,
            ),
            selectedIcon: SvgPicture.asset(
              'assets/icons/ambassador_active.svg',
              height: 30,
              width: 30,
            ),
            label: 'Ambassador',
          ),
        ],
      ),
    );
  }
}
