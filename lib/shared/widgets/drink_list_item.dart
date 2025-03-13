import 'package:flutter/material.dart';

class DrinkListItem extends StatelessWidget {
  final String name;
  final String onelineReview;
  final String imagePath;
  final VoidCallback onTap;

  const DrinkListItem({
    super.key,
    required this.name,
    required this.onTap,
    required this.imagePath,
    required this.onelineReview,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 4.0, // AppSizes.size16
        vertical: 4.0, // AppSizes.size8
      ),
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
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity, // 이미지가 카드 크기에 맞게 꽉 차도록 설정
                fit: BoxFit.cover,
              ),
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
                    maxLines: 2,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
