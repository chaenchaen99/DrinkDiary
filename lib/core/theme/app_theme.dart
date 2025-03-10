import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => _createTheme(
        brightness: Brightness.light,
        primaryColor: AppColors.cocktailPrimary,
        secondaryColor: AppColors.cocktailSecondary,
        backgroundColor: AppColors.cocktailBackground,
        surfaceColor: AppColors.cocktailSurface,
        textColor: AppColors.textDark,
      );

  static ThemeData get darkTheme => _createTheme(
        brightness: Brightness.dark,
        primaryColor: AppColors.winePrimary,
        secondaryColor: AppColors.wineSecondary,
        backgroundColor: AppColors.wineBackground,
        surfaceColor: AppColors.wineSurface,
        textColor: AppColors.textLight,
      );

  static ThemeData _createTheme({
    required Brightness brightness,
    required Color primaryColor,
    required Color secondaryColor,
    required Color backgroundColor,
    required Color surfaceColor,
    required Color textColor,
  }) {
    return ThemeData(
      brightness: brightness,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        secondary: secondaryColor,
        surface: surfaceColor,
        error: AppColors.error,
        onPrimary: brightness == Brightness.light ? Colors.white : Colors.black,
        onSecondary:
            brightness == Brightness.light ? Colors.white : Colors.black,
        onSurface: textColor,
        onError: Colors.white,
      ),
      fontFamily: 'Pretendard',
      textTheme: TextTheme(
        displayLarge: TextStyle(color: textColor),
        displayMedium: TextStyle(color: textColor),
        displaySmall: TextStyle(color: textColor),
        headlineLarge: TextStyle(color: textColor),
        headlineMedium: TextStyle(color: textColor),
        headlineSmall: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor),
        titleMedium: TextStyle(color: textColor),
        titleSmall: TextStyle(color: textColor),
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        bodySmall: TextStyle(color: textColor),
        labelLarge: TextStyle(color: textColor),
        labelMedium: TextStyle(color: textColor),
        labelSmall: TextStyle(color: textColor),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: surfaceColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor:
              brightness == Brightness.light ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
