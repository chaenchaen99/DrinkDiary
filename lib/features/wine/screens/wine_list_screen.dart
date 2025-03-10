import 'dart:io';
import 'package:drink_diary/features/wine/providers/wine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';

class WineListScreen extends ConsumerWidget {
  const WineListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wineState = ref.watch(wineNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('와인 다이어리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: 와인 추가 화면으로 이동
            },
          ),
        ],
      ),
      body: wineState.when(
        data: (wines) {
          if (wines.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wine_bar_outlined,
                    size: AppSizes.size48,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.lightGrey
                        : AppColors.darkGrey,
                  ),
                  const SizedBox(height: AppSizes.size16),
                  Text(
                    '기록된 와인이 없습니다.',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSizes.size16),
            itemCount: wines.length,
            itemBuilder: (context, index) {
              final wine = wines[index];
              return Card(
                margin: const EdgeInsets.only(bottom: AppSizes.size16),
                child: ListTile(
                  leading: wine.images?.isNotEmpty == true
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(AppSizes.size4),
                          child: Image.file(
                            File(wine.images!.first),
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
                                    ? AppColors.lightGrey
                                    : AppColors.darkGrey,
                            borderRadius: BorderRadius.circular(AppSizes.size4),
                          ),
                          child: const Icon(Icons.wine_bar),
                        ),
                  title: Text(wine.name),
                  subtitle: Text(wine.variety),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: AppSizes.size16),
                      const SizedBox(width: AppSizes.size4),
                      Text(wine.rating.toString()),
                    ],
                  ),
                  onTap: () {
                    // TODO: 와인 상세 화면으로 이동
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
