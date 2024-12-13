
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:onbush/core/theme/app_colors.dart';

class EditableAvatarWidget extends StatelessWidget {
  const EditableAvatarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(6.r),
          child: ClipOval(
            child: Image.asset(
              "assets/images/account_image.png",
              fit: BoxFit.fill,
              width: 150.r,
              height: 150.r,
            ),
          ),
        ),
        Positioned(
            bottom: 0,
            right: 10,
            child: Container(
                height: 42.r,
                width: 42.r,
                decoration: const BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.all(10.r),
                  child: SvgPicture.asset(
                    "assets/icons/pencil.svg",
                    color: AppColors.white,
                  ),
                )))
      ],
    );
  }
}
