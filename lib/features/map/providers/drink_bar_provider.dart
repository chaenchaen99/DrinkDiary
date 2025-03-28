import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../repositories/drink_bar_repository.dart';
import '../../../data/models/drinkbar.dart';

part 'drink_bar_provider.g.dart';

@riverpod
class DrinkBarNotifier extends _$DrinkBarNotifier {
  late final DrinkBarRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = DrinkBarRepository();
  }

  Future<void> addDrinkBar(DrinkBar bar) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await _repository.addDrinkBar(bar);
    });
  }

  Stream<List<DrinkBar>> watchBars() {
    return _repository.watchBars();
  }
}
