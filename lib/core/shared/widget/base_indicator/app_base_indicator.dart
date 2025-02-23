import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';

class AppBaseIndicator {
  static Widget error400({
    required String message,
    required Widget button,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppImage.error400),
        Gap(30.h),
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
        SvgPicture.asset(AppImage.netwoekProblem),
        Gap(30.h),
        Center(
          child: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.r,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Gap(70.h),
      ],
    );
  }
}
