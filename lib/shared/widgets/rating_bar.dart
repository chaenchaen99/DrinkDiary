import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double size;
  final ValueChanged<double>? onChanged;
  final String? label;
  final bool showLabel;

  const RatingBar({
    super.key,
    required this.rating,
    this.size = AppSizes.iconM,
    this.onChanged,
    this.label,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final activeColor = isDark ? AppColors.primary : AppColors.onPrimary;
    final inactiveColor = isDark ? AppColors.secondary : AppColors.onSecondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel && label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.size8),
        ],
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            final isActive = index < rating;
            return GestureDetector(
              onTap: onChanged != null ? () => onChanged!(index + 1) : null,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSizes.size8),
                child: Icon(
                  isActive ? Icons.star : Icons.star_border,
                  color: isActive ? activeColor : inactiveColor,
                  size: size,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
