import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'wine.freezed.dart';
part 'wine.g.dart';

@freezed
@HiveType(typeId: 0)
class Wine with _$Wine {
  const factory Wine({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required int productionYear,
    @HiveField(3) required String region,
    @HiveField(4) required String variety,
    @HiveField(5) required String winery,
    @HiveField(6) required double price,
    @HiveField(7) required String shop,
    @HiveField(8) required double alcoholContent,

    // 테이스팅 노트
    @HiveField(9) required int aroma, // 1-5

    @HiveField(10) required int body, // 1-5

    @HiveField(11) required int tannin, // 1-5

    @HiveField(12) required int acidity, // 1-5

    @HiveField(13) required List<String> foodPairing,
    @HiveField(14) required double rating, // 1-5

    @HiveField(15) String? review,
    @HiveField(16) List<String>? images,
    @HiveField(17) List<String>? tags,
    @HiveField(18) required DateTime createdAt,
    @HiveField(19) DateTime? updatedAt,
    @HiveField(20) required int sweetness,
    @HiveField(21) String? onelineReview,
  }) = _Wine;

  factory Wine.fromJson(Map<String, dynamic> json) => _$WineFromJson(json);

  // 새로운 와인 생성을 위한 팩토리 생성자
  factory Wine.create({
    String name = '',
    int productionYear = 0,
    String region = '',
    String variety = '',
    String winery = '',
    double price = 0,
    String shop = '',
    double alcoholContent = 0,
    int aroma = 3,
    int body = 3,
    int tannin = 3,
    int acidity = 3,
    List<String> foodPairing = const [],
    double rating = 0,
    String? review,
    List<String>? images,
    List<String>? tags,
    int sweetness = 3,
    String? onelineReview,
  }) {
    return Wine(
      id: const Uuid().v4(),
      name: name,
      productionYear: productionYear,
      region: region,
      variety: variety,
      winery: winery,
      price: price,
      shop: shop,
      alcoholContent: alcoholContent,
      aroma: aroma,
      body: body,
      tannin: tannin,
      acidity: acidity,
      foodPairing: foodPairing,
      rating: rating,
      review: review,
      images: images,
      tags: tags,
      createdAt: DateTime.now(),
      updatedAt: null,
      sweetness: sweetness,
      onelineReview: onelineReview,
    );
  }
}
