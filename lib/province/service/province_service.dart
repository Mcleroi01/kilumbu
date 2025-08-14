import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/province.dart';

class ProvinceNotFoundException implements Exception {
  final String message;

  ProvinceNotFoundException(this.message);

  @override
  String toString() => 'ProvinceNotFoundException: $message';
}

class ProvinceService {
  final CollectionReference _collection =
  FirebaseFirestore.instance.collection('provincias');

  // 🔄 Récupère toutes les provinces depuis Firebase
  Future<List<Province>> getAllProvinces() async {
    try {
      final snapshot = await _collection.orderBy('nom').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Province.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des provinces: $e');
    }
  }

  // 🔍 Récupère une province par son ID
  Future<Province> getProvinceById(int id) async {
    try {
      final snapshot = await _collection
          .where('id', isEqualTo: id.toString()) // ou id.toString()
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw ProvinceNotFoundException('Province avec id $id non trouvée');
      }

      final data = snapshot.docs.first.data() as Map<String, dynamic>;
      return Province.fromJson(data);
    } catch (e) {
      throw ProvinceNotFoundException('Erreur: ${e.toString()}');
    }
  }

}
