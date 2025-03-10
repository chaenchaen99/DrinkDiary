import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'cocktail.freezed.dart';
part 'cocktail.g.dart';

@freezed
@HiveType(typeId: 1)
class Cocktail with _$Cocktail {
  const factory Cocktail({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required String baseSpirit,
    @HiveField(3) required List<String> ingredients,
    @HiveField(4) required Map<String, String> ratio, // 재료: 비율

    @HiveField(5) required String method,
    @HiveField(6) required int difficulty, // 1-5

    @HiveField(7) required double rating, // 1-5

    @HiveField(8) String? review,
    @HiveField(9) List<String>? images,
    @HiveField(10) List<String>? tags,
    @HiveField(11) required DateTime createdAt,
    @HiveField(12) DateTime? updatedAt,
  }) = _Cocktail;

  factory Cocktail.fromJson(Map<String, dynamic> json) =>
      _$CocktailFromJson(json);

  // 새로운 칵테일 생성을 위한 팩토리 생성자
  factory Cocktail.create({
    required String name,
    required String baseSpirit,
    required List<String> ingredients,
    required Map<String, String> ratio,
    required String method,
    required int difficulty,
    required double rating,
    String? review,
    List<String>? images,
    List<String>? tags,
  }) {
    return Cocktail(
      id: const Uuid().v4(),
      name: name,
      baseSpirit: baseSpirit,
      ingredients: ingredients,
      ratio: ratio,
      method: method,
      difficulty: difficulty,
      rating: rating,
      review: review,
      images: images,
      tags: tags,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }
}
