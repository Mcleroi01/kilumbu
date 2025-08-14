import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import '../model/local_turistico.dart';

class LocalTuristicoException implements Exception {
  final String message;
  LocalTuristicoException(this.message);
  @override
  String toString() => 'LocalTuristicoException: $message';
}

class LocalTuristicoService {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('locais_turisticos');
  // GeoFirePoint will be used for geoqueries

  // Get all locais turísticos
  Future<List<LocalTuristico>> getAllLocais() async {
    try {
      final snapshot = await _collection.orderBy('nome').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LocalTuristico.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw LocalTuristicoException('Erro ao carregar locais turísticos: $e');
    }
  }

  // Get local by ID
  Future<LocalTuristico> getLocalById(String id) async {
    try {
      final doc = await _collection.doc(id).get();
      if (!doc.exists) {
        throw LocalTuristicoException('Local turístico com id $id não encontrado');
      }
      return LocalTuristico.fromJson({...doc.data() as Map<String, dynamic>, 'id': doc.id});
    } catch (e) {
      throw LocalTuristicoException('Erro: ${e.toString()}');
    }
  }

  // Get locais by type
  Future<List<LocalTuristico>> getLocaisByType(String tipo) async {
    try {
      final snapshot = await _collection
          .where('tipo', isEqualTo: tipo)
          .orderBy('nome')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LocalTuristico.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw LocalTuristicoException('Erro ao buscar locais por tipo: $e');
    }
  }

  // Get locais near a location
  Future<List<LocalTuristico>> getLocaisProximos(
      double latitude, double longitude, double radiusInKm) async {
    try {
      // Create a GeoFirePoint
      final geoPoint = GeoPoint(latitude, longitude);
      final geoFirePoint = GeoFirePoint(geoPoint);
      
      // Query radius in kilometers
      final double radius = radiusInKm;
      
      // Create a query reference
      final queryRef = _collection
          .where('posicao.geohash', isGreaterThanOrEqualTo: geoFirePoint.geohash.substring(0, 5))
          .where('posicao.geohash', isLessThanOrEqualTo: '${geoFirePoint.geohash.substring(0, 5)}~');
      
      // Get the documents
      final snapshot = await queryRef.get();
      
      // Filter by distance
      final locais = <LocalTuristico>[];
      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        if (data['posicao'] != null) {
          final posicao = data['posicao'] as Map<String, dynamic>;
          if (posicao['geopoint'] != null) {
            final docPoint = posicao['geopoint'] as GeoPoint;
            final distance = _calculateDistance(
              latitude, 
              longitude, 
              docPoint.latitude, 
              docPoint.longitude
            );
            
            if (distance <= radius) {
              locais.add(LocalTuristico.fromJson({...data, 'id': doc.id}));
            }
          }
        }
      }
      
      return locais;
    } catch (e) {
      throw LocalTuristicoException('Erro ao buscar locais próximos: $e');
    }
  }
  
  // Helper function to calculate distance between two points in kilometers
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;  // Math.PI / 180
    final a = 0.5 - 
        cos((lat2 - lat1) * p) / 2 + 
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }

  // Add new local
  Future<String> addLocal(LocalTuristico local) async {
    try {
      final data = local.toJson()..remove('id');
      
      // Add geofire data if coordinates are available
      if (local.endereco.coordenadas.latitude != 0 && 
          local.endereco.coordenadas.longitude != 0) {
        final geoPoint = GeoFirePoint(
          GeoPoint(
            local.endereco.coordenadas.latitude,
            local.endereco.coordenadas.longitude,
          ),
        );
        data['posicao'] = geoPoint.data['posicao'];
      }
      
      data['createdAt'] = FieldValue.serverTimestamp();
      data['updatedAt'] = FieldValue.serverTimestamp();
      
      final docRef = await _collection.add(data);
      return docRef.id;
    } catch (e) {
      throw LocalTuristicoException('Erro ao adicionar local turístico: $e');
    }
  }

  // Update existing local
  Future<void> updateLocal(String id, LocalTuristico local) async {
    try {
      final data = local.toJson()..remove('id');
      
      // Update geofire data if coordinates are available
      if (local.endereco.coordenadas.latitude != 0 && 
          local.endereco.coordenadas.longitude != 0) {
        final geoPoint = GeoFirePoint(
          GeoPoint(
            local.endereco.coordenadas.latitude,
            local.endereco.coordenadas.longitude,
          ),
        );
        data['posicao'] = geoPoint.data['posicao'];
      }
      
      data['updatedAt'] = FieldValue.serverTimestamp();
      
      await _collection.doc(id).update(data);
    } catch (e) {
      throw LocalTuristicoException('Erro ao atualizar local turístico: $e');
    }
  }

  // Delete local
  Future<void> deleteLocal(String id) async {
    try {
      await _collection.doc(id).delete();
    } catch (e) {
      throw LocalTuristicoException('Erro ao remover local turístico: $e');
    }
  }

  // Search locais by name or description
  Future<List<LocalTuristico>> searchLocais(String query) async {
    try {
      final snapshot = await _collection
          .where('nome', isGreaterThanOrEqualTo: query)
          .where('nome', isLessThanOrEqualTo: query + '\uf8ff')
          .orderBy('nome')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LocalTuristico.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw LocalTuristicoException('Erro ao buscar locais: $e');
    }
  }

  // Get locais by tag
  Future<List<LocalTuristico>> getLocaisByTag(String tag) async {
    try {
      final snapshot = await _collection
          .where('tags', arrayContains: tag.toLowerCase())
          .orderBy('nome')
          .get();
          
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return LocalTuristico.fromJson({...data, 'id': doc.id});
      }).toList();
    } catch (e) {
      throw LocalTuristicoException('Erro ao buscar locais por tag: $e');
    }
  }
}
