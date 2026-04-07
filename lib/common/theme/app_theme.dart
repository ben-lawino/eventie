import 'package:eventie/common/theme/text_theme.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Light Theme
final ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  scaffoldBackgroundColor: AppColors.background,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.badge,
    surface: AppColors.background,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.textPrimary,
    brightness: Brightness.light,
    primaryContainer: AppColors.softGray,
  ),
  textTheme: appTextTheme.apply(
    bodyColor: AppColors.textPrimary,
    displayColor: AppColors.textPrimary,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.background,
    elevation: 0,
    titleTextStyle: appTextTheme.displaySmall?.copyWith(
      color: AppColors.textPrimary,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: AppColors.textPrimary),
  ),
);


// Dark Theme
final ThemeData appDarkTheme = ThemeData(
  useMaterial3: true, // Recommended for better ColorScheme integration
  brightness: Brightness.dark,
  primaryColor: AppColors.primary,

  // Using a slightly lighter navy/gray for the background to allow
  // for darker shadows/elevation depth.
  scaffoldBackgroundColor: const Color(0xFF0F172A),

  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    brightness: Brightness.dark,
    primary: AppColors.primary,
    onPrimary: Colors.white,

    // Using a more muted purple for secondary to reduce eye strain
    secondary: AppColors.badge,
    onSecondary: Colors.white,

    // Surface colors for cards and sheets
    surface: const Color(0xFF1E293B),
    onSurface: Colors.white,

    // Containers provide a subtle distinction for input fields or tiles
    primaryContainer: AppColors.cardDark,
    onPrimaryContainer: Colors.white,

    // Error handling
    error: const Color(0xFFF87171),
    onError: Colors.white,

    outline: AppColors.textSecondary.withOpacity(0.5),
  ),

  textTheme: appTextTheme.apply(
    bodyColor: const Color(0xFFF3F4F6), // Slightly off-white for better readability
    displayColor: Colors.white,
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF0F172A),
    elevation: 0,
    centerTitle: false,
    titleTextStyle: appTextTheme.displaySmall?.copyWith(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),

  // Adding CardTheme to ensure consistent elevation across the app
  cardTheme: CardTheme(
    color: const Color(0xFF1E293B),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),

  // Input decoration for text fields
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.cardDark.withOpacity(0.5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: AppColors.border.withOpacity(0.1)),
    ),
  ),
);

/// Access via AppTheme.light / AppTheme.dark
class AppTheme {
  static ThemeData light = appLightTheme;
  static ThemeData dark = appDarkTheme;
}
