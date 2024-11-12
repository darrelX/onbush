import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/service_locator.dart';
import 'package:onbush/shared/extensions/context_extensions.dart';

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
    getIt.get<ApplicationCubit>().setUser();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/onbush.png',
          width: 100.w,
          color: Colors.white,
        ),
        BlocBuilder<ApplicationCubit, ApplicationState>(
          bloc: getIt.get<ApplicationCubit>(),
          builder: (context, state) {
            // if (state is ApplicationStateInitial) {
            //   return Text(
            //     double.parse(state.user!.balance!.toString())
            //         .toStringAsFixed(2),
            //   );
            // }
            return const SizedBox();
          },
        ),
        Spacer(),
        Image.asset("assets/icons/leading-icon.png"),
        Gap(10.w),
        Image.asset("assets/icons/trailing-icon.png"),
      ],
    );
  }
}
