import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Color(0xFF000000);

  // Grey Scale
  static const Color grey100 = Color(0xFFE0E0E0);
  static const Color grey500 = Color.fromARGB(255, 128, 128, 128);
  static const Color grey800 = Color(0xFF4A4A4A);

  static const Color winePrimary = Color(0xFFC599B6);
  static const Color wineBackground = Color.fromARGB(237, 172, 137, 160);

  static const Color cocktailPrimary = Color(0xFFE6B2BA);
  static const Color cocktailBackground = Color.fromARGB(255, 206, 163, 169);

//-------------------------------------------------------------------------------
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFFFFB5A7);
  static const Color onSecondary = Color(0xFF6D6875);
  static const Color third = Color(0xFF8B1F41);

  static const Color error = Color(0xFFE53935);
  static const Color onError = Color(0xFFFFFFFF);

  static const Color onBackground = Color(0xFF2C1810);

  static const Color surface = Color(0xFFFDF7F9);
  static const Color surfaceVariant = Color(0xFFF4E5E8);
  static const Color onSurface = Color(0xFF2C1810);
  static const Color onSurfaceVariant = Color.fromRGBO(44, 24, 16, 0.15);

  static const Color inverseSurface = Color.fromRGBO(44, 24, 16, 0.74);
  static const Color inversePrimary = Color.fromRGBO(181, 74, 95, 0.9);
  static const Color onInverseSurface = Color(0xFFFDF7F9);

  static const Color shadow = Color(0xFF000000);
  static const Color outline = Color(0xFFE6D3D7);

  // extended colors
  static const Color contentPrimary = Color(0xFFFFFFFF);
  // static const Color contentPrimary = Color(0xFFFAD0C4);
  static const Color contentSecondary = Color(0xFF6D4C41);
  static const Color contentTertiary = Color(0xFF9E7B73);
  static const Color contentFourth = Color(0xFFBEA8A3);
  static const Color positive = Color(0xFF4CAF50);

  // Rating Colors
  static const List<Color> wineColors = [
    Color(0xFF56021F), // 바디감
    Color(0xFF7D1C4A), // 타닌
    Color(0xFFD17D98), // 산도
    Color(0xFFF4CCE9), // 당도
  ];
}
