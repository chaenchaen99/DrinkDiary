import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../data/models/wine.dart';
part 'wine_state.freezed.dart';

@freezed
class WineState with _$WineState {
  const factory WineState({
    @Default([]) List<Wine> wines,
    @Default(true) bool isLoading,
    @Default(null) String? error,
    // 필터링 상태
    @Default(null) double? minPrice,
    @Default(null) double? maxPrice,
    @Default(null) double? minRating,
    @Default([]) List<String> selectedTags,
    @Default(null) String? searchQuery,
    @Default(null) int? selectedYear,
    @Default(null) String? selectedRegion,
    @Default(null) String? selectedVariety,
  }) = _WineState;
}
