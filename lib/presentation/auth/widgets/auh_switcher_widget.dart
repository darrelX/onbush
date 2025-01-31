
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/theme/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';

class AuhSwitcherWidget extends StatefulWidget {
  final int currentIndex;
  final PageController pageController;


  const AuhSwitcherWidget({
    super.key,
    this.currentIndex = 0,
    required this.pageController,

  });

  @override
  State<AuhSwitcherWidget> createState() => _AuhSwitcherWidgetState();
}

class _AuhSwitcherWidgetState extends State<AuhSwitcherWidget> {
  bool result = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.w,
      height: 55.h,
      decoration: BoxDecoration(
          color: AppColors.ternary,
          borderRadius: BorderRadius.circular(25.r)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 200),
            alignment: widget.currentIndex == 0
                ? const Alignment(-1, 0)
                : const Alignment(1, 0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              // margin: EdgeInsets.symmetric(vertical: 50),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                color: AppColors.primary,
              ),
              width: 130.w,
              height: 45.h,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AppButton(
                width: 120.w,
                textColor: result ? AppColors.primary : AppColors.white,
                onPressed: () {
                  setState(() {
                    widget.pageController.previousPage(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear);
                  });
                },
                // bgColor: widget.currentIndex == 1 ? null : AppColors.primary,
                height: 40.h,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Text(
                    "Connexion",
                    style: context.textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: widget.currentIndex == 0
                            ? AppColors.white
                            : AppColors.primary),
                  ),
                ),
              ),
              AppButton(
                  width: 120.w,
                  textColor: widget.currentIndex == 0
                      ? AppColors.primary
                      : AppColors.white,
                  onPressed: () {
                    setState(() {
                      widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 20),
                          curve: Curves.linear);
                    });
                  },
                  // bgColor: AppColors.primary,
    
                  height: 40.h,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: Text(
                      "S'inscrire",
                      style: context.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: widget.currentIndex == 1
                              ? AppColors.white
                              : AppColors.primary),
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
