import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../home/providers/category_provider.dart';
import '../../home/screens/home_screen.dart';
import '../../settings/screens/settings_screen.dart';
import '../../community/screens/community_screen.dart';
import '../../map/screens/map_screen.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final category = ref.watch(categoryNotifierProvider);

    final screens = [
      const HomeScreen(),
      const MapScreen(),
      const CommunityScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 100.0,
        color: category.theme.backgroundColor,
        child: NavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          onDestinationSelected: (index) {
            ref.read(selectedIndexProvider.notifier).state = index;
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.home, color: Colors.white),
              label: '홈',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.map, color: Colors.white),
              label: '지도',
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline, color: Colors.white),
              selectedIcon: Icon(Icons.people, color: Colors.white),
              label: '커뮤니티',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined, color: Colors.white),
              selectedIcon: Icon(Icons.settings, color: Colors.white),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
}
