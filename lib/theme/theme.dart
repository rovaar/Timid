import 'package:flutter/material.dart';
import 'global_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'Roboto',
      primaryColor: const Color(0xFF0DA8B1),
      scaffoldBackgroundColor: AppColors.primary,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        background: AppColors.background,
        error: AppColors.redHeart,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.white),
        bodySmall: TextStyle(color: AppColors.white),
        bodyMedium: TextStyle(color: AppColors.white),
        titleLarge:
            TextStyle(fontWeight: FontWeight.bold, color: AppColors.white),
      ),
      iconTheme: IconThemeData(color: AppColors.accent),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
