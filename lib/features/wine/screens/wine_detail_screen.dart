import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drink_diary/core/constants/app_colors.dart';
import 'package:drink_diary/core/constants/app_sizes.dart';
import 'package:drink_diary/data/models/wine.dart';
import 'package:drink_diary/shared/widgets/rating_bar.dart';
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

    return wineAsync.when(
      data: (wines) {
        final wine = wines.firstWhere((w) => w.id == id);
        return Scaffold(
          appBar: AppBar(
            title: Text(wine.name),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // TODO: 와인 수정 화면으로 이동
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // TODO: 와인 삭제 기능 구현
                },
              ),
            ],
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
                const SizedBox(height: AppSizes.size24),
                Text(
                  '기본 정보',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSizes.size16),
                _buildInfoRow('품종', wine.variety),
                _buildInfoRow('생산지', wine.region),
                _buildInfoRow('가격', '₩${wine.price.toString()}'),
                const SizedBox(height: AppSizes.size24),
                Text(
                  '평가',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSizes.size16),
                RatingBar(
                  rating: wine.rating,
                  size: AppSizes.size32,
                  onChanged: null,
                ),
                const SizedBox(height: AppSizes.size24),
                if (wine.tags?.isNotEmpty ?? false) ...[
                  Text(
                    '태그',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSizes.size16),
                  Wrap(
                    spacing: AppSizes.size8,
                    runSpacing: AppSizes.size8,
                    children: wine.tags!
                        .map(
                          (tag) => Chip(
                            label: Text(tag),
                            backgroundColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.lightGrey
                                    : AppColors.darkGrey,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: AppSizes.size24),
                ],
                if (wine.review?.isNotEmpty ?? false) ...[
                  Text(
                    '메모',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSizes.size16),
                  Text(wine.review!),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.size8),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
