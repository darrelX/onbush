import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/service_locator.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget(
      {super.key,
      required this.filiere,
      required this.onPressed,
      required this.level,
      required this.name,
      required this.sigle});

  final String filiere;
  final Function() onPressed;
  final String name;
  final int level;
  final String sigle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppButton(
          onPressed: onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.profileImageColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Image.asset(
              getIt.get<LocalStorage>().getString('avatar')!,
              height: 90.h,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Gap(8.w),
        SizedBox(
          height: 90.h,
          width: 239.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: context.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.r,
                      shadows: [
                        const Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 3.0,
                          color: Color(0xFF969DAC),
                        ),
                      ]),
                  overflow: TextOverflow.ellipsis),
              // const Spacer(
              //   flex: 2,
              // ),
              Text(
                "Niveau: $level",
                style: context.textTheme.bodyLarge!.copyWith(
                  fontSize: 14.r,
                  color: const Color(0xFF969DAC),
                ),
              ),
              SizedBox(
                width: 200.w,
                child: Text(
                  "Filiere: $filiere",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontSize: 14.r,
                    height: 1.3.h,
                    color: const Color(0xFF969DAC),
                  ),
                  maxLines: 2,
                ),
              ),
              Text(
                sigle,
                style: context.textTheme.bodyLarge!.copyWith(
                    fontSize: 14.r,
                    color: const Color(0xFF969DAC),
                    shadows: [
                      const Shadow(
                        offset: Offset(0.5, 0.5),
                        blurRadius: 2.0,
                        color: Color(0xFF969DAC),
                      ),
                    ],
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
