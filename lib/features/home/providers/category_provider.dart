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
}
