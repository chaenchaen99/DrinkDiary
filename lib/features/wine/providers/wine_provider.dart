import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/wine.dart';
import '../../../data/repositories/wine_repository.dart';
import 'wine_state.dart';

part 'wine_provider.g.dart';

@riverpod
class WineNotifier extends _$WineNotifier {
  @override
  FutureOr<List<Wine>> build() async {
    return _loadWines();
  }

  Future<List<Wine>> _loadWines() async {
    try {
      final repository = ref.read(wineRepositoryProvider);
      final filter = ref.read(wineFilterProvider);
      List<Wine> wines = repository.getAllWines();

      // 필터 적용
      // if (filter.searchQuery != null) {
      //   wines = wines
      //       .where((wine) => wine.name
      //           .toLowerCase()
      //           .contains(filter.searchQuery!.toLowerCase()))
      //       .toList();
      // }

      // if (filter.minRating != null) {
      //   wines =
      //       wines.where((wine) => wine.rating >= filter.minRating!).toList();
      // }

      // if (filter.selectedTags.isNotEmpty) {
      //   wines = wines
      //       .where((wine) =>
      //           wine.tags?.any((tag) => filter.selectedTags.contains(tag)) ??
      //           false)
      //       .toList();
      // }

      // if (filter.selectedYear != null) {
      //   wines = wines
      //       .where((wine) => wine.productionYear == filter.selectedYear)
      //       .toList();
      // }

      // if (filter.selectedRegion != null) {
      //   wines = wines
      //       .where((wine) =>
      //           wine.region.toLowerCase() ==
      //           filter.selectedRegion!.toLowerCase())
      //       .toList();
      // }

      // if (filter.selectedVariety != null) {
      //   wines = wines
      //       .where((wine) =>
      //           wine.variety.toLowerCase() ==
      //           filter.selectedVariety!.toLowerCase())
      //       .toList();
      // }

      // 최신순 정렬
      wines.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      return wines;
    } catch (e) {
      throw Exception('와인을 불러오는데 실패했습니다: $e');
    }
  }

  // 와인 추가
  Future<void> addWine(Wine wine) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wineRepositoryProvider);
      await repository.addWine(wine);
      state = AsyncValue.data(await _loadWines());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // 와인 수정
  Future<void> updateWine(Wine wine) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wineRepositoryProvider);
      await repository.updateWine(wine);
      state = AsyncValue.data(await _loadWines());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // 와인 삭제
  Future<void> deleteWine(String id) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wineRepositoryProvider);
      await repository.deleteWine(id);
      state = AsyncValue.data(await _loadWines());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  // 와인 전부 삭제 : 디버그용
  Future<void> deleteAllWine() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wineRepositoryProvider);
      await repository.deleteAllWine();
      state = AsyncValue.data(await _loadWines());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

@riverpod
class WineFilter extends AutoDisposeNotifier<WineState> {
  @override
  WineState build() {
    return const WineState();
  }

  void setSearchQuery(String? query) {
    state = WineState(
      searchQuery: query,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedYear: state.selectedYear,
      selectedRegion: state.selectedRegion,
      selectedVariety: state.selectedVariety,
    );
    ref.invalidate(wineNotifierProvider);
  }

  void setPriceRange(double? min, double? max) {
    state = WineState(
      searchQuery: state.searchQuery,
      minPrice: min,
      maxPrice: max,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedYear: state.selectedYear,
      selectedRegion: state.selectedRegion,
      selectedVariety: state.selectedVariety,
    );
    ref.invalidate(wineNotifierProvider);
  }

  void setMinRating(double? rating) {
    state = WineState(
      searchQuery: state.searchQuery,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      minRating: rating,
      selectedTags: state.selectedTags,
      selectedYear: state.selectedYear,
      selectedRegion: state.selectedRegion,
      selectedVariety: state.selectedVariety,
    );
    ref.invalidate(wineNotifierProvider);
  }

  void setSelectedTags(List<String> tags) {
    state = WineState(
      searchQuery: state.searchQuery,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      minRating: state.minRating,
      selectedTags: tags,
      selectedYear: state.selectedYear,
      selectedRegion: state.selectedRegion,
      selectedVariety: state.selectedVariety,
    );
    ref.invalidate(wineNotifierProvider);
  }

  void setSelectedYear(int? year) {
    state = WineState(
      searchQuery: state.searchQuery,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedYear: year,
      selectedRegion: state.selectedRegion,
      selectedVariety: state.selectedVariety,
    );
    ref.invalidate(wineNotifierProvider);
  }

  void setSelectedRegion(String? region) {
    state = WineState(
      searchQuery: state.searchQuery,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedYear: state.selectedYear,
      selectedRegion: region,
      selectedVariety: state.selectedVariety,
    );
    ref.invalidate(wineNotifierProvider);
  }

  void setSelectedVariety(String? variety) {
    state = WineState(
      searchQuery: state.searchQuery,
      minPrice: state.minPrice,
      maxPrice: state.maxPrice,
      minRating: state.minRating,
      selectedTags: state.selectedTags,
      selectedYear: state.selectedYear,
      selectedRegion: state.selectedRegion,
      selectedVariety: variety,
    );
    ref.invalidate(wineNotifierProvider);
  }

  void resetFilters() {
    state = const WineState();
    ref.invalidate(wineNotifierProvider);
  }
}
