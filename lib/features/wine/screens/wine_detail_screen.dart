import 'dart:io';
import 'package:drink_diary/features/home/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drink_diary/core/constants/app_colors.dart';
import 'package:drink_diary/core/constants/app_sizes.dart';
import 'package:drink_diary/data/models/wine.dart';
import 'package:drink_diary/shared/widgets/rating_bar.dart';
import '../../../shared/widgets/detail_app_bar.dart';
import '../providers/wine_provider.dart';

class WineDetailScreen extends ConsumerWidget {
  final String id;

  const WineDetailScreen({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineAsync = ref.watch(wineNotifierProvider);
    final category = ref.watch(categoryNotifierProvider);

    return wineAsync.when(
      data: (wines) {
        final wine = wines.firstWhere((w) => w.id == id);
        return Scaffold(
          appBar: DetailAppBar(
            category: category,
            drink: wine,
            onEdit: () {},
            onDelete: () {},
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.size16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (wine.images?.isNotEmpty ?? false)
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: wine.images?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: AppSizes.size8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(AppSizes.size8),
                            child: Image.file(
                              File(wine.images![index]),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: AppSizes.size16),
                buildInfoRow('와인 이름', wine.name),
                buildInfoRow('한줄평', wine.onelineReview),
                buildInfoRow('음식 페어링', wine.foodPairing.join(', ')),
                buildInfoRow(
                    '알코올 도수', '${wine.alcoholContent.toStringAsFixed(1)}%'),
                buildInfoRow('생산년도', '${wine.productionYear}년도'),
                buildInfoRow('생산지', wine.region),
                buildInfoRow('품종', wine.variety),
                buildInfoRow('와이너리', wine.winery),
                buildInfoRow('가격', '₩${wine.price.toString()}'),
                buildInfoRow('구매처', wine.shop),
                buildInfoRow('향', wine.aroma.join(',')),
                Row(
                  children: [
                    const SizedBox(
                      width: 80,
                      child: Text(
                        '평가',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RatingBar(
                        rating: wine.rating,
                        size: AppSizes.iconS,
                        activeColor: category.theme.backgroundColor,
                        inactiveColor: category.theme.backgroundColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: AppSizes.size8),
                buildInfoRow('리뷰', wine.review),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}

Widget buildInfoRow(String label, String? value) {
  return value != null && value != ''
      ? Padding(
          padding: const EdgeInsets.only(bottom: AppSizes.size12),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Text(value),
              ),
            ],
          ),
        )
      : const SizedBox.shrink();
}
