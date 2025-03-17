import 'package:drink_diary/core/theme/app_theme.dart';
import 'package:drink_diary/core/theme/custom_appbar_theme.dart';
import 'package:flutter/src/material/theme_data.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_provider.g.dart';

enum DrinkCategory {
  wine,
  cocktail,
}

@riverpod
class CategoryNotifier extends _$CategoryNotifier {
  @override
  DrinkCategory build() {
    return DrinkCategory.wine;
  }

  void toggleCategory() {
    state = state == DrinkCategory.wine
        ? DrinkCategory.cocktail
        : DrinkCategory.wine;
  }

  void changeIndex(int index) {
    state = DrinkCategory.values[index];
  }
}

extension MallTypeExtension on DrinkCategory {
  String get toName {
    switch (this) {
      case DrinkCategory.wine:
        return '와인';
      case DrinkCategory.cocktail:
        return '칵테일';
    }
  }

  bool get isWine => this == DrinkCategory.wine;
  bool get isCocktail => this == DrinkCategory.cocktail;

  CustomAppBarTheme get theme {
    switch (this) {
      case DrinkCategory.wine:
        return CustomAppBarTheme.wine;
      case DrinkCategory.cocktail:
        return CustomAppBarTheme.cocktail;
    }
  }
}
