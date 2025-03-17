import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'cocktail.freezed.dart';
part 'cocktail.g.dart';

@freezed
@HiveType(typeId: 1)
class Cocktail with _$Cocktail {
  factory Cocktail({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) String? base,
    @HiveField(3) required double rating,
    @HiveField(4) String? ingredients,
    @HiveField(5) String? recipe,
    @HiveField(6) List<String>? images,
    @HiveField(7) List<String>? tags,
    @HiveField(8) String? note,
    @HiveField(9) required DateTime createdAt,
    @HiveField(10) DateTime? updatedAt,
    @HiveField(11) int? difficulty,
    @HiveField(12) required String? onelineReview,
  }) = _Cocktail;

  factory Cocktail.create({
    required String name,
    String? base,
    required double rating,
    String? ingredients,
    String? recipe,
    List<String>? images,
    List<String>? tags,
    String? note,
    String? onelineReview,
  }) {
    return Cocktail(
      id: const Uuid().v4(),
      name: name,
      base: base,
      rating: rating,
      ingredients: ingredients,
      recipe: recipe,
      images: images,
      tags: tags,
      note: note,
      createdAt: DateTime.now(),
      updatedAt: null,
      onelineReview: onelineReview,
    );
  }

  factory Cocktail.fromJson(Map<String, dynamic> json) =>
      _$CocktailFromJson(json);
}
