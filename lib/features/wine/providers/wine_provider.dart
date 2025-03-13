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

  // Future<List<Wine>> _loadWines() async {
  //   return [
  //     Wine(
  //       id: '1',
  //       name: '샤또 마고 2018',
  //       variety: '카베르네 소비뇽',
  //       region: '보르도',
  //       productionYear: 2018,
  //       price: 250000,
  //       rating: 4,
  //       review: '풍부한 탄닌과 긴 여운이 인상적인 와인',
  //       foodPairing: [],
  //       createdAt: DateTime(2024, 3, 15),
  //       winery: '샤또 마고',
  //       shop: '와인샵',
  //       alcoholContent: 14,
  //       aroma: 4,
  //       body: 5,
  //       tannin: 4,
  //       acidity: 3,
  //       sweetness: [],
  //     ),
  //     Wine(
  //       id: '2',
  //       name: '바롤로 2015',
  //       variety: '네비올로',
  //       region: '피에몬테',
  //       productionYear: 2015,
  //       price: 180000,
  //       rating: 5,
  //       review: '강렬한 구조감과 복합적인 아로마',
  //       foodPairing: [],
  //       createdAt: DateTime(2024, 3, 14),
  //       winery: '지아코모 콘테르노',
  //       shop: '와인웍스',
  //       alcoholContent: 14,
  //       aroma: 5,
  //       body: 5,
  //       tannin: 5,
  //       acidity: 4,
  //       sweetness: [],
  //     ),
  //     Wine(
  //       id: '3',
  //       name: '퀴베 카베르네 소비뇽',
  //       variety: '카베르네 소비뇽',
  //       region: '나파 밸리',
  //       productionYear: 2019,
  //       price: 150000,
  //       rating: 4,
  //       foodPairing: [],
  //       review: '과실향이 풍부하고 부드러운 탄닌',
  //       createdAt: DateTime(2024, 3, 13),
  //       winery: '로버트 몬다비',
  //       shop: '와인21',
  //       alcoholContent: 14,
  //       aroma: 4,
  //       body: 4,
  //       tannin: 3,
  //       acidity: 3,
  //       sweetness: [],
  //     ),
  //   ];
  // }

  Future<List<Wine>> _loadWines() async {
    try {
      final repository = ref.read(wineRepositoryProvider);
      final filter = ref.read(wineFilterProvider);
      List<Wine> wines = repository.getAllWines();

      // 필터 적용
      if (filter.searchQuery != null) {
        wines = wines
            .where((wine) => wine.name
                .toLowerCase()
                .contains(filter.searchQuery!.toLowerCase()))
            .toList();
      }

      if (filter.minRating != null) {
        wines =
            wines.where((wine) => wine.rating >= filter.minRating!).toList();
      }

      if (filter.selectedTags.isNotEmpty) {
        wines = wines
            .where((wine) =>
                wine.tags?.any((tag) => filter.selectedTags.contains(tag)) ??
                false)
            .toList();
      }

      if (filter.selectedYear != null) {
        wines = wines
            .where((wine) => wine.productionYear == filter.selectedYear)
            .toList();
      }

      if (filter.selectedRegion != null) {
        wines = wines
            .where((wine) =>
                wine.region.toLowerCase() ==
                filter.selectedRegion!.toLowerCase())
            .toList();
      }

      if (filter.selectedVariety != null) {
        wines = wines
            .where((wine) =>
                wine.variety.toLowerCase() ==
                filter.selectedVariety!.toLowerCase())
            .toList();
      }

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
