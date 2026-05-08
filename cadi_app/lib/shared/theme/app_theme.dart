import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppColors {
  static const background = Color(0xFFFFFFFF);
  static const primaryText = Color(0xFF55514F);
  static const secondaryText = Color(0xFF817A76);
  static const surface = Color(0xFFFAFAFA);
  static const divider = Color(0xFFEDE9E6);
  static const peach = Color(0xFFFF9F7B);
  static const peachLight = Color(0xFFFFC5AA);
  static const peachMist = Color(0xFFFFF1E8);
  static const glowPurple = Color(0xFFD4C5F9);
  static const glowBlue = Color(0xFFC5D9F9);
  static const glowPeach = Color(0xFFFFC5AA);
}

abstract final class AppTextStyles {
  static TextStyle heading1(BuildContext context) => GoogleFonts.lexend(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryText,
    height: 1.4,
  );

  static TextStyle heading2(BuildContext context) => GoogleFonts.lexend(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
    height: 1.5,
  );

  static TextStyle body(BuildContext context) => GoogleFonts.lexend(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
    height: 1.6,
  );

  static TextStyle caption(BuildContext context) => GoogleFonts.lexend(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryText,
    height: 1.4,
  );

  static TextStyle displayLarge(BuildContext context) => GoogleFonts.lexend(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
    height: 1.2,
  );
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.peach,
      surface: AppColors.background,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.lexendTextTheme().copyWith(
      bodyLarge: GoogleFonts.lexend(color: AppColors.primaryText),
      bodyMedium: GoogleFonts.lexend(color: AppColors.primaryText),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.primaryText,
      elevation: 0,
      centerTitle: true,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.background,
      selectedItemColor: AppColors.primaryText,
      unselectedItemColor: AppColors.secondaryText,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    ),
  );
}
