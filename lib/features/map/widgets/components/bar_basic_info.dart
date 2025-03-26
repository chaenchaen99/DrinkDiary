import 'package:flutter/material.dart';

import '../../../../core/constants/app_sizes.dart';
import '../../../../data/models/drinkbar.dart';
import '../../../../shared/widgets/heart_animation.dart';

class BarBasicInfo extends StatelessWidget {
  final DrinkBar bar;

  const BarBasicInfo({super.key, required this.bar});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                bar.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              const HeartAnimation(),
            ],
          ),
          const SizedBox(height: AppSizes.paddingXS),
          Text(
            bar.onelineReview,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[700],
            ),
          ),
          Text(
            bar.address,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
