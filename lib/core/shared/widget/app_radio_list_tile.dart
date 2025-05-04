import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';

class AppRadioListTile<T> extends StatefulWidget {
  final T? groupeValue;
  final Widget? suffixIcon;
  final T value;
  final Color? selectedColor;
  final Color? activeColor;
  final void Function(T? value)? onChanged;
  final Color? unSelectedColor;
  final String title;

  const AppRadioListTile({
    super.key,
    required this.groupeValue,
    this.suffixIcon,
    this.selectedColor,
    this.unSelectedColor,
    required this.onChanged,
    required this.value,
    this.activeColor = Colors.blue,
    required this.title,
  });

  @override
  State<AppRadioListTile<T>> createState() => _AppRadioListTileState<T>();
}

class _AppRadioListTileState<T> extends State<AppRadioListTile<T>> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.groupeValue == widget.value;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isSelected
              ? widget.selectedColor ?? AppColors.primary
              : widget.unSelectedColor ?? Colors.black,
          width: 1.3.r,
        ),
      ),
      child: RadioListTile<T>(
        value: widget.value,
        groupValue: widget.groupeValue,
        onChanged: widget.onChanged,
        activeColor: widget.activeColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? widget.selectedColor ?? AppColors.primary
                    : widget.unSelectedColor ?? AppColors.black,
              ),
            ),
            widget.suffixIcon ?? const SizedBox(),
          ],
        ),
      ),
    );
  }
}
