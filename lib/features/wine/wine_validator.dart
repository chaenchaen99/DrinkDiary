// wine_validator.dart
import 'package:collection/collection.dart';
import '../../data/models/wine.dart';

class WineValidator {
  static bool isWineChanged(Wine oldWine, Wine newWine) {
    const listEquals = ListEquality();

    return oldWine.name != newWine.name ||
        oldWine.rating != newWine.rating ||
        oldWine.createdAt != newWine.createdAt ||
        !listEquals.equals(oldWine.images, newWine.images) ||
        oldWine.onelineReview != newWine.onelineReview ||
        oldWine.productionYear != newWine.productionYear ||
        oldWine.region != newWine.region ||
        oldWine.variety != newWine.variety ||
        oldWine.winery != newWine.winery ||
        oldWine.price != newWine.price ||
        oldWine.shop != newWine.shop ||
        oldWine.alcoholContent != newWine.alcoholContent ||
        oldWine.sweetness != newWine.sweetness ||
        oldWine.body != newWine.body ||
        oldWine.tannin != newWine.tannin ||
        oldWine.acidity != newWine.acidity ||
        !listEquals.equals(oldWine.foodPairing, newWine.foodPairing) ||
        oldWine.review != newWine.review ||
        !listEquals.equals(oldWine.aroma, newWine.aroma);
  }
}
