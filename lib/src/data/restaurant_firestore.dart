import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getRestaurantsData() async {
    QuerySnapshot querySnapshot = await _firestore.collection('restaurants').get();

    return querySnapshot.docs.map((document) {
      Map<String, dynamic> documentData = document.data() as Map<String, dynamic>;

      return {
        'name': documentData['name'] ?? '',
        'address': documentData['address'] ?? '',
        'time': documentData['time'] ?? '',
        'image': documentData['image'] ?? [],
      };
    }).toList();
  }

 Future<void> searchRestaurants(String searchText) async {
  try {
    QuerySnapshot querySnapshot = await _firestore.collection('restaurants')
        .where('name', isGreaterThanOrEqualTo: searchText)
        // ignore: prefer_interpolation_to_compose_strings
        .where('name', isLessThan: searchText + 'z')
        .get();

    List<Map<String, dynamic>> searchResult = querySnapshot.docs.map((document) {
      Map<String, dynamic> documentData = document.data() as Map<String, dynamic>;

      return {
        'name': documentData['name'] ?? '',
        'address': documentData['address'] ?? '',
        'time': documentData['time'] ?? '',
        'image': documentData['image'] ?? [],
      };
    }).toList();

    // Search result'ları kullanabilirsiniz, örneğin bu sonuçları bir liste göstermek gibi
    // ignore: avoid_print
    print('Arama Sonuçları: $searchResult');
  } catch (e) {
    // ignore: avoid_print
    print('Arama Hatası: $e');
  }
}

}
