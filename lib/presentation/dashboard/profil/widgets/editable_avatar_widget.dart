import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/theme/app_colors.dart';

class EditableAvatarWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final int? selectedIndex;
  final Widget? subIcon;
  final bool isSelectable;
  final Widget image;
  final double size;
  const EditableAvatarWidget(
      {super.key,
      required this.image,
      this.size = 160,
      this.selectedIndex,
      this.onPressed,
      this.subIcon,
      this.isSelectable = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            decoration: isSelectable
                ? BoxDecoration(
                    color: AppColors.primary.withOpacity(0.2),
                    border: Border.all(width: 1, color: AppColors.primary),
                    borderRadius: BorderRadius.circular(20.r))
                : null,
            margin: EdgeInsets.all(10.r),
            width: size + 10,
            height: size + 10,
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: size,
                    height: size,
                    margin: EdgeInsets.all(2.r),
                    padding: EdgeInsets.all(2.r),
                    child: ClipOval(child: image),
                  ),
                  subIcon != null
                      ? Positioned(bottom: 0, right: 10, child: subIcon!)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          isSelectable
              ? Positioned(
                  bottom: 0,
                  right: 2.r,
                  child: Container(
                    height: 30.r,
                    width: 30.r,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.secondary),
                    child: const Center(
                      child: Icon(
                        Icons.check,
                        color: AppColors.white,
                      ),
                    ),
                  ))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
