import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_strings.dart';

class TagInput extends StatefulWidget {
  final List<String> tags;
  final Function(List<String>) onTagsChanged;
  final String? label;
  final String? hint;

  const TagInput({
    super.key,
    required this.tags,
    required this.onTagsChanged,
    this.label,
    this.hint,
  });

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    if (tag.isNotEmpty && !widget.tags.contains(tag)) {
      widget.onTagsChanged([...widget.tags, tag]);
      _controller.clear();
    }
  }

  void _removeTag(String tag) {
    widget.onTagsChanged(widget.tags.where((t) => t != tag).toList());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSizes.size4),
        ],
        Wrap(
          spacing: AppSizes.size8,
          runSpacing: AppSizes.size8,
          children: [
            ...widget.tags.map((tag) => Chip(
                  label: Text(tag),
                  deleteIcon: const Icon(Icons.close, size: AppSizes.iconS),
                  onDeleted: () => _removeTag(tag),
                  backgroundColor:
                      isDark ? AppColors.secondary : AppColors.onSecondary,
                  side: BorderSide(
                    color:
                        isDark ? AppColors.winePrimary : AppColors.onSecondary,
                  ),
                )),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.hint ?? AppStrings.tags,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.paddingS,
                    vertical: AppSizes.paddingXS,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                    borderSide: BorderSide(
                      color:
                          isDark ? AppColors.winePrimary : AppColors.onPrimary,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                    borderSide: BorderSide(
                      color:
                          isDark ? AppColors.onPrimary : AppColors.onSecondary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.inputRadius),
                    borderSide: BorderSide(
                      color:
                          isDark ? AppColors.winePrimary : AppColors.secondary,
                      width: 2,
                    ),
                  ),
                ),
                onSubmitted: _addTag,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
