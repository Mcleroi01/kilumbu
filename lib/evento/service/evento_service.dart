import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/evento.dart';

class EventoException implements Exception {
  final String message;
  EventoException(this.message);
  @override
  String toString() => 'EventoException: $message';
}

class EventoService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('eventos');

  // Get all active events, ordered by start date
  Future<List<Evento>> getEventosAtivos() async {
    try {
      final snapshot = await _collection
          .where('ativo', isEqualTo: true)
          .orderBy('dataInicio')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Evento.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw EventoException('Erro ao carregar eventos: $e');
    }
  }

  // Get upcoming events (starting from today)
  Future<List<Evento>> getProximosEventos({int limit = 10}) async {
    try {
      final now = DateTime.now();
      final snapshot = await _collection
          .where('dataInicio', isGreaterThanOrEqualTo: now)
          .where('ativo', isEqualTo: true)
          .orderBy('dataInicio')
          .limit(limit)
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Evento.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw EventoException('Erro ao buscar próximos eventos: $e');
    }
  }

  // Get events by type
  Future<List<Evento>> getEventosPorTipo(String tipo) async {
    try {
      final snapshot = await _collection
          .where('tipo', isEqualTo: tipo)
          .where('ativo', isEqualTo: true)
          .orderBy('dataInicio')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Evento.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw EventoException('Erro ao buscar eventos por tipo: $e');
    }
  }

  // Get events happening today
  Future<List<Evento>> getEventosHoje() async {
    try {
      final now = DateTime.now();
      final startOfDay = DateTime(now.year, now.month, now.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));
      
      final snapshot = await _collection
          .where('dataInicio', isGreaterThanOrEqualTo: startOfDay)
          .where('dataInicio', isLessThan: endOfDay)
          .where('ativo', isEqualTo: true)
          .orderBy('dataInicio')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Evento.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw EventoException('Erro ao buscar eventos de hoje: $e');
    }
  }

  // Get events by date range
  Future<List<Evento>> getEventosPorPeriodo(DateTime inicio, DateTime fim) async {
    try {
      final snapshot = await _collection
          .where('dataInicio', isGreaterThanOrEqualTo: inicio)
          .where('dataInicio', isLessThanOrEqualTo: fim)
          .where('ativo', isEqualTo: true)
          .orderBy('dataInicio')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Evento.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw EventoException('Erro ao buscar eventos por período: $e');
    }
  }

  // Get event by ID
  Future<Evento> getEventoById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) {
        throw EventoException('Evento com id $id não encontrado');
      }
      return Evento.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
    } catch (e) {
      throw EventoException('Erro ao buscar evento: ${e.toString()}');
    }
  }

  // Add new event
  Future<String> addEvento(Evento evento) async {
    try {
      final data = evento.toJson()..remove('id');
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();
      
      final docRef = await _collection.add(data);
      return docRef.id;
    } catch (e) {
      throw EventoException('Erro ao adicionar evento: $e');
    }
  }

  // Update existing event
  Future<void> updateEvento(String id, Evento evento) async {
    try {
      final data = evento.toJson()..remove('id');
      data['updatedAt'] = FieldValue.serverTimestamp();
      
      await _collection.doc(id).update(data);
    } catch (e) {
      throw EventoException('Erro ao atualizar evento: $e');
    }
  }

  // Delete event (soft delete)
  Future<void> deleteEvento(String id) async {
    try {
      await _collection.doc(id).update({
        'ativo': false,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw EventoException('Erro ao remover evento: $e');
    }
  }

  // Search events by title, description, or tags
  Future<List<Evento>> searchEventos(String query) async {
    try {
      // First search by title
      final titleSnapshot = await _collection
          .where('titulo', isGreaterThanOrEqualTo: query)
          .where('titulo', isLessThanOrEqualTo: '$query\uf8ff')
          .where('ativo', isEqualTo: true)
          .orderBy('titulo')
          .get();
          
      // Then search by description
      final descSnapshot = await _collection
          .where('descricao', isGreaterThanOrEqualTo: query)
          .where('descricao', isLessThanOrEqualTo: '$query\uf8ff')
          .where('ativo', isEqualTo: true)
          .orderBy('descricao')
          .get();
          
      // Then search by tags (array contains)
      final tagsSnapshot = await _collection
          .where('tags', arrayContains: query.toLowerCase())
          .where('ativo', isEqualTo: true)
          .get();
          
      // Combine and deduplicate results
      final allDocs = {}
        ..addEntries(titleSnapshot.docs.map((d) => MapEntry(d.id, d)))
        ..addEntries(descSnapshot.docs.map((d) => MapEntry(d.id, d)))
        ..addEntries(tagsSnapshot.docs.map((d) => MapEntry(d.id, d)));
        
      return allDocs.values.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Evento.fromJson({...data, 'id': doc.id});
      }).toList()
        ..sort((a, b) => a.dataInicio.compareTo(b.dataInicio));
    } catch (e) {
      throw EventoException('Erro ao buscar eventos: $e');
    }
  }

  // Get events by location (city or venue name)
  Future<List<Evento>> getEventosPorLocal(String local) async {
    try {
      // Search by venue name
      final localSnapshot = await _collection
          .where('local.nome', isEqualTo: local)
          .where('ativo', isEqualTo: true)
          .orderBy('dataInicio')
          .get();
          
      // Search by city
      final cidadeSnapshot = await _collection
          .where('local.cidade', isEqualTo: local)
          .where('ativo', isEqualTo: true)
          .orderBy('dataInicio')
          .get();
          
      // Combine and deduplicate results
      final allDocs = {}
        ..addEntries(localSnapshot.docs.map((d) => MapEntry(d.id, d)))
        ..addEntries(cidadeSnapshot.docs.map((d) => MapEntry(d.id, d)));
        
      return allDocs.values.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Evento.fromJson({...data, 'id': doc.id});
      }).toList()
        ..sort((a, b) => a.dataInicio.compareTo(b.dataInicio));
    } catch (e) {
      throw EventoException('Erro ao buscar eventos por local: $e');
    }
  }
}
