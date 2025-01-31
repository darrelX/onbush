import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/service_locator.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget(
      {super.key,
      required this.filiere,
      required this.level,
      required this.name,
      required this.sigle});

  final String filiere;
  final String name;
  final int level;
  final String sigle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          getIt.get<LocalStorage>().getString('avatar')!,
          height: 105.h,
          fit: BoxFit.fitHeight,
        ),
        Gap(8.w),
        SizedBox(
          height: 109.h,
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
              const Spacer(),
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
