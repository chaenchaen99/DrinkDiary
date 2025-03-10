import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../providers/category_provider.dart';
import '../../wine/screens/wine_list_screen.dart';
import '../../cocktail/screens/cocktail_list_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? (category == DrinkCategory.wine
              ? AppColors.wineSurface
              : AppColors.cocktailSurface)
          : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSizes.size16),
              decoration: BoxDecoration(
                color: isDark
                    ? (category == DrinkCategory.wine
                        ? AppColors.winePrimary
                        : AppColors.cocktailPrimary)
                    : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _CategoryButton(
                    title: '와인',
                    isSelected: category == DrinkCategory.wine,
                    onTap: () {
                      if (category != DrinkCategory.wine) {
                        ref
                            .read(categoryNotifierProvider.notifier)
                            .toggleCategory();
                      }
                    },
                  ),
                  const SizedBox(width: AppSizes.size16),
                  _CategoryButton(
                    title: '칵테일',
                    isSelected: category == DrinkCategory.cocktail,
                    onTap: () {
                      if (category != DrinkCategory.cocktail) {
                        ref
                            .read(categoryNotifierProvider.notifier)
                            .toggleCategory();
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: category == DrinkCategory.wine
                  ? const WineListScreen()
                  : const CocktailListScreen(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(
              category == DrinkCategory.wine ? '/wines/add' : '/cocktails/add');
        },
        backgroundColor: isDark
            ? (category == DrinkCategory.wine
                ? AppColors.winePrimary
                : AppColors.cocktailPrimary)
            : null,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.size24,
          vertical: AppSizes.size12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? (isDark ? Colors.white : Theme.of(context).primaryColor)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.size24),
          border: Border.all(
            color: isDark ? Colors.white : Theme.of(context).primaryColor,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? (isDark ? Colors.black : Colors.white)
                : (isDark ? Colors.white : Theme.of(context).primaryColor),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
