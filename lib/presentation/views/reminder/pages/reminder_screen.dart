import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/app_dialog.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/presentation/blocs/reminder/reminder_cubit.dart';
import 'package:onbush/presentation/views/reminder/widgets/slider_widget.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/services/reminder/reminder_motification_service.dart';
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
  late final ReminderCubit _reminderCubit;
  final Map<String, int?> _reminder = {
    "objective": null,
    "time": null,
  };
  final ReminderNotificationService _notificationService =
      ReminderNotificationService();

  String? _selectedObjective;
  String? _selectedTime;

  @override
  void initState() {
    super.initState();
    _reminderCubit = getIt<ReminderCubit>();
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page!.round());
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onNext() async {
    if (_isObjectiveStepValid()) {
      _goToNextPage();
      return;
    }

    if (_isTimeStepValid()) {
      await _handleTimeStep();
      return;
    }

    _showValidationMessage();
  }

  bool _isObjectiveStepValid() =>
      _currentPage == 0 && _selectedObjective != null;

  bool _isTimeStepValid() => _currentPage == 1 && _selectedTime != null;

  Future<void> _handleTimeStep() async {
    final notificationService = ReminderNotificationService();

    if (await notificationService.isExactAlarmPermissionGranted()) {
      context.router.push(const LoaderRoute());
    } else {
      _showPermissionDialog();

      return;
    }

    await _addReminderWithHandling();

    // context.router.push(const LoaderRoute());
  }

  void _showPermissionDialog() {
    AppDialog.showDialog(
      context: context,
      height: 0.25.sh,
      width: 0.47.sw,
      child: _buildAuthorizationPopp(),
    );
  }

  Future<void> _addReminderWithHandling() async {
    try {
      await _reminderCubit.addReminder(_reminder);
    } catch (error) {
      _showErrorSnackBar("Erreur lors de l'ajout du rappel : $error");
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Widget _buildAuthorizationPopp() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Autoriser Onbush a vous envoyer des notifications",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        AppButton(
          text: "Aller dans les paramètres",
          textColor: AppColors.white,
          bgColor: AppColors.primary,
          onPressed: () {
            _notificationService.redirectToExactAlarmPermissionSettings();
          },
        ),
      ],
    );
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  ScrollPhysics? get _scrollPhysics {
    if (_selectedObjective == null && _currentPage == 0) {
      return const NeverScrollableScrollPhysics();
    } else if (_selectedTime == null && _currentPage == 1) {
      return const NeverScrollableScrollPhysics();
    }
    return const BouncingScrollPhysics();
  }

  void _showValidationMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Veuillez faire un choix avant de continuer"),
      ),
    );
  }

  void _reminderUpdate(String? value) {
    setState(() {
      if (_currentPage == 0) {
        _selectedObjective = value;
      } else if (_currentPage == 1) {
        _selectedTime = value;
      }
      _reminder["objective"] = int.parse(_selectedObjective ?? "0") ?? 0;
      _reminder["time"] = int.parse(_selectedTime ?? "0");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Gap(40.h),
            SvgPicture.asset(
              AppImage.allOnBush,
              height: 50.r,
              width: 50.r,
              fit: BoxFit.cover,
            ),
            Gap(40.h),
            _buildPageView(),
            Gap(25.h),
            SmoothPageIndicator(
              controller: _pageController,
              count: 2,
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

  Widget _buildPageView() {
    return SizedBox(
      height: 480.h,
      child: PageView(
        controller: _pageController,
        physics: _scrollPhysics,
        onPageChanged: (index) => setState(() => _currentPage = index),
        children: [
          _buildObjectiveStep(),
          _buildScheduleStep(),
        ],
      ),
    );
  }

  Widget _buildObjectiveStep() {
    return SliderWidget(
      title: "Fixez-vous un objectif d'étude",
      description: Text.rich(
        TextSpan(
          text: "Avec un objectif d'étude tu as ",
          style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
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
              text: "de chances de réussir tes examens et devoirs",
              style: TextStyle(fontWeight: FontWeight.bold),
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
      onChanged: (value) => setState(() => _reminderUpdate(value)),
      groupeValue: _selectedObjective,
    );
  }

  Widget _buildScheduleStep() {
    return SliderWidget(
      title: "Fixe un Horaire pour les rappels",
      description: Text(
        "Programmer le meilleur moment pour être rappelé de réviser vos cours",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      sliderOptions: const [
        "Rappelle moi en matinee",
        "Rappelle moi dans l'après-midi",
        "Rappelle moi en soirée"
      ],
      onChanged: (value) => setState(() => _reminderUpdate(value)),
      groupeValue: _selectedTime,
    );
  }

  Widget _buildNavigationControls() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: AppButton(
        text: _currentPage == 1 ? "Enregistrer les changements" : "Suivant",
        textColor: AppColors.white,
        width: context.width - 40.w,
        bgColor: ((_selectedObjective != null && _currentPage == 0) ||
                (_selectedTime != null && _currentPage == 1))
            ? AppColors.primary
            : AppColors.grey,
        onPressed: _selectedTime != null || _currentPage != 1 ? _onNext : null,
      ),
    );
  }
}
