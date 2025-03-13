import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_colors.dart';

class DrinkListItem extends StatelessWidget {
  final String name;
  final DateTime savedDate;
  final String? imagePath;
  final int difficulty; // 1-5
  final VoidCallback onTap;
  final bool isWine;

  const DrinkListItem({
    super.key,
    required this.name,
    required this.savedDate,
    required this.difficulty,
    required this.onTap,
    required this.isWine,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.size16,
        vertical: AppSizes.size8,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radius12),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.size12),
          child: Row(
            children: [
              // 이미지 섹션
              ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.radius8),
                child: imagePath != null
                    ? Image.file(
                        File(imagePath!),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 80,
                        height: 80,
                        color: isDark
                            ? AppColors.inverseSurface
                            : AppColors.surface,
                        child: Icon(
                          isWine ? Icons.wine_bar : Icons.local_bar,
                          size: AppSizes.iconL,
                          color: isDark
                              ? AppColors.onInverseSurface
                              : AppColors.contentSecondary,
                        ),
                      ),
              ),
              const SizedBox(width: AppSizes.size12),
              // 정보 섹션
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSizes.size4),
                    Text(
                      DateFormat('yyyy.MM.dd').format(savedDate),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: isDark
                                ? AppColors.contentTertiary
                                : AppColors.contentSecondary,
                          ),
                    ),
                    const SizedBox(height: AppSizes.size4),
                    Row(
                      children: [
                        Text(
                          '난이도',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: isDark
                                        ? AppColors.contentTertiary
                                        : AppColors.contentSecondary,
                                  ),
                        ),
                        const SizedBox(width: AppSizes.size4),
                        ...List.generate(
                          5,
                          (index) => Icon(
                            index < difficulty ? Icons.star : Icons.star_border,
                            size: AppSizes.iconS,
                            color: index < difficulty
                                ? (isDark
                                    ? AppColors.primary
                                    : AppColors.secondary)
                                : (isDark
                                    ? AppColors.contentTertiary
                                    : AppColors.contentSecondary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
