import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../data/models/drinkbar.dart';

class DrinkBarRepository {
  final FirebaseFirestore _firestore;

  DrinkBarRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> addDrinkBar(DrinkBar bar) async {
    try {
      // Firestore에 저장
      await _firestore.collection('bars').doc(bar.id).set(bar.toJson());
    } catch (e) {
      throw Exception('Failed to add bar: $e');
    }
  }

  Stream<List<DrinkBar>> watchBars() {
    return _firestore
        .collection('bars')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => DrinkBar.fromJson(doc.data())).toList());
  }
}
