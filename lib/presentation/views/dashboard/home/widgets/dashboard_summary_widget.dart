import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';

class DashboardSummaryWidget extends StatelessWidget {
  final int numberOfCourses;
  final int numberOfTD;
  final int processedTopics;
  final void Function() onPressed;
  const DashboardSummaryWidget({
    required this.numberOfCourses,
    required this.numberOfTD,
    required this.processedTopics,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
            border: Border.all(width: 0.5.r, color: AppColors.ternary),
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              // width: 60.w,
              height: 59.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.blueCourseIcon,
                    width: 27.w,
                    fit: BoxFit.fitWidth,
                  ),
                  // const Spacer(),
                  Gap(20.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$numberOfCourses",
                        style: context.textTheme.headlineMedium!.copyWith(
                            fontSize: 24.r,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                      // Gap(5.h),
                      Text(
                        "Cours",
                        style: context.textTheme.bodySmall!.copyWith(
                            fontSize: 10.r,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              // width: 105.w,
              height: 50.h,
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   "assets/icons/pencil.png",
                  //   height: 36.h,
                  //   fit: BoxFit.fitHeight,
                  // ),
                  Icon(
                    Icons.edit,
                    size: 36.r,
                    color: AppColors.primary,
                  ),
                  // const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$processedTopics",
                        style: context.textTheme.headlineMedium!.copyWith(
                            fontSize: 24.r,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                      // Gap(5.h),
                      Text(
                        "Sujets traites",
                        style: context.textTheme.bodySmall!.copyWith(
                            fontSize: 10.r,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              // width: 95.w,
              height: 59.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.blueCourseIcon,
                    width: 27.w,
                    fit: BoxFit.fitWidth,
                  ),
                  Gap(10.w),
                  // const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$numberOfTD",
                        style: context.textTheme.headlineMedium!.copyWith(
                            fontSize: 24.r,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                      // Gap(5.h),
                      Text(
                        "Fiches de TD",
                        style: context.textTheme.bodySmall!.copyWith(
                            fontSize: 10.r,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
