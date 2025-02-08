import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';

class ReferralOverviewCardWidget extends StatelessWidget {
  final double amount;
  final int numberOfMentees;
  const ReferralOverviewCardWidget({
    required this.amount,
    required this.numberOfMentees,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: 280.w,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(width: 0.3.w, color: AppColors.ternary),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/icons/Icon.svg"),
                Gap(10.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$amount",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontSize: 20.r,
                          shadows: [
                            const Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1.0,
                              color: Colors.grey,
                            ),
                          ],
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Francs CFA",
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontSize: 9.r,
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset("assets/icons/person_icon.svg"),
              Gap(10.w),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$numberOfMentees",
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 20.r,
                        color: AppColors.primary,
                        shadows: [
                          const Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 1.0,
                            color: Colors.grey,
                          ),
                        ],
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Filleul(s)",
                    style: context.textTheme.bodyLarge!.copyWith(
                        fontSize: 9.r,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
