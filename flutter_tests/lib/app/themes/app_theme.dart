import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_tests/app/themes/app_colors.dart';

ThemeData appTheme() {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      onPrimary: AppColors.white,
      onSecondary: AppColors.black,
    ),
    appBarTheme: const AppBarTheme().copyWith(
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        )),
    textTheme: GoogleFonts.mulishTextTheme().apply(
      bodyColor: AppColors.black,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 226, 226, 255),
  );
}
