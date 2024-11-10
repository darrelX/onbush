import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/shared/theme/app_colors.dart';
import 'package:onbush/shared/widget/app_button.dart';

class AuhSwitcherWidget extends StatefulWidget {
  final int currentIndex;
  final PageController pageController;

  const AuhSwitcherWidget({
    super.key,
    this.currentIndex = 0, required this.pageController,
  });

  @override
  State<AuhSwitcherWidget> createState() => _AuhSwitcherWidgetState();
}

class _AuhSwitcherWidgetState extends State<AuhSwitcherWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      height: 55.h,
      decoration: BoxDecoration(
          color: AppColors.third, borderRadius: BorderRadius.circular(25.r)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton(
              width: 120.w,
              text: "Connexion",
              textColor:
                  widget.currentIndex == 1 ? AppColors.primary : AppColors.white,
              onPressed: () {
                setState(() {
                  widget.pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear);
                });
              },
              bgColor: widget.currentIndex == 1 ? null : AppColors.primary,
              height: 40.h,
            ),
            AppButton(
              width: 120.w,
              text: "S'inscrire",
              textColor:
                  widget.currentIndex == 0 ? AppColors.primary : AppColors.white,

              bgColor: widget.currentIndex == 0 ? null : AppColors.primary,

              onPressed: () {
                setState(() {
                  widget.pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.linear);
                });
              },
              // bgColor: AppColors.primary,

              height: 40.h,
            ),
          ],
        ),
      ),
    );
  }
}
