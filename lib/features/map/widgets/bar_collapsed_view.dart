import 'package:flutter/material.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../data/models/drinkbar.dart';
import 'components/bar_basic_info.dart';
import 'components/bar_image_gallery.dart';

class BarCollapsedView extends StatelessWidget {
  final DrinkBar bar;
  final VoidCallback onTap;
  final ScrollController scrollController;

  const BarCollapsedView({
    super.key,
    required this.bar,
    required this.onTap,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          controller: scrollController,
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DragHandle(),
                  const SizedBox(height: AppSizes.paddingM),
                  BarBasicInfo(bar: bar),
                  const SizedBox(height: AppSizes.paddingS),
                  BarImageGallery(
                    images: bar.images,
                    height: 100,
                    imageWidth: 100,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DragHandle extends StatelessWidget {
  const DragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
          width: 60,
          height: 2,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
