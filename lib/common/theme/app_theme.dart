import 'package:eventie/common/theme/text_theme.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

// Light Theme
final ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.badge,
    surface: AppColors.background,
    onPrimary: AppColors.background,
    onSecondary: AppColors.background,
    onSurface: AppColors.textPrimary,
    brightness: Brightness.light,
  ),
  textTheme: appTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    titleTextStyle: appTextTheme.displaySmall,
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
  ),
);

// Dark Theme
final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.badge,
    surface: const Color(0xFF121212),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  ),
  textTheme: appTextTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF121212),
    elevation: 0,
    titleTextStyle: appTextTheme.displaySmall?.copyWith(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
);

// Accessing them as AppTheme.light / AppTheme.dark
class AppTheme {
  static ThemeData light = appLightTheme;
  static ThemeData dark = appDarkTheme;
}





