import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/colors/app_colors.dart';
import 'package:onbush/core/constants/images/app_image.dart';
import 'package:onbush/core/extensions/context_extensions.dart';
import 'package:onbush/core/routing/app_router.dart';

@RoutePage()
class LoaderScreen extends StatefulWidget {
  const LoaderScreen({super.key});

  @override
  State<LoaderScreen> createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  int _percent = 0;
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startLoading() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        if (_percent < 100) {
          _percent++;
        } else {
          _timer.cancel();
          context.router.push(const ApplicationRoute());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.quaternaire,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(60.h),
              SvgPicture.asset(
                AppImage.allOnBush,
                height: 70.r,
                width: 70.r,
                fit: BoxFit.cover,
              ),
              Gap(70.h),
              Text(
                "Patientez, nous créons votre espace de travail ça va prendre quelque instant ",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.black,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                textAlign: TextAlign.center,
              ),
              Gap(100.h),
              Opacity(
                opacity: 0.2,
                child: SvgPicture.asset(
                  AppImage.onBush,
                  height: 150.r,
                  width: 150.r,
                  fit: BoxFit.cover,
                ),
              ),
              Gap(100.h),
              Text(
                "$_percent %",
                style: context.textTheme.displayLarge!.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
