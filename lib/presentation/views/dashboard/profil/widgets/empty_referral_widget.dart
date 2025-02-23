import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';

class EmptyReferralWidget extends StatelessWidget {
  const EmptyReferralWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImage.onBush,
          height: 120.r,
          width: 120.r,
        ),
        Gap(30.h),
        SizedBox(
          width: 300.w,
          child: Text(
            "Tu n'as pas encore de filleuls. Partage ton lien Parrain et commence à gagner des récompenses dès maintenant !",
            style: TextStyle(color: AppColors.textGrey, fontSize: 16.r),
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
