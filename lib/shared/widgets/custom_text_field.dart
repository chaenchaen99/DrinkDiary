import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? suffix;
  final Widget? prefix;
  final String? Function(String?)? validator;
  final String? suffixText;
  final String icon;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.errorText,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.readOnly = false,
    this.suffix,
    this.prefix,
    this.validator,
    this.suffixText,
    this.icon = 'assets/icons/check.png',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizes.size16,
        ),
        Row(
          children: [
            Image.asset(icon, width: 16, height: 16),
            const SizedBox(width: AppSizes.paddingXS),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.grey800,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSizes.size4),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          maxLines: maxLines,
          minLines: minLines,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          readOnly: readOnly,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            labelStyle: const TextStyle(
              fontFamily: 'Pretendard',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontFamily: 'Pretendard',
            ),
            errorText: errorText,
            suffixIcon: suffix,
            prefixIcon: prefix,
            filled: true,
            fillColor: isDark ? AppColors.winePrimary : AppColors.onPrimary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radius8),
              borderSide: BorderSide(
                color: isDark ? AppColors.winePrimary : AppColors.onPrimary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radius8),
              borderSide: BorderSide(
                color: isDark ? AppColors.winePrimary : AppColors.onPrimary,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSizes.radius8),
              borderSide: BorderSide(
                color: isDark ? AppColors.winePrimary : AppColors.onPrimary,
                width: 2,
              ),
            ),
            suffixText: suffixText,
          ),
        ),
        const SizedBox(
          height: AppSizes.size8,
        ),
      ],
    );
  }
}
