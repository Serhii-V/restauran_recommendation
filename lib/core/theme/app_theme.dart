import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFFF7F7F5);
  static const Color card = Color(0xFFFFFFFF);
  static const Color primaryText = Color(0xFF1C1C1C);
  static const Color secondaryText = Color(0xFF6B6B6B);
  static const Color accent = Color(0xFF457B9D); // Muted green
  static const Color accentBrown = Color(0xFF8C6A5D); // Soft brown
  static const Color border = Color(0xFFE5E5E5);
  static const Color pickForFlowColor = Color(0xFF918EF4);
  static const Color eatHealthierFlowColor = Color(0xFF5CCB96);
  static const Color kidsModeFlowColor = Color(0xFFF4B942);
}

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        surface: AppColors.background,
        onSurface: AppColors.primaryText,
        primary: AppColors.accent,
        onPrimary: Colors.white,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          color: AppColors.primaryText,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        bodyLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 18,
          height: 1.5,
        ),
        bodyMedium: TextStyle(
          color: AppColors.secondaryText,
          fontSize: 16,
          height: 1.5,
        ),
        labelLarge: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      cardTheme: CardThemeData(
        color: AppColors.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: AppColors.primaryText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
