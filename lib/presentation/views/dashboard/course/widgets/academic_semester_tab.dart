import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/shared/widget/carrousel/app_carousel_widget.dart';

class AcademySemesterTab extends StatelessWidget {
  final CarouselSliderController carouselController;
  final List<String> listSemester;
  final void Function(int index) onPressed;
  final Color selectedColor;
  final Color selectedText;
  final int selectedIndex; // Index du semestre sélectionné
  const AcademySemesterTab({
    super.key,
    required this.selectedIndex,
    required this.onPressed,
    required this.selectedColor,
    required this.carouselController,
    required this.listSemester,
    required this.selectedText,
  });

  @override
  Widget build(BuildContext context) {
    return AppCarouselWidget(
      carouselController: carouselController,
      height: 40.h,
      viewportFraction: 0.35,
      children: List.generate(
        listSemester.length,
        (index) {
          final isSelected = index == selectedIndex;
          return AppButton(
            onPressed: () => onPressed(index),
            radius: 10.r,
            width: 120.w,
            text: listSemester[index],

            textColor: isSelected ? selectedText : AppColors.textGrey,
            // textColor: Color(0xFF969DAC),
            activeBgColor: isSelected ? selectedColor : null,
            bgColor: isSelected ? selectedColor : AppColors.grey,
          );
        },
      ),
    );
  }
}
