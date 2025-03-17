import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/models/cocktail.dart';
import '../../../data/repositories/cocktail_repository.dart';
import 'cocktail_state.dart';

part 'cocktail_provider.g.dart';

@riverpod
class CocktailNotifier extends _$CocktailNotifier {
  @override
  FutureOr<List<Cocktail>> build() async {
    return _loadCocktails();
  }

  Future<List<Cocktail>> _loadCocktails() async {
    try {
      final repository = ref.read(cocktailRepositoryProvider);
      final filter = ref.read(cocktailFilterProvider);
      List<Cocktail> cocktails = repository.getAllCocktails();

      // 필터 적용
      if (filter.searchQuery != null) {
        cocktails = cocktails
            .where((cocktail) => cocktail.name
                .toLowerCase()
                .contains(filter.searchQuery!.toLowerCase()))
            .toList();
      }

      if (filter.selectedBaseSpirit != null) {
        cocktails = cocktails
            .where((cocktail) =>
                cocktail.base?.toLowerCase() ==
                filter.selectedBaseSpirit!.toLowerCase())
            .toList();
      }

      if (filter.minRating != null) {
        cocktails = cocktails
            .where((cocktail) => cocktail.rating >= filter.minRating!)
            .toList();
      }

      if (filter.selectedTags.isNotEmpty) {
        cocktails = cocktails
            .where((cocktail) =>
                cocktail.tags
                    ?.any((tag) => filter.selectedTags.contains(tag)) ??
                false)
            .toList();
      }

      // if (filter.selectedIngredients.isNotEmpty) {
      //   cocktails = cocktails
      //       .where((cocktail) =>
      //           cocktail.ingredients?.any((ingredient) =>
      //               filter.selectedIngredients.contains(ingredient)) ??
      //           false)
      //       .toList();
      // }

      // 최신순 정렬
      cocktails.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return cocktails;
    } catch (e) {
      throw Exception('칵테일을 불러오는데 실패했습니다: $e');
    }
  }

  // 칵테일 추가
  Future<void> addCocktail(Cocktail cocktail) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(cocktailRepositoryProvider);
      await repository.addCocktail(cocktail);
      state = AsyncValue.data(await _loadCocktails());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // 칵테일 수정
  Future<void> updateCocktail(Cocktail cocktail) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(cocktailRepositoryProvider);
      await repository.updateCocktail(cocktail);
      state = AsyncValue.data(await _loadCocktails());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // 칵테일 삭제
  Future<void> deleteCocktail(String id) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(cocktailRepositoryProvider);
      await repository.deleteCocktail(id);
      state = AsyncValue.data(await _loadCocktails());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

@riverpod
class CocktailFilter extends AutoDisposeNotifier<CocktailState> {
  @override
  CocktailState build() {
    return const CocktailState();
  }

  void setSearchQuery(String? query) {
    state = CocktailState(
      searchQuery: query,
      selectedBaseSpirit: state.selectedBaseSpirit,
      selectedDifficulty: state.selectedDifficulty,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedIngredients: state.selectedIngredients,
    );
    ref.invalidate(cocktailNotifierProvider);
  }

  void setSelectedBaseSpirit(String? baseSpirit) {
    state = CocktailState(
      searchQuery: state.searchQuery,
      selectedBaseSpirit: baseSpirit,
      selectedDifficulty: state.selectedDifficulty,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedIngredients: state.selectedIngredients,
    );
    ref.invalidate(cocktailNotifierProvider);
  }

  void setSelectedDifficulty(int? difficulty) {
    state = CocktailState(
      searchQuery: state.searchQuery,
      selectedBaseSpirit: state.selectedBaseSpirit,
      selectedDifficulty: difficulty,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedIngredients: state.selectedIngredients,
    );
    ref.invalidate(cocktailNotifierProvider);
  }

  void setMinRating(double? rating) {
    state = CocktailState(
      searchQuery: state.searchQuery,
      selectedBaseSpirit: state.selectedBaseSpirit,
      selectedDifficulty: state.selectedDifficulty,
      minRating: rating,
      selectedTags: state.selectedTags,
      selectedIngredients: state.selectedIngredients,
    );
    ref.invalidate(cocktailNotifierProvider);
  }

  void setSelectedTags(List<String> tags) {
    state = CocktailState(
      searchQuery: state.searchQuery,
      selectedBaseSpirit: state.selectedBaseSpirit,
      selectedDifficulty: state.selectedDifficulty,
      minRating: state.minRating,
      selectedTags: tags,
      selectedIngredients: state.selectedIngredients,
    );
    ref.invalidate(cocktailNotifierProvider);
  }

  void setSelectedIngredients(List<String> ingredients) {
    state = CocktailState(
      searchQuery: state.searchQuery,
      selectedBaseSpirit: state.selectedBaseSpirit,
      selectedDifficulty: state.selectedDifficulty,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedIngredients: ingredients,
    );
    ref.invalidate(cocktailNotifierProvider);
  }

  void resetFilters() {
    state = const CocktailState();
    ref.invalidate(cocktailNotifierProvider);
  }
}
