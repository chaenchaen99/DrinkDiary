import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/wine.dart';

part 'wine_repository.g.dart';

class WineRepository {
  static const String boxName = 'wines';
  final Box<Wine> _box;

  WineRepository(this._box);

  // 와인 추가
  Future<void> addWine(Wine wine) async {
    await _box.put(wine.id, wine);
  }

  // 와인 수정
  Future<void> updateWine(Wine wine) async {
    await _box.put(
        wine.id,
        wine.copyWith(
          updatedAt: DateTime.now(),
        ));
  }

  // 와인 삭제
  Future<void> deleteWine(String id) async {
    await _box.delete(id);
  }

  // 와인 전부 삭제
  Future<void> deleteAllWine() async {
    await _box.clear();
  }

  // ID로 와인 조회
  Wine? getWine(String id) {
    return _box.get(id);
  }

  // 모든 와인 조회
  List<Wine> getAllWines() {
    return _box.values.toList();
  }

  // 정렬된 와인 목록 조회 (최신순)
  List<Wine> getWinesSortedByDate() {
    return _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // 가격 범위로 와인 검색
  List<Wine> getWinesByPriceRange(double min, double max) {
    return _box.values
        .where((wine) => wine.price >= min && wine.price <= max)
        .toList();
  }

  // 태그로 와인 검색
  List<Wine> getWinesByTags(List<String> tags) {
    return _box.values
        .where((wine) => wine.tags?.any((tag) => tags.contains(tag)) ?? false)
        .toList();
  }

  // 평점으로 와인 검색
  List<Wine> getWinesByMinRating(double minRating) {
    return _box.values.where((wine) => wine.rating >= minRating).toList();
  }

  // 생산년도로 와인 검색
  List<Wine> getWinesByYear(int year) {
    return _box.values.where((wine) => wine.productionYear == year).toList();
  }

  // 와인 이름으로 검색
  List<Wine> searchWinesByName(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _box.values
        .where((wine) => wine.name.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  // 생산지로 와인 검색
  List<Wine> getWinesByRegion(String region) {
    return _box.values
        .where((wine) => wine.region.toLowerCase() == region.toLowerCase())
        .toList();
  }

  // 품종으로 와인 검색
  List<Wine> getWinesByVariety(String variety) {
    return _box.values
        .where((wine) => wine.variety.toLowerCase() == variety.toLowerCase())
        .toList();
  }
}

@riverpod
WineRepository wineRepository(WineRepositoryRef ref) {
  final box = Hive.box<Wine>(WineRepository.boxName);
  return WineRepository(box);
}
