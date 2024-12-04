import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/notification/widgets/notification_widget.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/home/pages/home_screen.dart';
import 'package:onbush/shared/theme/app_colors.dart';

@RoutePage()
class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        actions: [
          Image.asset(
            "assets/icons/trailing-icon.png",
            color: AppColors.white,
          ),
          Gap(20.w),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),
              Text(
                "Notififications",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.sp),
              ),
              Gap(20.h),
              const NotificationWidget(
                content:
                    "  Lorem ipsum dolor sit amet consectetur. Pellentesque euismod habitasse tortor arcu neque a aliquam elit a. Sed in viverra pharetra convallis maecenas ut pretium. Commodo varius pellentesque gravida laoreet.",
                date: "2h",
                title: "Nouveau cours",
              ),
              Gap(20.h),
              const NotificationWidget(
                content:
                    "  Lorem ipsum dolor sit amet consectetur. Pellentesque euismod habitasse tortor arcu neque a aliquam elit a. Sed in viverra pharetra convallis maecenas ut pretium. Commodo varius pellentesque gravida laoreet.",
                date: "2h",
                title: "Nouveau cours",
              ),
              Gap(20.h),
              const NotificationWidget(
                content:
                    "  Lorem ipsum dolor sit amet consectetur. Pellentesque euismod habitasse tortor arcu neque a aliquam elit a. Sed in viverra pharetra convallis maecenas ut pretium. Commodo varius pellentesque gravida laoreet.",
                date: "2h",
                title: "Nouveau cours",
              ),
              Gap(20.h),
              const NotificationWidget(
                content:
                    "  Lorem ipsum dolor sit amet consectetur. Pellentesque euismod habitasse tortor arcu neque a aliquam elit a. Sed in viverra pharetra convallis maecenas ut pretium. Commodo varius pellentesque gravida laoreet.",
                date: "2h",
                title: "Nouveau cours",
              ),
              const NotificationWidget(
                content:
                    "  Lorem ipsum dolor sit amet consectetur. Pellentesque euismod habitasse tortor arcu neque a aliquam elit a. Sed in viverra pharetra convallis maecenas ut pretium. Commodo varius pellentesque gravida laoreet.",
                date: "2h",
                title: "Nouveau cours",
              ),
              Gap(20.h),
              const NotificationWidget(
                content:
                    "  Lorem ipsum dolor sit amet consectetur. Pellentesque euismod habitasse tortor arcu neque a aliquam elit a. Sed in viverra pharetra convallis maecenas ut pretium. Commodo varius pellentesque gravida laoreet.",
                date: "2h",
                title: "Nouveau cours",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
