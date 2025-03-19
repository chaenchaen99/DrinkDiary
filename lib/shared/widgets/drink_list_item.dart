import 'dart:io';

import 'package:drink_diary/core/constants/app_sizes.dart';
import 'package:drink_diary/shared/widgets/rating_bar.dart';
import 'package:flutter/material.dart';

class DrinkListItem extends StatelessWidget {
  final String id;
  final String name;
  final String onelineReview;
  final String? alcohol;
  final double rating;
  final String imagePath;
  final VoidCallback onTap;

  const DrinkListItem({
    super.key,
    required this.name,
    required this.onTap,
    required this.imagePath,
    required this.onelineReview,
    this.alcohol,
    required this.rating,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // 카드에 둥근 모서리 추가
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            // 배경 이미지 (radius 적용 및 카드 크기 맞춤)
            ClipRRect(
              borderRadius: BorderRadius.circular(12), // 이미지도 카드와 동일한 radius 적용
              child: _getImageWidget(imagePath),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), // 추가된 부분: radius 적용
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent, // 위쪽은 투명
                      Colors.black.withAlpha(80),
                      Colors.black.withAlpha(100), // 아래쪽은 반투명 검정
                    ],
                  ),
                ),
              ),
            ),
            // 텍스트 오버레이
            Positioned(
              bottom: 16.0,
              left: 8.0,
              right: 8.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    onelineReview,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  alcohol != null
                      ? Text(
                          alcohol!,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 2.0),
                  RatingBar(
                    rating: rating,
                    size: AppSizes.iconS,
                    onChanged: null,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 파일 경로에 따른 이미지 위젯 반환
  Widget _getImageWidget(String imagePath) {
    // 파일 경로가 존재하는지 확인
    final file = File(imagePath);
    debugPrint("이미지 로드 경로$imagePath");
    if (file.existsSync()) {
      // 파일이 존재하면 해당 이미지를 반환
      return Image.file(
        file,
        width: double.infinity,
        height: double.infinity, // 이미지가 카드 크기에 맞게 꽉 차도록 설정
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          debugPrint('Error loading image: $error');
          return Image.asset(
            'assets/images/wine_default.png',
            fit: BoxFit.cover,
          );
        },
      );
    } else {
      // 파일이 존재하지 않으면 기본 이미지 반환
      return Image.asset(
        'assets/images/wine_default.png',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}
