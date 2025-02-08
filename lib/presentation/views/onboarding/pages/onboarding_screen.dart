import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
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
            CarouselWidget(
                controller: _pageController,
                onPageChanged: (page) => setState(() {
                      _currentIndex = page;
                    }),
                json: const [
                  {
                    "image": "assets/images/1.jpeg",
                    "text1": "Révise \nefficacement",
                    "text2":
                        "Cours, sujets, corrigés...\ntout ce qu'il te faut pour réussir.",
                  },
                  {
                    "image": "assets/images/2.png",
                    "text1": "apprendre\nsans connexion",
                    "text2":
                        "Telecharge tes cours et etudie\nhors ligne ou que tu sois",
                  },
                  {
                    "image": "assets/images/3.jpeg",
                    "text1": "Partage et gagne",
                    "text2": "Parraine des amis et accumule\ndes recompenses",
                  },
                ]),
            Column(
              children: [
                Gap(640.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 10.0),
                      width: _currentIndex == index ? 12.0 : 8.0,
                      height: _currentIndex == index ? 12.0 : 8.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            _currentIndex == index ? Colors.blue : Colors.grey,
                      ),
                    );
                  }),
                ),
              ],
            ),
            Positioned(
              bottom: 35.h,
              left: 0,
              right: 0,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppButton(
                      width: 120.w,
                      bgColor: AppColors.ternary,
                      text: _currentIndex == 0 ? "Passer" : "Precedent",
                      textColor: AppColors.primary,
                      onPressed: () {
                        setState(() {
                          _currentIndex == 0
                              ? context.router
                                  .popAndPushAll([const AuthRoute()])
                              : _pageController.previousPage(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.linear);
                        });
                      },
                    ),
                    AppButton(
                      width: 120.w,
                      bgColor: AppColors.secondary,
                      text: _currentIndex != 2 ? "Suivant" : "Commencer",
                      textColor: AppColors.white,
                      onPressed: () {
                        _currentIndex != 2
                            ? _pageController.nextPage(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear)
                            : context.router.replaceAll([const AuthRoute()]);
                        // : context.router.replaceAll([const ProfilRoute()]);
                      },
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
