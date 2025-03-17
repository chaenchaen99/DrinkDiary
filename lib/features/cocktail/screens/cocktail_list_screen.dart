import 'dart:io';
import 'package:drink_diary/features/cocktail/providers/cocktail_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class CocktailListScreen extends ConsumerWidget {
  const CocktailListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cocktailState = ref.watch(cocktailNotifierProvider);

    return Scaffold(
      body: cocktailState.when(
        data: (cocktails) {
          if (cocktails.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.local_bar_outlined,
                    size: AppSizes.size48,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.grey100
                        : AppColors.grey800,
                  ),
                  const SizedBox(height: AppSizes.size16),
                  const Text(
                    '기록된 칵테일이 없습니다.',
                    style: TextStyle(
                      color: AppColors.grey500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSizes.size16),
            itemCount: cocktails.length,
            itemBuilder: (context, index) {
              final cocktail = cocktails[index];
              return Card(
                margin: const EdgeInsets.only(bottom: AppSizes.size16),
                child: ListTile(
                  leading: cocktail.images?.isNotEmpty == true
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(AppSizes.size4),
                          child: Image.file(
                            File(cocktail.images!.first),
                            width: AppSizes.size48,
                            height: AppSizes.size48,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          width: AppSizes.size48,
                          height: AppSizes.size48,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.grey100
                                    : AppColors.grey800,
                            borderRadius: BorderRadius.circular(AppSizes.size4),
                          ),
                          child: const Icon(Icons.local_bar),
                        ),
                  title: Text(cocktail.name),
                  subtitle: Text(cocktail.base ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: AppSizes.size16),
                      const SizedBox(width: AppSizes.size4),
                      Text(cocktail.rating.toString()),
                    ],
                  ),
                  onTap: () {
                    // TODO: 칵테일 상세 화면으로 이동
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('에러가 발생했습니다: $error'),
        ),
      ),
    );
  }
}
