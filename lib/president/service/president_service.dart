import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/president.dart';

class PresidentService {
  final CollectionReference _collection =
  FirebaseFirestore.instance.collection('presidents');

  Future<List<President>> getAllPresidents() async {
    final snapshot = await _collection.orderBy('id').get();
    return snapshot.docs
        .map((doc) => President.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<President> getPresidentById(int id) async {
    final snapshot =
    await _collection.where('id', isEqualTo: id.toString()).limit(1).get();
    if (snapshot.docs.isEmpty) {
      throw Exception('President com id $id não encontrado.');
    }
    return President.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
  }
}
