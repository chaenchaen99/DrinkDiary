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
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wineRepositoryProvider);
      List<Wine>? wines = repository.getAllWines();

      // 최신순 정렬
      wines?.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      state = AsyncValue.data(wines ?? []);
      return wines ?? [];
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
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
  Future<bool> updateWine(Wine wine) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wineRepositoryProvider);
      final oldWine = (state.value ?? []).firstWhere((w) => w.id == wine.id);

      print('oldWine: ${oldWine == wine}');

      if (oldWine != wine) {
        await repository.updateWine(wine);
        state = AsyncValue.data(await _loadWines());
        return true; // 수정된 내용이 있음
      } else {
        state = AsyncValue.data(state.value ?? []);
        return false; // 수정된 내용이 없음
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
      return false;
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

  //검색 필터링
  Future<void> setSearchQuery(String query) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(wineRepositoryProvider);
      List<Wine>? wines = repository.getAllWines();

      wines = wines?.where((wine) {
        return wine.name.contains(query) || // 와인 이름 검색
            wine.aroma.contains(query) || // 향 검색
            wine.shop.contains(query) || // 매장 검색
            wine.productionYear.contains(query) || // 생산년도 검색
            wine.region.contains(query) || // 생산 지역 검색
            wine.variety.contains(query); // 와인 종류 검색
      }).toList();

      state = AsyncValue.data(wines ?? []);
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

  // void setPriceRange(double? min, double? max) {
  //   state = WineState(
  //     searchQuery: state.searchQuery,
  //     minPrice: min,
  //     maxPrice: max,
  //     minRating: state.minRating,
  //     selectedTags: state.selectedTags,
  //     selectedYear: state.selectedYear,
  //     selectedRegion: state.selectedRegion,
  //     selectedVariety: state.selectedVariety,
  //   );
  //   ref.invalidate(wineNotifierProvider);
  // }

  // void setMinRating(double? rating) {
  //   state = WineState(
  //     searchQuery: state.searchQuery,
  //     minPrice: state.minPrice,
  //     maxPrice: state.maxPrice,
  //     minRating: rating,
  //     selectedTags: state.selectedTags,
  //     selectedYear: state.selectedYear,
  //     selectedRegion: state.selectedRegion,
  //     selectedVariety: state.selectedVariety,
  //   );
  //   ref.invalidate(wineNotifierProvider);
  // }

  // void setSelectedTags(List<String> tags) {
  //   state = WineState(
  //     searchQuery: state.searchQuery,
  //     minPrice: state.minPrice,
  //     maxPrice: state.maxPrice,
  //     minRating: state.minRating,
  //     selectedTags: tags,
  //     selectedYear: state.selectedYear,
  //     selectedRegion: state.selectedRegion,
  //     selectedVariety: state.selectedVariety,
  //   );
  //   ref.invalidate(wineNotifierProvider);
  // }

  // void setSelectedYear(int? year) {
  //   state = WineState(
  //     searchQuery: state.searchQuery,
  //     minPrice: state.minPrice,
  //     maxPrice: state.maxPrice,
  //     minRating: state.minRating,
  //     selectedTags: state.selectedTags,
  //     selectedYear: year,
  //     selectedRegion: state.selectedRegion,
  //     selectedVariety: state.selectedVariety,
  //   );
  //   ref.invalidate(wineNotifierProvider);
  // }

  // void setSelectedRegion(String? region) {
  //   state = WineState(
  //     searchQuery: state.searchQuery,
  //     minPrice: state.minPrice,
  //     maxPrice: state.maxPrice,
  //     minRating: state.minRating,
  //     selectedTags: state.selectedTags,
  //     selectedYear: state.selectedYear,
  //     selectedRegion: region,
  //     selectedVariety: state.selectedVariety,
  //   );
  //   ref.invalidate(wineNotifierProvider);
  // }

  // void setSelectedVariety(String? variety) {
  //   state = WineState(
  //     searchQuery: state.searchQuery,
  //     minPrice: state.minPrice,
  //     maxPrice: state.maxPrice,
  //     minRating: state.minRating,
  //     selectedTags: state.selectedTags,
  //     selectedYear: state.selectedYear,
  //     selectedRegion: state.selectedRegion,
  //     selectedVariety: variety,
  //   );
  //   ref.invalidate(wineNotifierProvider);
  // }

  void resetFilters() {
    state = const WineState();
    ref.invalidate(wineNotifierProvider);
  }
}
