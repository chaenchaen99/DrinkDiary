import 'dart:io';
import 'package:drink_diary/features/home/providers/category_provider.dart';
import 'package:drink_diary/shared/widgets/detail_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
          category: category, drink: cocktail, onEdit: () {}, onDelete: () {}),
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
            buildInfoRow('칵테일 이름', cocktail.name),
            buildInfoRow('한줄평', cocktail.onelineReview),
            buildInfoRow('베이스', cocktail.base),
            buildInfoRow('재료', cocktail.ingredients),
            buildInfoRow('레시피', cocktail.recipe),
            buildInfoRow('맛 태그', cocktail.tags?.join(',') ?? ''),
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
                    rating: cocktail.rating,
                    size: AppSizes.iconS,
                    activeColor: category.theme.backgroundColor,
                    inactiveColor: category.theme.backgroundColor,
                  ),
                )
              ],
            ),
            buildInfoRow('기록', cocktail.review),
          ],
        ),
      ),
    );
  }
}
