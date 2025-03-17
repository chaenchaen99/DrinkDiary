import 'package:drink_diary/features/home/providers/category_provider.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class RatingBar extends StatefulWidget {
  final double rating;
  final double size;
  final ValueChanged<double>? onChanged;
  final String? label;
  final bool showLabel;
  final DrinkCategory category;
  final Color activeColor;
  final Color? inactiveColor;
  final EdgeInsetsGeometry padding;

  const RatingBar({
    super.key,
    required this.rating,
    this.size = AppSizes.iconM,
    this.onChanged,
    this.label,
    this.showLabel = true,
    this.category = DrinkCategory.wine,
    this.activeColor = Colors.white,
    this.inactiveColor = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: AppSizes.size16),
  });

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  late double _currentRating;

  @override
  void initState() {
    super.initState();
    _currentRating = widget.rating; // 초기값 설정
  }

  void _handleTap(int index) {
    setState(() {
      _currentRating = index + 1; // 선택한 별 개수 반영 (1~5)
    });
    widget.onChanged?.call(_currentRating);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel && widget.label != null) ...[
          Row(
            children: [
              Image.asset('assets/icons/check.png', width: 16, height: 16),
              const SizedBox(width: AppSizes.paddingXS),
              Text(
                widget.label!,
                style: const TextStyle(
                  color: AppColors.grey800,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.size8),
        ],
        Container(
          margin: widget.padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              final isActive = index < _currentRating; // 누른 별까지 활성화
              return GestureDetector(
                onTap: () => _handleTap(index), // 해당 별까지 선택
                child: Padding(
                  padding: const EdgeInsets.only(right: AppSizes.size8),
                  child: Icon(
                    isActive ? Icons.star : Icons.star_border,
                    color: isActive ? widget.activeColor : widget.inactiveColor,
                    size: widget.size,
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
