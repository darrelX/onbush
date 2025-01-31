import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/theme/app_colors.dart';

class SponsoredChildWidget extends StatelessWidget {
  final String name;
  final String date;
  const SponsoredChildWidget({
    super.key,
    required this.name,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
          offset: Offset(1, 5),
          blurRadius: 5,
          color: Colors.grey,
        ),
        // BoxShadow(
        //   offset: Offset(-10, -10),
        //   blurRadius: 20,
        //   color: Colors.grey,
        // )
      ], color: AppColors.white, borderRadius: BorderRadius.circular(9.r)),
      child: Row(
        children: [
          Gap(10.w),
          Image.asset(
            "assets/images/account_image.png",
            height: 60.h,
          ),
          Gap(15.w),
          Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: context.textTheme.bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text("Il y a $date")
            ],
          )
        ],
      ),
    );
  }
}
