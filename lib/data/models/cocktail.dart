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
    @HiveField(2) required String base,
    @HiveField(3) required String glass,
    @HiveField(4) required String garnish,
    @HiveField(5) required double price,
    @HiveField(6) required double rating,
    @HiveField(7) List<String>? ingredients,
    @HiveField(8) List<String>? recipe,
    @HiveField(9) List<String>? images,
    @HiveField(10) List<String>? tags,
    @HiveField(11) String? note,
    @HiveField(12) required DateTime createdAt,
    @HiveField(13) DateTime? updatedAt,
    @HiveField(14) int? difficulty,
  }) = _Cocktail;

  factory Cocktail.create({
    required String name,
    required String base,
    required String glass,
    required String garnish,
    required double price,
    required double rating,
    List<String>? ingredients,
    List<String>? recipe,
    List<String>? images,
    List<String>? tags,
    String? note,
  }) {
    return Cocktail(
      id: const Uuid().v4(),
      name: name,
      base: base,
      glass: glass,
      garnish: garnish,
      price: price,
      rating: rating,
      ingredients: ingredients,
      recipe: recipe,
      images: images,
      tags: tags,
      note: note,
      createdAt: DateTime.now(),
      updatedAt: null,
    );
  }

  factory Cocktail.fromJson(Map<String, dynamic> json) =>
      _$CocktailFromJson(json);
}
