import 'package:drink_diary/features/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
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
      appBar: const HomeAppbar(),
      backgroundColor: isDark
          ? (category == DrinkCategory.wine
              ? AppColors.surface
              : AppColors.inverseSurface)
          : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
        backgroundColor: category.theme.backgroundColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
