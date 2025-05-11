import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:onbush/core/constants/images/app_image.dart';

class AppBaseIndicator {
  static Widget error400(
      {required String message, required Widget button, double? size}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AppImage.error400,
          width: size,
          height: size,
        ),
        Gap(30.h),
        Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.r,
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
    double? size,
    required Widget button,
    double? spacing,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(AppImage.netwoekProblem, width: size, height: size),
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
        Gap(spacing ?? 50.h),
        button
      ],
    );
  }
}
