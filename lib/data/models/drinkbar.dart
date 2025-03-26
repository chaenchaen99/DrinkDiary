import 'package:freezed_annotation/freezed_annotation.dart';

import 'comment.dart';

part 'drinkbar.freezed.dart';
part 'drinkbar.g.dart';

@freezed
class DrinkBar with _$DrinkBar {
  const factory DrinkBar({
    required String id, // 고유 ID
    required String name, // 바 이름
    required String address, // 주소
    required String onelineReview, // 한줄평
    required double latitude, // 위도
    required double longitude, // 경도
    String? phone, // 전화번호
    String? description, // 바 설명
    List<String>? images, // 이미지 URL 리스트
    @Default(0) int recommendationCount, // 추천 횟수
    @Default([]) List<Comment> comments, // 댓글 리스트
    String? link, // 웹사이트/SNS 링크
    required DateTime createdAt, // 생성 시간
    required String createdBy, // 추천한 사용자 ID
  }) = _DrinkBar;

  factory DrinkBar.fromJson(Map<String, dynamic> json) =>
      _$DrinkBarFromJson(json);
}
