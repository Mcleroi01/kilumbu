import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/parcnaturel.dart';

class ParcNaturelService {
  final CollectionReference _parcsCollection =
  FirebaseFirestore.instance.collection('parcs');

  Future<List<ParcNaturel>> getAllParcs() async {
    final querySnapshot = await _parcsCollection.orderBy('nom').get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return ParcNaturel(
        id: data['id']?? 0,
        nom: data['nom']?? '',
        description: data['description']?? '',
        localisation: data['localisation']?? '',
        superficie: data['superficie']?? '',
        dateCreation: data['dateCreation'] ?? '',
        images: List<String>.from(data['images'] ?? []),
        especesProtegees: List<String>.from(data['especesProtegees'] ?? []),
        patrimoineUnesco: data['patrimoineUnesco'] ?? false,
        climat: data['climat'] ?? '',
        typeVegetation: data['typeVegetation']?? '',
        activitesDisponibles: data['activitesDisponibles']?? '',
        acces: data['acces'] ?? '',
        conseilsVisite: data['conseilsVisite']?? '',
        siteWeb: data['siteWeb'] ?? '',
        imagePrincipale: data['imagePrincipale']?? '',
      );
    }).toList();
  }

  Future<ParcNaturel> getParcNaturelById(int id) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('parcs')
        .where('id', isEqualTo: id)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final data = querySnapshot.docs.first.data();
      return ParcNaturel.fromJson(data);
    } else {
      throw Exception("Parque não encontrado");
    }
  }

}
