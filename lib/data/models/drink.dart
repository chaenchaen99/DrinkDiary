abstract class Drink {
  String get id;
  String get name;
  double get rating;
  DateTime get createdAt;
  DateTime? get updatedAt;
  List<String>? get images;
  String? get onelineReview;
}

mixin TimestampMixin {
  DateTime get createdAt;
  DateTime? get updatedAt;
}
