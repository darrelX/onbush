import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/theme/app_colors.dart';

class AppRadioListTile extends StatefulWidget {
  final String? groupeValue;
  final Widget? suffixIcon;
  final String value;
  final Color? selectedColor;
  final Color? activeColor;
  final void Function(String? value) onChanged;
  final Color? unSelectedColor;
  final String title;
  const AppRadioListTile(
      {super.key,
      required this.groupeValue,
      this.suffixIcon,
      this.selectedColor,
      this.unSelectedColor,
      required this.onChanged,
      required this.value,
      required this.activeColor,
      required this.title});

  @override
  State<AppRadioListTile> createState() => _AppRadioListTileState();
}

class _AppRadioListTileState extends State<AppRadioListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          border: widget.groupeValue != widget.value
              ? Border.all(
                  color: widget.unSelectedColor ?? Colors.black, width: 1.3.r)
              : Border.all(
                  color: widget.selectedColor ?? Colors.orange, width: 1.3.r)),
      child: RadioListTile<String>(
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
                color: widget.groupeValue != widget.value
                    ? widget.unSelectedColor ?? AppColors.black
                    : widget.selectedColor ?? Colors.orange,
              ),
            ),
            widget.suffixIcon ?? const SizedBox()
          ],
        ),
      ),
    );
  }
}
