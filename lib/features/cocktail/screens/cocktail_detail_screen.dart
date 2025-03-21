import 'dart:io';
import 'package:drink_diary/features/cocktail/providers/cocktail_provider.dart';
import 'package:drink_diary/features/home/providers/category_provider.dart';
import 'package:drink_diary/shared/widgets/detail_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../data/models/cocktail.dart';
import '../../../shared/widgets/rating_bar.dart';
import '../../wine/screens/wine_detail_screen.dart';

class CocktailDetailScreen extends ConsumerWidget {
  final Cocktail cocktail;

  const CocktailDetailScreen({
    super.key,
    required this.cocktail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryNotifierProvider);

    return Scaffold(
      appBar: DetailAppBar(
        category: category,
        drink: cocktail,
        onEdit: () {
          context.push('/cocktails/${cocktail.id}/edit');
          // context.pushNamed(
          //   'cocktail_edit',
          //   pathParameters: {'id': cocktail.id}, // 실제 ID로 교체
          // );
        },
        onDelete: () {
          ref
              .read(cocktailNotifierProvider.notifier)
              .deleteCocktail(cocktail.id);
          context.pop();
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSizes.size16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (cocktail.images != null && cocktail.images!.isNotEmpty)
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: cocktail.images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSizes.size8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSizes.size8),
                        child: Image.file(
                          File(cocktail.images![index]),
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
            buildInfoRow('칵테일 이름', cocktail.name,
                icon: 'assets/icons/cocktail.png'),
            buildInfoRow('한줄평', cocktail.onelineReview),
            buildInfoRow('베이스', cocktail.base, icon: 'assets/icons/whisky.png'),
            buildInfoRow('재료', cocktail.ingredients,
                icon: 'assets/icons/ingredient.png'),
            buildInfoRow('레시피', cocktail.recipe,
                icon: 'assets/icons/recipe.png'),
            buildInfoRow('맛 태그', cocktail.tags.join(','),
                icon: 'assets/icons/tag.png'),
            buildInfoRow('기록', cocktail.review,
                isReview: true, icon: 'assets/icons/memo.png'),
            Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icons/star.png',
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(width: AppSizes.size4),
                      const Text(
                        '평가',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: RatingBar(
                      rating: cocktail.rating,
                      size: AppSizes.iconS,
                      activeColor: category.theme.backgroundColor,
                      inactiveColor: category.theme.backgroundColor,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
