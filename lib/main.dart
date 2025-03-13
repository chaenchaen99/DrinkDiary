import 'package:drink_diary/features/wine/screens/wine_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'features/main/screens/main_screen.dart';
import 'data/models/cocktail.dart';
import 'data/models/wine.dart';
import 'features/wine/screens/wine_detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive 초기화
  await Hive.initFlutter();

  // Hive 어댑터 등록
  Hive.registerAdapter(WineAdapter());
  Hive.registerAdapter(CocktailAdapter());

  // Hive 박스 열기
  await Hive.openBox<Wine>('wines');
  await Hive.openBox<Cocktail>('cocktails');

  runApp(const ProviderScope(child: MyApp()));
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/wines/add',
      builder: (context, state) => const WineFormScreen(),
    ),
    GoRoute(
      path: '/wines/:id',
      builder: (context, state) => WineDetailScreen(
        id: state.pathParameters['id']!,
      ),
    ),
  ],
  debugLogDiagnostics: true,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Drink Diary',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: _router,
    );
  }
}
