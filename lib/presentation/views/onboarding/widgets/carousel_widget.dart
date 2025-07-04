import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';

class CarouselWidget extends StatefulWidget {
  final PageController controller;
  final List<dynamic> json;
  final Function(int page) onPageChanged;
  const CarouselWidget(
      {super.key,
      required this.controller,
      required this.json,
      required this.onPageChanged});

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 800.h,
      width: context.width,
      child: PageView(
        controller: widget.controller,
        onPageChanged: widget.onPageChanged,
        children: [
          ...widget.json.map((elt) {
            return Column(children: [
              Stack(
                children: [
                  SizedBox(
                    child: Image.asset(
                      elt["image"],
                      // height: 320.h,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              Text(
                elt["text1"],
                style: context.textTheme.displayMedium!
                    .copyWith(color: AppColors.secondary),
                textAlign: TextAlign.center,
              ),
              Gap(50.h),
              Text(
                elt["text2"],
                style: context.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ]);
          }),
        ],
      ),
    );
  }
}
