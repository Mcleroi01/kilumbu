import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/prato_culinario.dart';

class PratoCulinarioException implements Exception {
  final String message;
  PratoCulinarioException(this.message);
  @override
  String toString() => 'PratoCulinarioException: $message';
}

class PratoCulinarioService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('pratos_culinarios');

  // Get all pratos ordered by name
  Future<List<PratoCulinario>> getAllPratos() async {
    try {
      final snapshot = await _collection.orderBy('nome').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PratoCulinario.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw PratoCulinarioException('Erro ao carregar pratos: $e');
    }
  }

  // Get prato by ID
  Future<PratoCulinario> getPratoById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) {
        throw PratoCulinarioException('Prato com id $id não encontrado');
      }
      return PratoCulinario.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
    } catch (e) {
      throw PratoCulinarioException('Erro: ${e.toString()}');
    }
  }

  // Add new prato
  Future<String> addPrato(PratoCulinario prato) async {
    try {
      final docRef = await _collection.add(prato.toJson());
      return docRef.id;
    } catch (e) {
      throw PratoCulinarioException('Erro ao adicionar prato: $e');
    }
  }

  // Update existing prato
  Future<void> updatePrato(String id, PratoCulinario prato) async {
    try {
      await _collection.doc(id).update(prato.toJson());
    } catch (e) {
      throw PratoCulinarioException('Erro ao atualizar prato: $e');
    }
  }

  // Delete prato
  Future<void> deletePrato(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      throw PratoCulinarioException('Erro ao remover prato: $e');
    }
  }

  // Search pratos by name or ingredients
  Future<List<PratoCulinario>> searchPratos(String query) async {
    try {
      final snapshot = await _collection
          .where('nome', isGreaterThanOrEqualTo: query)
          .where('nome', isLessThanOrEqualTo: query + '\uf8ff')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PratoCulinario.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw PratoCulinarioException('Erro ao buscar pratos: $e');
    }
  }

  // Get pratos by region
  Future<List<PratoCulinario>> getPratosByRegiao(String regiao) async {
    try {
      final snapshot = await _collection
          .where('regiao', isEqualTo: regiao)
          .orderBy('nome')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return PratoCulinario.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw PratoCulinarioException('Erro ao buscar pratos por região: $e');
    }
  }
}
