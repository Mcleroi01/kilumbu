import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/feriado.dart';

class FeriadoException implements Exception {
  final String message;
  FeriadoException(this.message);
  @override
  String toString() => 'FeriadoException: $message';
}

class FeriadoService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('feriados');

  // Get all feriados ordered by date
  Future<List<Feriado>> getAllFeriados() async {
    try {
      final snapshot = await _collection.orderBy('data').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Feriado.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw FeriadoException('Erro ao carregar feriados: $e');
    }
  }

  // Get feriado by ID
  Future<Feriado> getFeriadoById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) {
        throw FeriadoException('Feriado com id $id não encontrado');
      }
      return Feriado.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
    } catch (e) {
      throw FeriadoException('Erro: ${e.toString()}');
    }
  }

  // Get upcoming feriados
  Future<List<Feriado>> getProximosFeriados({int limit = 5}) async {
    try {
      final now = DateTime.now();
      final snapshot = await _collection
          .where('data', isGreaterThanOrEqualTo: now.toIso8601String())
          .orderBy('data')
          .limit(limit)
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Feriado.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw FeriadoException('Erro ao buscar próximos feriados: $e');
    }
  }

  // Get feriados by month
  Future<List<Feriado>> getFeriadosPorMes(int month) async {
    try {
      final startDate = DateTime(DateTime.now().year, month, 1);
      final endDate = DateTime(DateTime.now().year, month + 1, 0);
      
      final snapshot = await _collection
          .where('data', isGreaterThanOrEqualTo: startDate.toIso8601String())
          .where('data', isLessThanOrEqualTo: endDate.toIso8601String())
          .orderBy('data')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Feriado.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw FeriadoException('Erro ao buscar feriados do mês: $e');
    }
  }

  // Add new feriado
  Future<String> addFeriado(Feriado feriado) async {
    try {
      final data = feriado.toJson()..remove('id');
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();
      
      final docRef = await _collection.add(data);
      return docRef.id;
    } catch (e) {
      throw FeriadoException('Erro ao adicionar feriado: $e');
    }
  }

  // Update existing feriado
  Future<void> updateFeriado(String id, Feriado feriado) async {
    try {
      final data = feriado.toJson()..remove('id');
      data['updatedAt'] = FieldValue.serverTimestamp();
      
      await _collection.doc(id).update(data);
    } catch (e) {
      throw FeriadoException('Erro ao atualizar feriado: $e');
    }
  }

  // Delete feriado
  Future<void> deleteFeriado(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      throw FeriadoException('Erro ao remover feriado: $e');
    }
  }

  // Search feriados by name
  Future<List<Feriado>> searchFeriados(String query) async {
    try {
      final snapshot = await _collection
          .where('nome', isGreaterThanOrEqualTo: query)
          .where('nome', isLessThanOrEqualTo: query + '\uf8ff')
          .orderBy('nome')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Feriado.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw FeriadoException('Erro ao buscar feriados: $e');
    }
  }
}
