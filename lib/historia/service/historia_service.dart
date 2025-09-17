import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/historia.dart';

class HistoriaNotFoundException implements Exception {
  final String message;
  HistoriaNotFoundException(this.message);
  @override
  String toString() => 'HistoriaNotFoundException: $message';
}

class HistoriaService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('historias');

  // Get all historias ordered by title
  Future<List<Historia>> getAllHistorias() async {
    try {
      final snapshot = await _collection.orderBy('titulo').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Historia.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw Exception('Erro ao carregar histórias: $e');
    }
  }

  // Get historia by ID
  Future<Historia> getHistoriaById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) {
        throw HistoriaNotFoundException('História com id $id não encontrada');
      }
      return Historia.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
    } catch (e) {
      throw HistoriaNotFoundException('Erro: ${e.toString()}');
    }
  }

  // Add new historia
  Future<String> addHistoria(Historia historia) async {
    try {
      final docRef = await _collection.add(historia.toJson());
      return docRef.id;
    } catch (e) {
      throw Exception('Erro ao adicionar história: $e');
    }
  }

  // Update existing historia
  Future<void> updateHistoria(String id, Historia historia) async {
    try {
      await _collection.doc(id).update(historia.toJson());
    } catch (e) {
      throw Exception('Erro ao atualizar história: $e');
    }
  }

  // Delete historia
  Future<void> deleteHistoria(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao remover história: $e');
    }
  }

  // Search historias by title or content
  Future<List<Historia>> searchHistorias(String query) async {
    try {
      final snapshot = await _collection
          .where('titulo', isGreaterThanOrEqualTo: query)
          .where('titulo', isLessThanOrEqualTo: '$query\uf8ff')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Historia.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw Exception('Erro ao buscar histórias: $e');
    }
  }
}
