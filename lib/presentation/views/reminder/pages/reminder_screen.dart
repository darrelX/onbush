import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/views/reminder/widgets/slider_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Store user selections
  final Map<String, dynamic> _reminder = {
    "objective": null,
    "time": null,
  };

  String? _selectedObjective;
  String? _selectedTime;
  String? _selectedHour;

  void _onNext() {
    if (_currentPage == 0 && _selectedObjective != null) {
      _reminder["objective"] = _selectedObjective;
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (_currentPage == 1 && _selectedTime != null) {
      _reminder["time"] = _selectedTime;
      print("Rappel complet : $_reminder");
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      // Tu peux naviguer ou faire autre chose ici
    } else if (_currentPage == 2) {
      context.router.push(const LoaderRoute());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Veuillez faire un choix avant de continuer")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: [SystemUiOverlay.bottom],
    // );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap(20.h),
            SvgPicture.asset(
              AppImage.onBush,
              height: 90.r,
              width: 90.r,
              fit: BoxFit.cover,
            ),
            Gap(60.h),
            SizedBox(
              height: 460.h,
              child: PageView(
                controller: _pageController,
                // physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children: [
                  // Première étape : objectif d'étude
                  SliderWidget(
                    title: "Fixez-vous un objectif d'étude",
                    description: Text.rich(
                      TextSpan(
                        text: "Avec un objectif d'étude tu as ",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: "2x plus ",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const TextSpan(
                            text:
                                "de chances de réussir tes examens et devoirs",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    sliderOptions: const [
                      "Je veux étudier 2x par jour",
                      "Je veux étudier 1x par jour",
                      "Je veux étudier 3x par semaine",
                      "Je veux étudier plus souvent",
                    ],
                    onChanged: (String? value) {
                      setState(() => _selectedObjective = value);
                    },
                    groupeValue: _selectedObjective,
                  ),

                  // Deuxième étape : durée d'étude
                  SliderWidget(
                    title: "Fixe un fréquence de rappelles",
                    description: Text(
                      "Nous savons que vous oublier souvent ses pourquoi nous nous rappellons de vous",
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    sliderOptions: const [
                      "Tous les jours",
                      "Quelques fois par semaine",
                      "Une fois par semaine",
                    ],
                    onChanged: (String? value) {
                      setState(() => _selectedTime = value);
                    },
                    groupeValue: _selectedTime,
                  ),

                  // Troisieme étape : durée d'étude
                  SliderWidget(
                    title: "Fixe un Horaire pour les rappelles",
                    description: Text(
                      "programmer le meulier moment pour être rappeler de réviser vos cours",
                      style: TextStyle(fontSize: 16.sp),
                      textAlign: TextAlign.center,
                    ),
                    sliderOptions: const [
                      "Rappelle moi en matinee",
                      "Rappelle moi dans l'apres midi",
                      "Rappelle moi en soiree"
                    ],
                    onChanged: (String? value) {
                      setState(() => _selectedTime = value);
                    },
                    groupeValue: _selectedTime,
                  ),
                ],
              ),
            ),
            Gap(25.h),
            SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const WormEffect(
                activeDotColor: Colors.blue,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),
            const Spacer(),
            _buildNavigationControls(),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationControls() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage == 1)
            AppButton(
              text: "Retour",
              textColor: AppColors.primary,
              bgColor: Colors.white,
              borderColor: AppColors.primary,
              width: (context.width - 50.w) / 2,
              onPressed: () {
                setState(() {
                  _currentPage--;
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
          AppButton(
            text: _currentPage == 2 ? "Terminer" : "Suivant",
            textColor: AppColors.white,
            width: _currentPage == 1
                ? (context.width - 50.w) / 2
                : context.width - 40.w,
            bgColor:
                _selectedObjective != null ? AppColors.primary : AppColors.grey,
            onPressed: _selectedTime != null ? _onNext : null,
          ),
        ],
      ),
    );
  }
}
