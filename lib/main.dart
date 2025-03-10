import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'data/models/cocktail.dart';
import 'data/models/wine.dart';

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

  runApp(
    const ProviderScope(
      child: DrinkDiaryApp(),
    ),
  );
}

class DrinkDiaryApp extends ConsumerWidget {
  const DrinkDiaryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Drink Diary',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
