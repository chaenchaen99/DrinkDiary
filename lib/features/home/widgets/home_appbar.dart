import 'package:drink_diary/features/cocktail/providers/cocktail_provider.dart';
import 'package:drink_diary/features/home/providers/category_provider.dart';
import 'package:drink_diary/features/wine/providers/wine_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_sizes.dart';
import '../../../shared/widgets/custom_search_bar.dart';

class HomeAppbar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  ConsumerState<HomeAppbar> createState() => _HomeAppbarState();

  @override
  Size get preferredSize => const Size.fromHeight(44);
}

class _HomeAppbarState extends ConsumerState<HomeAppbar> {
  late bool _isSearch;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _isSearch = false;
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  void _showSearchAppBar(BuildContext context) {
    setState(() {
      _isSearch = true;
    });
  }

  void _hideSearchAppBar(BuildContext context) {
    setState(() {
      _isSearch = false;
      _searchController.clear();
    });
    ref.read(wineNotifierProvider.notifier).build();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final category = ref.watch(categoryNotifierProvider);
      return AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: category.theme.backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          leading: SizedBox(
            width: 32, // 원하는 너비 설정
            height: 32, // 원하는 높이 설정
            child: Image.asset(
              'assets/images/logo_4.png',
              fit: BoxFit.contain, // 이미지 비율을 유지하며 크기 조정
            ),
          ),
          title: _isSearch
              ? SearchInputTextfield(
                  controller: _searchController,
                  onSubmit: (value) {
                    if (value.isNotEmpty && value != '') {
                      if (category.isWine) {
                        ref
                            .read(wineNotifierProvider.notifier)
                            .setSearchQuery(value);
                      } else {
                        ref
                            .read(cocktailNotifierProvider.notifier)
                            .setSearchQuery(value);
                      }
                    }
                  },
                  onClose: () => _hideSearchAppBar(context),
                )
              : AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(AppSizes.radius16),
                    ),
                    color: category.theme.containerColor,
                  ),
                  child: SizedBox(
                    height: 32,
                    width: 144,
                    child: DefaultTabController(
                      initialIndex: category.index,
                      length: DrinkCategory.values.length,
                      child: TabBar(
                        onTap: (index) => ref
                            .read(categoryNotifierProvider.notifier)
                            .changeIndex(index),
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorWeight: 0,
                        dividerHeight: 0,
                        labelPadding:
                            const EdgeInsets.only(left: 12, right: 12),
                        labelColor: category.theme.labelColor,
                        dividerColor: Colors.transparent,
                        labelStyle: Theme.of(context).textTheme.titleMedium,
                        unselectedLabelColor:
                            category.theme.unselectedLabelColor,
                        unselectedLabelStyle:
                            Theme.of(context).textTheme.titleMedium,
                        overlayColor:
                            WidgetStateProperty.all(Colors.transparent),
                        indicator: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(AppSizes.radius16),
                          ),
                          color: category.theme.indicatorColor,
                        ),
                        tabs: List.generate(
                          DrinkCategory.values.length,
                          (index) => Tab(
                            text: DrinkCategory.values[index].toName,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          actions: [
            _isSearch
                ? const SizedBox.shrink()
                : GestureDetector(
                    onTap: () => _showSearchAppBar(context),
                    child: Container(
                      margin: const EdgeInsets.only(right: 16),
                      width: 32,
                      height: 32,
                      child: const Icon(Icons.search),
                    ),
                  )
          ],
        ),
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);
}
