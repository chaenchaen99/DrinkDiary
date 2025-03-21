// cocktail_validator.dart
import 'package:collection/collection.dart';
import 'package:drink_diary/data/models/cocktail.dart';

class CocktailValidator {
  static bool isCocktailChanged(Cocktail oldCocktail, Cocktail newCocktail) {
    const listEquals = ListEquality();

    return oldCocktail.name != newCocktail.name ||
        oldCocktail.rating != newCocktail.rating ||
        oldCocktail.createdAt != newCocktail.createdAt ||
        !listEquals.equals(oldCocktail.images, newCocktail.images) ||
        oldCocktail.onelineReview != newCocktail.onelineReview ||
        oldCocktail.base != newCocktail.base ||
        oldCocktail.ingredients != newCocktail.ingredients ||
        oldCocktail.recipe != newCocktail.recipe ||
        !listEquals.equals(oldCocktail.tags, newCocktail.tags) ||
        oldCocktail.review != newCocktail.review;
  }
}
