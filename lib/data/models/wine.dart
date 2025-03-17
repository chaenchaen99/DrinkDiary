import 'package:drink_diary/data/models/drink.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'wine.freezed.dart';
part 'wine.g.dart';

@freezed
@HiveType(typeId: 1)
class Wine with _$Wine implements Drink, TimestampMixin {
  @Implements<Drink>()
  const factory Wine({
    // 기본 Drink 필드
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required double rating,
    @HiveField(3) required DateTime createdAt,
    @HiveField(4) DateTime? updatedAt,
    @HiveField(5) List<String>? images,
    @HiveField(6) String? onelineReview,

    // 와인 전용 필드
    @HiveField(7) required String productionYear,
    @HiveField(8) required String region,
    @HiveField(9) required String variety,
    @HiveField(10) required String winery,
    @HiveField(11) required double price,
    @HiveField(12) required String shop,
    @HiveField(13) required double alcoholContent,
    @HiveField(14) required int sweetness,
    @HiveField(15) required int body,
    @HiveField(16) required int tannin,
    @HiveField(17) required int acidity,
    @HiveField(18) required List<String> foodPairing,
    @HiveField(19) String? review, // 상세 리뷰
    @HiveField(20) List<String>? tags,
    @HiveField(21) required List<String> aroma,
  }) = _Wine;

  factory Wine.create({
    required String name,
    double rating = 3.0,
    String productionYear = '',
    String region = '',
    String variety = '',
    String winery = '',
    double price = 0,
    String shop = '',
    double alcoholContent = 0,
    int sweetness = 3,
    int body = 3,
    int tannin = 3,
    int acidity = 3,
    List<String> foodPairing = const [],
    List<String> aroma = const [],
    String? onelineReview,
    String? review,
    List<String>? images,
  }) {
    return Wine(
      id: const Uuid().v4(),
      name: name,
      rating: rating,
      createdAt: DateTime.now(),
      updatedAt: null,
      images: images,
      onelineReview: onelineReview,
      productionYear: productionYear,
      region: region,
      variety: variety,
      winery: winery,
      price: price,
      shop: shop,
      alcoholContent: alcoholContent,
      sweetness: sweetness,
      body: body,
      tannin: tannin,
      acidity: acidity,
      foodPairing: foodPairing,
      aroma: aroma,
      review: review,
      tags: [],
    );
  }

  factory Wine.fromJson(Map<String, dynamic> json) => _$WineFromJson(json);
}
