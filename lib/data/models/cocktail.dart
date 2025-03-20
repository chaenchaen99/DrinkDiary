import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'drink.dart';

part 'cocktail.freezed.dart';
part 'cocktail.g.dart';

@freezed
@HiveType(typeId: 2)
class Cocktail with _$Cocktail implements Drink, TimestampMixin {
  @Implements<Drink>() // Drink 인터페이스 구현
  const factory Cocktail({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required double rating,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) DateTime? updatedAt,
    @HiveField(5) List<String>? images,
    @HiveField(6) required String onelineReview,
    // 칵테일 전용 필드
    @HiveField(7) required String base,
    @HiveField(8) required String ingredients,
    @HiveField(9) required String recipe,
    @HiveField(10) required List<String> tags,
    @HiveField(11) required String review,
  }) = _Cocktail;

  factory Cocktail.create({
    required String name,
    required double rating,
    String onelineReview = '',
    String base = '',
    String ingredients = '',
    String recipe = '',
    List<String> tags = const [],
    String review = '',
    List<String>? images,
  }) {
    return Cocktail(
      id: const Uuid().v4(),
      name: name,
      rating: rating,
      createdAt: DateTime.now(),
      updatedAt: null,
      images: images,
      onelineReview: onelineReview,
      base: base,
      ingredients: ingredients,
      recipe: recipe,
      tags: tags,
      review: review,
    );
  }

  factory Cocktail.fromJson(Map<String, dynamic> json) =>
      _$CocktailFromJson(json);
}
