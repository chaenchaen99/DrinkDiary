import 'package:flutter_drinkdiary/data/models/wine.dart';
import 'package:flutter_drinkdiary/data/repositories/wine_repository.dart';
import 'package:flutter_drinkdiary/features/wine/providers/wine_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wine_provider.g.dart';

@riverpod
class WineNotifier extends _$WineNotifier {
  @override
  WineState build() {
    _loadWines();
    return const WineState();
  }

  Future<void> _loadWines() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(wineRepositoryProvider);
      List<Wine> wines = [];

      // 필터 적용
      if (state.searchQuery != null) {
        wines = repository.searchWinesByName(state.searchQuery!);
      } else {
        wines = repository.getAllWines();
      }

      // 가격 필터
      if (state.minPrice != null || state.maxPrice != null) {
        wines = wines.where((wine) {
          final price = wine.price;
          if (state.minPrice != null && price < state.minPrice!) return false;
          if (state.maxPrice != null && price > state.maxPrice!) return false;
          return true;
        }).toList();
      }

      // 평점 필터
      if (state.minRating != null) {
        wines = wines.where((wine) => wine.rating >= state.minRating!).toList();
      }

      // 태그 필터
      if (state.selectedTags.isNotEmpty) {
        wines = wines
            .where((wine) =>
                wine.tags?.any((tag) => state.selectedTags.contains(tag)) ??
                false)
            .toList();
      }

      // 연도 필터
      if (state.selectedYear != null) {
        wines = wines
            .where((wine) => wine.productionYear == state.selectedYear)
            .toList();
      }

      // 생산지 필터
      if (state.selectedRegion != null) {
        wines = wines
            .where((wine) =>
                wine.region.toLowerCase() ==
                state.selectedRegion!.toLowerCase())
            .toList();
      }

      // 품종 필터
      if (state.selectedVariety != null) {
        wines = wines
            .where((wine) =>
                wine.variety.toLowerCase() ==
                state.selectedVariety!.toLowerCase())
            .toList();
      }

      // 최신순 정렬
      wines.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      state = state.copyWith(
        wines: wines,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 와인 추가
  Future<void> addWine(Wine wine) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(wineRepositoryProvider);
      await repository.addWine(wine);
      await _loadWines();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 와인 수정
  Future<void> updateWine(Wine wine) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(wineRepositoryProvider);
      await repository.updateWine(wine);
      await _loadWines();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  // 와인 삭제
  Future<void> deleteWine(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(wineRepositoryProvider);
      await repository.deleteWine(id);
      await _loadWines();
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
    _loadWines();
  }

  void setPriceRange(double? min, double? max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
    _loadWines();
  }

  void setMinRating(double? rating) {
    state = state.copyWith(minRating: rating);
    _loadWines();
  }

  void setSelectedTags(List<String> tags) {
    state = state.copyWith(selectedTags: tags);
    _loadWines();
  }

  void setSelectedYear(int? year) {
    state = state.copyWith(selectedYear: year);
    _loadWines();
  }

  void setSelectedRegion(String? region) {
    state = state.copyWith(selectedRegion: region);
    _loadWines();
  }

  void setSelectedVariety(String? variety) {
    state = state.copyWith(selectedVariety: variety);
    _loadWines();
  }

  // 필터 초기화
  void resetFilters() {
    state = state.copyWith(
      minPrice: null,
      maxPrice: null,
      minRating: null,
      selectedTags: [],
      searchQuery: null,
      selectedYear: null,
      selectedRegion: null,
      selectedVariety: null,
    );
    _loadWines();
  }
}
