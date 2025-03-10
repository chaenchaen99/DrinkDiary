import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_drinkdiary/data/models/cocktail.dart';

part 'cocktail_state.freezed.dart';

@freezed
class CocktailState with _$CocktailState {
  const factory CocktailState({
    @Default([]) List<Cocktail> cocktails,
    @Default(true) bool isLoading,
    @Default(null) String? error,
    // 필터링 상태
    @Default(null) String? searchQuery,
    @Default(null) String? selectedBaseSpirit,
    @Default(null) int? selectedDifficulty,
    @Default(null) double? minRating,
    @Default([]) List<String> selectedTags,
    @Default([]) List<String> selectedIngredients,
  }) = _CocktailState;
}
