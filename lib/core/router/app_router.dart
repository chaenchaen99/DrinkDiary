import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/screens/home_screen.dart';
import '../../features/wine/screens/wine_list_screen.dart';
import '../../features/wine/screens/wine_detail_screen.dart';
import '../../features/wine/screens/wine_form_screen.dart';
import '../../features/cocktail/screens/cocktail_list_screen.dart';
import '../../features/cocktail/screens/cocktail_detail_screen.dart';
import '../../features/cocktail/screens/cocktail_form_screen.dart';
import '../../features/wine/providers/wine_provider.dart';
import '../../features/cocktail/providers/cocktail_provider.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      // 와인 관련 라우트
      GoRoute(
        path: '/wines',
        builder: (context, state) => const WineListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const WineFormScreen(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final wines = ref.read(wineNotifierProvider).value!;
              final wine =
                  wines.firstWhere((w) => w.id == state.pathParameters['id']);
              return WineDetailScreen(wine: wine);
            },
          ),
          GoRoute(
            path: ':id/edit',
            builder: (context, state) {
              final wines = ref.read(wineNotifierProvider).value!;
              final wine =
                  wines.firstWhere((w) => w.id == state.pathParameters['id']);
              return WineFormScreen(wine: wine);
            },
          ),
        ],
      ),

      // 칵테일 관련 라우트
      GoRoute(
        path: '/cocktails',
        builder: (context, state) => const CocktailListScreen(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const CocktailFormScreen(),
          ),
          GoRoute(
            path: ':id',
            builder: (context, state) {
              final cocktails = ref.read(cocktailNotifierProvider).value!;
              final cocktail = cocktails
                  .firstWhere((c) => c.id == state.pathParameters['id']);
              return CocktailDetailScreen(cocktail: cocktail);
            },
          ),
          GoRoute(
            path: ':id/edit',
            builder: (context, state) {
              final cocktails = ref.read(cocktailNotifierProvider).value!;
              final cocktail = cocktails
                  .firstWhere((c) => c.id == state.pathParameters['id']);
              return CocktailFormScreen(cocktail: cocktail);
            },
          ),
        ],
      ),
    ],
  );
}
