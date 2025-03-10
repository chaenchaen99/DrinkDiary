import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/cocktail.dart';
import '../../../shared/widgets/rating_bar.dart';

class CocktailDetailScreen extends ConsumerWidget {
  final Cocktail cocktail;

  const CocktailDetailScreen({
    super.key,
    required this.cocktail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cocktail.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // TODO: 칵테일 수정 화면으로 이동
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // TODO: 칵테일 삭제 기능 구현
            },
          ),
        ],
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
            Text(
              '기본 정보',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.size16),
            _buildInfoRow('베이스', cocktail.base),
            _buildInfoRow('글래스', cocktail.glass),
            _buildInfoRow('가니쉬', cocktail.garnish),
            _buildInfoRow('가격', '₩${cocktail.price.toString()}'),
            const SizedBox(height: AppSizes.size24),
            Text(
              '재료',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.size16),
            if (cocktail.ingredients != null)
              ...cocktail.ingredients!
                  .map((ingredient) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.size8),
                        child: Text('• $ingredient'),
                      ))
                  .toList(),
            const SizedBox(height: AppSizes.size24),
            Text(
              '레시피',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.size16),
            if (cocktail.recipe != null)
              ...cocktail.recipe!
                  .map((step) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSizes.size8),
                        child: Text(
                            '${cocktail.recipe!.indexOf(step) + 1}. $step'),
                      ))
                  .toList(),
            const SizedBox(height: AppSizes.size24),
            Text(
              '평가',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSizes.size16),
            RatingBar(
              rating: cocktail.rating,
              size: AppSizes.size32,
              onChanged: null,
            ),
            const SizedBox(height: AppSizes.size24),
            if (cocktail.tags != null && cocktail.tags!.isNotEmpty) ...[
              Text(
                '태그',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.size16),
              Wrap(
                spacing: AppSizes.size8,
                runSpacing: AppSizes.size8,
                children: cocktail.tags!
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
            if (cocktail.note != null && cocktail.note!.isNotEmpty) ...[
              Text(
                '메모',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSizes.size16),
              Text(cocktail.note!),
            ],
          ],
        ),
      ),
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
