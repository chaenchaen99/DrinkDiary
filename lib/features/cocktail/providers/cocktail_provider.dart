import 'package:flutter_drinkdiary/data/models/cocktail.dart';
import 'package:flutter_drinkdiary/data/repositories/cocktail_repository.dart';
import 'package:flutter_drinkdiary/features/cocktail/providers/cocktail_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cocktail_provider.g.dart';

@riverpod
class CocktailNotifier extends _$CocktailNotifier {
  @override
  CocktailState build() {
    _loadCocktails();
    return const CocktailState();
  }

  Future<void> _loadCocktails() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(cocktailRepositoryProvider);
      List<Cocktail> cocktails = [];

      // 필터 적용
      if (state.searchQuery != null) {
        cocktails = repository.searchCocktailsByName(state.searchQuery!);
      } else {
        cocktails = repository.getAllCocktails();
      }

      // 베이스 술 필터
      if (state.selectedBaseSpirit != null) {
        cocktails = cocktails
            .where((cocktail) =>
                cocktail.baseSpirit.toLowerCase() ==
                state.selectedBaseSpirit!.toLowerCase())
            .toList();
      }

      // 난이도 필터
      if (state.selectedDifficulty != null) {
        cocktails = cocktails
            .where(
                (cocktail) => cocktail.difficulty == state.selectedDifficulty)
            .toList();
      }

      // 평점 필터
      if (state.minRating != null) {
        cocktails = cocktails
            .where((cocktail) => cocktail.rating >= state.minRating!)
            .toList();
      }

      // 태그 필터
      if (state.selectedTags.isNotEmpty) {
        cocktails = cocktails
            .where((cocktail) =>
                cocktail.tags?.any((tag) => state.selectedTags.contains(tag)) ??
                false)
            .toList();
      }

      // 재료 필터
      if (state.selectedIngredients.isNotEmpty) {
        cocktails = cocktails
            .where((cocktail) => state.selectedIngredients.every((ingredient) =>
                cocktail.ingredients
                    .any((i) => i.toLowerCase() == ingredient.toLowerCase())))
            .toList();
      }

      // 최신순 정렬
      cocktails.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      state = state.copyWith(
        cocktails: cocktails,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 칵테일 추가
  Future<void> addCocktail(Cocktail cocktail) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(cocktailRepositoryProvider);
      await repository.addCocktail(cocktail);
      await _loadCocktails();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 칵테일 수정
  Future<void> updateCocktail(Cocktail cocktail) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(cocktailRepositoryProvider);
      await repository.updateCocktail(cocktail);
      await _loadCocktails();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 칵테일 삭제
  Future<void> deleteCocktail(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(cocktailRepositoryProvider);
      await repository.deleteCocktail(id);
      await _loadCocktails();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 필터 설정
  void setSearchQuery(String? query) {
    state = state.copyWith(searchQuery: query);
    _loadCocktails();
  }

  void setSelectedBaseSpirit(String? baseSpirit) {
    state = state.copyWith(selectedBaseSpirit: baseSpirit);
    _loadCocktails();
  }

  void setSelectedDifficulty(int? difficulty) {
    state = state.copyWith(selectedDifficulty: difficulty);
    _loadCocktails();
  }

  void setMinRating(double? rating) {
    state = state.copyWith(minRating: rating);
    _loadCocktails();
  }

  void setSelectedTags(List<String> tags) {
    state = state.copyWith(selectedTags: tags);
    _loadCocktails();
  }

  void setSelectedIngredients(List<String> ingredients) {
    state = state.copyWith(selectedIngredients: ingredients);
    _loadCocktails();
  }

  // 필터 초기화
  void resetFilters() {
    state = state.copyWith(
      searchQuery: null,
      selectedBaseSpirit: null,
      selectedDifficulty: null,
      minRating: null,
      selectedTags: [],
      selectedIngredients: [],
    );
    _loadCocktails();
  }
}
