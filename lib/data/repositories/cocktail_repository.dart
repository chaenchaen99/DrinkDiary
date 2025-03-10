import 'package:flutter_drinkdiary/data/models/cocktail.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cocktail_repository.g.dart';

class CocktailRepository {
  static const String boxName = 'cocktails';
  final Box<Cocktail> _box;

  CocktailRepository(this._box);

  // 칵테일 추가
  Future<void> addCocktail(Cocktail cocktail) async {
    await _box.put(cocktail.id, cocktail);
  }

  // 칵테일 수정
  Future<void> updateCocktail(Cocktail cocktail) async {
    await _box.put(
        cocktail.id,
        cocktail.copyWith(
          updatedAt: DateTime.now(),
        ));
  }

  // 칵테일 삭제
  Future<void> deleteCocktail(String id) async {
    await _box.delete(id);
  }

  // ID로 칵테일 조회
  Cocktail? getCocktail(String id) {
    return _box.get(id);
  }

  // 모든 칵테일 조회
  List<Cocktail> getAllCocktails() {
    return _box.values.toList();
  }

  // 정렬된 칵테일 목록 조회 (최신순)
  List<Cocktail> getCocktailsSortedByDate() {
    return _box.values.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  // 베이스 술로 칵테일 검색
  List<Cocktail> getCocktailsByBaseSpirit(String baseSpirit) {
    return _box.values
        .where((cocktail) =>
            cocktail.baseSpirit.toLowerCase() == baseSpirit.toLowerCase())
        .toList();
  }

  // 난이도로 칵테일 검색
  List<Cocktail> getCocktailsByDifficulty(int difficulty) {
    return _box.values
        .where((cocktail) => cocktail.difficulty == difficulty)
        .toList();
  }

  // 태그로 칵테일 검색
  List<Cocktail> getCocktailsByTags(List<String> tags) {
    return _box.values
        .where((cocktail) =>
            cocktail.tags?.any((tag) => tags.contains(tag)) ?? false)
        .toList();
  }

  // 평점으로 칵테일 검색
  List<Cocktail> getCocktailsByMinRating(double minRating) {
    return _box.values
        .where((cocktail) => cocktail.rating >= minRating)
        .toList();
  }

  // 칵테일 이름으로 검색
  List<Cocktail> searchCocktailsByName(String query) {
    final lowercaseQuery = query.toLowerCase();
    return _box.values
        .where(
            (cocktail) => cocktail.name.toLowerCase().contains(lowercaseQuery))
        .toList();
  }

  // 재료로 칵테일 검색
  List<Cocktail> getCocktailsByIngredient(String ingredient) {
    return _box.values
        .where((cocktail) => cocktail.ingredients
            .any((i) => i.toLowerCase() == ingredient.toLowerCase()))
        .toList();
  }
}

@riverpod
CocktailRepository cocktailRepository(CocktailRepositoryRef ref) {
  final box = Hive.box<Cocktail>(CocktailRepository.boxName);
  return CocktailRepository(box);
}
