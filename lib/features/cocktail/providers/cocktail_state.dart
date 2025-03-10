import 'package:freezed_annotation/freezed_annotation.dart';

part 'cocktail_state.freezed.dart';

@freezed
class CocktailState with _$CocktailState {
  const factory CocktailState({
    @Default(null) String? searchQuery,
    @Default(null) String? selectedBaseSpirit,
    @Default(null) int? selectedDifficulty,
    @Default(null) double? minRating,
    @Default([]) List<String> selectedTags,
    @Default([]) List<String> selectedIngredients,
  }) = _CocktailState;
}
