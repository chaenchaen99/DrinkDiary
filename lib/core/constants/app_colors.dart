import 'package:flutter/material.dart';

class AppColors {
  // 라이트 테마 (칵테일)
  static const cocktailPrimary = Color(0xFFFF9F1C); // 밝은 오렌지
  static const cocktailSecondary = Color(0xFFFFBF69); // 연한 오렌지
  static const cocktailBackground = Color(0xFFFFF5EA); // 아주 연한 오렌지
  static const cocktailSurface = Colors.white;

  // 다크 테마 (와인)
  static const winePrimary = Color(0xFF722F37); // 와인 레드
  static const wineSecondary = Color(0xFF9E4244); // 연한 와인 레드
  static const wineBackground = Color(0xFF2C1810); // 다크 브라운
  static const wineSurface = Color(0xFF3D2B25); // 연한 다크 브라운

  // 공통 색상
  static const textDark = Color(0xFF2D2D2D);
  static const textLight = Color(0xFFF5F5F5);
  static const error = Color(0xFFB00020);
  static const success = Color(0xFF4CAF50);
  static const warning = Color(0xFFFFA000);

  // 평가 색상
  static const ratingColors = [
    Color(0xFFFFE082), // 1점
    Color(0xFFFFD54F), // 2점
    Color(0xFFFFCA28), // 3점
    Color(0xFFFFB300), // 4점
    Color(0xFFFFA000), // 5점
  ];
}
