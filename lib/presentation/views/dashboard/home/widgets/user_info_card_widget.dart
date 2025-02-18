import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/application/cubit/application_cubit.dart';
import 'package:onbush/core/database/local_storage.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';
import 'package:onbush/service_locator.dart';

class UserInfoCardWidget extends StatelessWidget {
  const UserInfoCardWidget({
    super.key,
    required ApplicationCubit cubit,
  }) : _cubit = cubit;

  final ApplicationCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppButton(
          onPressed: () => context.router.push(const ProfilRoute()),
          child: Image.asset(
            getIt.get<LocalStorage>().getString('avatar')!,
            height: 43.h,
            fit: BoxFit.fitHeight,
          ),
        ),
        Gap(5.w),
        SizedBox(
          height: 49.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Salut",
                style: context.textTheme.titleSmall!.copyWith(),
              ),
              Text(
                _cubit.userEntity!.name!,
                style: context.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, shadows: [
                  const Shadow(
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ]),
              ),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          height: 49.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Niveau : ${_cubit.userEntity!.academyLevel}",
                style: context.textTheme.titleSmall!.copyWith(),
              ),
              Text(
                "Enspd",
                style: context.textTheme.titleMedium!
                    .copyWith(fontWeight: FontWeight.bold, shadows: [
                  const Shadow(
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.0,
                    color: Colors.grey,
                  ),
                ]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
