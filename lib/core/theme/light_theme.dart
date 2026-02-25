import 'package:boat_sells_app/utils/color/app_colors.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  fontFamily: 'Outfit',

  scaffoldBackgroundColor: AppColors.white,

  // ================= AppBar =================
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: AppColors.headingText),
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.headingText,
    ),
  ),

  // ================= Card =================
  cardTheme: CardThemeData(
    color: AppColors.cardBg,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.borderColor),
    ),
  ),

  // ================= Elevated Button =================
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryBlue,
      foregroundColor: AppColors.white,
      minimumSize: const Size(double.infinity, 48),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),

  // ================= Outlined Button =================
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.primaryBlue,
      minimumSize: const Size(double.infinity, 48),
      side: const BorderSide(color: AppColors.borderColor, width: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),

  // ================= Input Field =================
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.sectionBg,
    hintStyle: const TextStyle(
      fontSize: 14,
      color: AppColors.hintTextColor,
      fontWeight: FontWeight.w400,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.primaryBlue, width: 1.5),
    ),

    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.error),
    ),

    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: AppColors.error, width: 1.5),
    ),
  ),

  // ================= Divider =================
  dividerTheme: const DividerThemeData(
    color: AppColors.dividerColor,
    thickness: 1,
  ),

  // ================= Text =================
  // ================= Text Theme =================
  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w800,
      color: AppColors.headingText,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w800,
      color: AppColors.headingText,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: AppColors.headingText,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.headingText,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.headingText,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: AppColors.headingText,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.subHeadingText,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColors.subHeadingText,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: AppColors.hintTextColor,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.hintTextColor,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.subHeadingText,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: AppColors.hintTextColor,
    ),
  ),
);
