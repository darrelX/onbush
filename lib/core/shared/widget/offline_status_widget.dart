import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/theme/app_colors.dart';

class OfflineStatusWidget extends StatelessWidget {
  final double width;
  const OfflineStatusWidget({super.key, this.width = 300});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[400],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.close,
            color: Colors.white,
            size: 24,
          ),
          Gap(25.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Oops, Vous êtes hors ligne',
                    style: context.textTheme.bodyLarge!.copyWith(
                        color: AppColors.white, fontWeight: FontWeight.bold)),
                Gap(4.h),
                Text("Réessayez quand vous serez connecté.",
                    style: context.textTheme.bodySmall!
                        .copyWith(color: AppColors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
