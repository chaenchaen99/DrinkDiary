import 'dart:io';
import 'package:drink_diary/features/wine/providers/wine_provider.dart';
import 'package:drink_diary/shared/widgets/drink_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class WineListScreen extends ConsumerWidget {
  const WineListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineState = ref.watch(wineNotifierProvider);

    return Scaffold(
      body: wineState.when(
        data: (wines) {
          if (wines.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wine_bar_outlined,
                    size: AppSizes.size48,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.lightGrey
                        : AppColors.darkGrey,
                  ),
                  const SizedBox(height: AppSizes.size16),
                  Text(
                    '기록된 와인이 없습니다.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppSizes.size16),
            itemCount: wines.length,
            itemBuilder: (context, index) {
              final wine = wines[index];
              return DrinkListItem(
                  name: wine.name,
                  onTap: () {},
                  imagePath: wine.images != null && wine.images!.isNotEmpty
                      ? wine.images!.first
                      : 'assets/images/wine_default.png',
                  onelineReview: wine.onelineReview ?? '');
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 한 줄에 2개 항목
              crossAxisSpacing: AppSizes.size8, // 열 간격
              mainAxisSpacing: AppSizes.size8, // 행 간격
              childAspectRatio: 0.7, // 각 항목의 비율 (가로/세로)
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('에러가 발생했습니다: $error'),
        ),
      ),
    );
  }
}
