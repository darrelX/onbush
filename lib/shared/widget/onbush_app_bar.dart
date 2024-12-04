import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';
import 'package:onbush/shared/routing/app_router.dart';
import 'package:onbush/shared/widget/app_button.dart';

import '../application/cubit/application_cubit.dart';
import '../theme/app_colors.dart';

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
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: 100.w,
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
        const Spacer(),
        AppButton(
          child: Image.asset("assets/icons/leading-icon.png"),
          onPressed: () => context.router.push(const DownloadRoute()),
        ),
        Gap(10.w),
        AppButton(
          child: Image.asset(
            "assets/icons/trailing-icon.png",
          ),
          onPressed: () => context.router.push(const NotificationRoute()),
        ),
      ],
    );
  }
}
