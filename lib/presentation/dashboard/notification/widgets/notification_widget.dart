import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/theme/app_colors.dart';

class NotificationWidget extends StatelessWidget {
  final String title;
  final String content;
  final String date;
  const NotificationWidget({
    super.key,
    required this.title,
    required this.content,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      color: AppColors.white,
      constraints: BoxConstraints(maxHeight: 165.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: context.textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade400, fontWeight: FontWeight.w900),
              ),
              const Spacer(),
              Text(
                "il y'a $date",
                style: context.textTheme.bodyLarge!.copyWith(
                    color: Colors.grey.shade400, fontWeight: FontWeight.w900),
              ),
              Gap(10.w),
              Icon(
                Icons.circle,
                color: AppColors.primary,
                size: 15.r,
              )
            ],
          ),
          Gap(10.h),
          Container(
              child: Text(
            content,
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
            style: context.textTheme.bodyLarge!
                .copyWith(fontWeight: FontWeight.w900),
          ))
        ],
      ),
    );
  }
}
