import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/routing/app_router.dart';
import 'package:onbush/core/shared/widget/buttons/app_button.dart';

class OnbushAppBar extends StatefulWidget {
  const OnbushAppBar({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<OnbushAppBar> createState() => _OnbushAppBarState();
}

class _OnbushAppBarState extends State<OnbushAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppButton(
          onPressed: () => context.router
              .pushAndPopUntil(const HomeRoute(), predicate: (route) => true),
          child: Image.asset(
            AppImage.logo,
            width: 100.w,
          ),
        ),
        // BlocBuilder<ApplicationCubit, ApplicationState>(
        //   bloc: getIt.get<ApplicationCubit>(),
        //   builder: (context, state) {
        //     if (state is ApplicationStateInitial) {
        //       return Text(
        //         double.parse(state.user!.balance!.toString())
        //             .toStringAsFixed(2),
        //       );
        //     }
        //     return const SizedBox();
        //   },
        // ),
        AppButton(
          child: Image.asset(AppImage.downloadIcon),
          onPressed: () => context.router.push(const DownloadRoute()),
        ),
        // Gap(10.w),
        // AppButton(
        //   child: const Icon(Icons.notifications_none_rounded),
        //   // Image.asset(
        //   //   AppImage.notificationWhite,
        //   // ),
        //   onPressed: () => context.router.push(const NotificationRoute()),
        // ),
      ],
    );
  }
}
