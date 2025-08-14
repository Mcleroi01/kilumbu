import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/linguas_nacional.dart';

class LinguaNacionalNotFoundException implements Exception {
  final String message;

  LinguaNacionalNotFoundException(this.message);

  @override
  String toString() => 'LinguaNacionalNotFoundException: $message';
}

class LinguaNacionalService {
  final CollectionReference _collection =
  FirebaseFirestore.instance.collection('linguasNacionais');

  /// 🔄 Récupère toutes les langues nationales (triées par nom)
  Future<List<LinguaNacional>> getAllLinguas() async {
    try {
      final snapshot = await _collection.orderBy('nome').get();

      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LinguaNacional.fromJson(data, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Erreur lors du chargement des langues nationales: $e');
    }
  }

  /// 🔍 Récupère une langue nationale par son ID (numérique)
  Future<LinguaNacional> getLinguaById(int id) async {
    try {
      final snapshot = await _collection.where('id', isEqualTo: id).limit(1).get();

      if (snapshot.docs.isEmpty) {
        throw LinguaNacionalNotFoundException('Langue avec id $id non trouvée');
      }

      final data = snapshot.docs.first.data() as Map<String, dynamic>;
      return LinguaNacional.fromJson(data, snapshot.docs.first.id);
    } catch (e) {
      throw LinguaNacionalNotFoundException('Erreur: $e');
    }
  }
}
