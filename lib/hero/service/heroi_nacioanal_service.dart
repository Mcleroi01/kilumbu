import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/heroi_nacional.dart';

class HeroiNacionalNotFoundException implements Exception {
  final String message;
  HeroiNacionalNotFoundException(this.message);

  @override
  String toString() => 'HeroiNacionalNotFoundException: $message';
}

class HeroiNacionalService {
  final CollectionReference _collection =
  FirebaseFirestore.instance.collection('heroes');

  Future<List<HeroiNacional>> getAllHerois({bool? reconhecidoOficialmente}) async {
    try {
      Query query = _collection;

      if (reconhecidoOficialmente != null) {
        query = query.where('reconhecidoOficialmente', isEqualTo: reconhecidoOficialmente);
      }

      final snapshot = await query.orderBy('nome').get();
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return HeroiNacional.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Erreur de chargement des héros: $e');
    }
  }

  // 🔍 Récupère un héros par ID
  Future<HeroiNacional> getHeroiById(int id) async {
    try {
      final snapshot = await _collection.where('id', isEqualTo: id).limit(1).get();

      if (snapshot.docs.isEmpty) {
        throw HeroiNacionalNotFoundException('Herói com id $id não encontrado');
      }

      final data = snapshot.docs.first.data() as Map<String, dynamic>;
      return HeroiNacional.fromJson(data);
    } catch (e) {
      throw HeroiNacionalNotFoundException('Erro: $e');
    }
  }
}
