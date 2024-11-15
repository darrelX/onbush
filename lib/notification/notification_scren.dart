import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/home/pages/home_screen.dart';
import 'package:onbush/shared/theme/app_colors.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Gap(20.h),
          Text("Notififications"),
          Gap(20.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Nouveau cours"),
                    Spacer(),
                    Text("il y'a 2h"),
                    Gap(20.w),
                    Icon(Icons.do_not_disturb_off)
                  ],
                ),
                Container(
                    child: Text(
                  "Lorem ipsum dolor sit amet consectetur. Pellentesque euismod habitasse tortor arcu neque a aliquam elit a. Sed in viverra pharetra convallis maecenas ut pretium. Commodo varius pellentesque gravida laoreet .",
                  style: context.textTheme.bodyLarge!.copyWith(),
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
