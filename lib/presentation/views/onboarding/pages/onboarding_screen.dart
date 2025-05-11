import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/presentation/views/onboarding/widgets/carousel_widget.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.white,
        // appBar: AppBar(),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              _buildCarousel(),
              _buildTopRoundedContainer(),
              _buildPageIndicators(),
              _buildBottomButtons(),
            ],
          ),
        ));
  }

  Widget _buildCarousel() {
    return CarouselWidget(
      controller: _pageController,
      onPageChanged: (page) => setState(() => _currentIndex = page),
      json: const [
        {
          "image": AppImage.image1,
          "text1": "Révise \nefficacement",
          "text2":
              "Cours, sujets, corrigés...\ntout ce qu'il te faut pour réussir.",
        },
        {
          "image": AppImage.image2,
          "text1": "Apprends\nsans connexion",
          "text2": "Télécharge tes cours et étudie\nhors ligne où que tu sois",
        },
        {
          "image": AppImage.image3,
          "text1": "Partage et gagne",
          "text2": "Parraine des amis et accumule\ndes récompenses",
        },
      ],
    );
  }

  Widget _buildTopRoundedContainer() {
    return Positioned(
      top: 320.h,
      left: 0,
      right: 0,
      child: Container(
        height: 20.h,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildPageIndicators() {
    return Positioned(
      bottom: 130.h, // Ajuste la hauteur selon ton UI
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          final isActive = _currentIndex == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4.0),
            width: isActive ? 12.0 : 8.0,
            height: isActive ? 12.0 : 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? Colors.blue : Colors.grey,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Positioned(
      bottom: 35.h,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppButton(
            width: 120.w,
            bgColor: AppColors.ternary,
            text: _currentIndex == 0 ? "Passer" : "Précédent",
            textColor: AppColors.primary,
            onPressed: () {
              if (_currentIndex == 0) {
                context.router.popAndPushAll([const AuthRoute()]);
              } else {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                );
              }
            },
          ),
          AppButton(
            width: 120.w,
            bgColor: AppColors.secondary,
            text: _currentIndex != 2 ? "Suivant" : "Commencer",
            textColor: AppColors.white,
            onPressed: () {
              if (_currentIndex != 2) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                );
              } else {
                context.router.replaceAll([const AuthRoute()]);
              }
            },
          ),
        ],
      ),
    );
  }
}
