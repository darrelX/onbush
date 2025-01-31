import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/core/theme/app_colors.dart';

class WithdrawalNoticeWidget extends StatelessWidget {
  const WithdrawalNoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.white, borderRadius: BorderRadius.circular(10.r)),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
           Text(
            "Vous devez Attendre une semaine avant de pouvoir faire votre premier retrait.",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.r),
          ),
          Gap(20.h),
          AppButton(
            bgColor: AppColors.primary,
            height: 40.h,
            text: "OK",
            onPressed: () => context.router.popForced(),
            width: context.width,
          ),
          // Gap(20.h),
        ],
      ),
    );
  }
}
