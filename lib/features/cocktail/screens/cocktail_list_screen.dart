import 'package:drink_diary/features/cocktail/providers/cocktail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/widgets/drink_list_item.dart';

class CocktailListScreen extends ConsumerWidget {
  const CocktailListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cocktailState = ref.watch(cocktailNotifierProvider);

    return Scaffold(
      body: cocktailState.when(
        data: (cocktails) {
          if (cocktails.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_bar_outlined,
                    size: AppSizes.size48,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.grey100
                        : AppColors.grey800,
                  ),
                  const SizedBox(height: AppSizes.size16),
                  const Text(
                    '기록된 칵테일이 없습니다.',
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      color: AppColors.grey500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppSizes.size4),
            itemCount: cocktails.length,
            itemBuilder: (context, index) {
              final cocktail = cocktails[index];
              return DrinkListItem(
                name: cocktail.name,
                onTap: () {
                  context.push('/cocktails/${cocktail.id}');
                },
                imagePath:
                    cocktail.images != null && cocktail.images!.isNotEmpty
                        ? cocktail.images!.first
                        : 'assets/images/wine_default.png',
                onelineReview: cocktail.onelineReview ?? '',
                rating: cocktail.rating,
                id: cocktail.id,
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 한 줄에 2개 항목
              crossAxisSpacing: AppSizes.size4, // 열 간격
              mainAxisSpacing: AppSizes.size4, // 행 간격
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
