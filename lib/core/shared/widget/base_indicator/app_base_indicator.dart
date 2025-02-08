import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppBaseIndicator {
  static Widget error400({
    required String message,
    required Widget button,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/network_problem.svg"),
        Gap(50.h),
        Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.r,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(20.h),
        button,
        Gap(70.h),
      ],
    );
  }

  static Widget unavailableFileDisplay({
    required String message,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/images/error_400.svg"),
        Gap(50.h),
        Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.r,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(70.h),
      ],
    );
  }
}
