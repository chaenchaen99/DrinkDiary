import 'package:flutter/services.dart';

import '../constants/app_colors.dart';

class CustomAppBarTheme {
  final SystemUiOverlayStyle systemUiOverlayStyle;
  final Color backgroundColor;
  final Color logoColor;
  final Color iconColor;
  final Color containerColor;
  final Color indicatorColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Color badgeBgColor;
  final Color badgeNumColor;

  static const int animationDuration = 400;

  static const double tabBarRadius = 30;

  static final CustomAppBarTheme wine = CustomAppBarTheme(
    systemUiOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: AppColors.winePrimary,
    logoColor: AppColors.third,
    iconColor: AppColors.onPrimary,
    containerColor: AppColors.wineBackground,
    indicatorColor: AppColors.onPrimary,
    labelColor: AppColors.winePrimary,
    unselectedLabelColor: AppColors.onPrimary,
    badgeBgColor: AppColors.black,
    badgeNumColor: AppColors.winePrimary,
  );

  static final CustomAppBarTheme cocktail = CustomAppBarTheme(
    systemUiOverlayStyle: SystemUiOverlayStyle.dark,
    backgroundColor: AppColors.cocktailPrimary,
    logoColor: AppColors.third,
    iconColor: AppColors.contentPrimary,
    containerColor: AppColors.cocktailBackground,
    indicatorColor: AppColors.onPrimary,
    labelColor: AppColors.cocktailPrimary,
    unselectedLabelColor: AppColors.onPrimary,
    badgeBgColor: AppColors.black,
    badgeNumColor: AppColors.black,
  );

  CustomAppBarTheme({
    required this.systemUiOverlayStyle,
    required this.backgroundColor,
    required this.logoColor,
    required this.iconColor,
    required this.containerColor,
    required this.indicatorColor,
    required this.labelColor,
    required this.unselectedLabelColor,
    required this.badgeBgColor,
    required this.badgeNumColor,
  });
}
