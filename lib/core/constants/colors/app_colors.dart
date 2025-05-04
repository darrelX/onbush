import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color primary = Color(0xff1769ff);
  static const Color secondary = Color(0xff0A4EEB);
  static const Color ternary = Color(0xffb9ddff);
  static const Color quaternaire = Color(0xffEDF7FF);
  static const Color sponsorButton = Color(0xff11255A);

  static const Color black = Color(0xff212121);
  static const Color white = Color(0xffFAFBFB);
  static const Color surfaceWhite = Color(0xffFFFFFF);
  static const Color green = Color(0xff0AB161);
  static const Color red = Color(0xffD44638);
  static const Color grey = Color(0xFFECEEF0);
  static const Color icon = Color(0xFF9E9E9E);
  static const Color transparent = Colors.transparent;
  static const Color textGrey = Color(0xFF969DAC);

  static const ColorScheme colorScheme = ColorScheme(
    primary: primary,
    secondary: primary,
    surface: surfaceWhite,
    error: red,
    onPrimary: black,
    onSecondary: black,
    onSurface: black,
    onError: white,
    brightness: Brightness.light,
  );
}
