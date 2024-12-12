import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

String fontFamily = 'Roboto';
String fontHeader = 'Roboto';

TextTheme buildTextTheme(
  TextTheme base,
) {
  return base
      .copyWith(
        displayLarge: GoogleFonts.baloo2(
          textStyle: base.displayLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        displayMedium: GoogleFonts.baloo2(
          textStyle: base.displayMedium!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        displaySmall: GoogleFonts.baloo2(
          textStyle: base.displaySmall!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        headlineMedium: GoogleFonts.baloo2(
          textStyle: base.headlineMedium!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        headlineSmall: GoogleFonts.baloo2(
          textStyle: base.headlineSmall!.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        titleLarge: GoogleFonts.baloo2(
          textStyle: base.titleLarge!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
        bodySmall: GoogleFonts.baloo2(
          textStyle: base.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
        ),
        titleMedium: GoogleFonts.baloo2(
          textStyle: base.titleMedium!.copyWith(),
        ),
        titleSmall: GoogleFonts.baloo2(
          textStyle: base.titleSmall!.copyWith(),
        ),
        bodyLarge: GoogleFonts.baloo2(
          textStyle: base.bodyLarge!.copyWith(),
        ),
        bodyMedium: GoogleFonts.baloo2(
          textStyle: base.bodyMedium!.copyWith(),
        ),
        labelLarge: GoogleFonts.baloo2(
          textStyle: base.labelLarge!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
        ),
      )
      .apply(
        displayColor: AppColors.black,
        bodyColor: AppColors.black,
      );
}
