import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/shared/widget/app_radio_list_tile.dart';

class SliderWidget extends StatefulWidget {
  final String title;
  final Widget description;
  final List<String> sliderOptions;
  final String? groupeValue;
  final void Function(String? value)? onChanged;

  const SliderWidget({
    super.key,
    required this.title,
    required this.description,
    required this.sliderOptions,
    required this.onChanged,
    required this.groupeValue,
  });

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState<T> extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 34.r,
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                shadows: const [
                  Shadow(
                    color: AppColors.primary,
                    blurRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ]),
            textAlign: TextAlign.center,
          ),
          Gap(30.h),
          widget.description,
          Gap(30.h),
          ...widget.sliderOptions.map((elt) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppRadioListTile(
                  groupeValue: widget.groupeValue,
                  onChanged: widget.onChanged,
                  value: widget.sliderOptions.indexOf(elt).toString(),
                  activeColor: AppColors.primary,
                  title: elt,
                ),
                Gap(10.h), // Add vertical spacing between radio buttons
              ],
            );
          }),
        ],
      ),
    );
  }
}
