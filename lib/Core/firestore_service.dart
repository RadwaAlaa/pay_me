import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<dynamic> getCollection(String collectionName) async {
    return await _db.collection(collectionName).get();
  }

  Future<void> addDocument(
      String collectionName, Map<String, dynamic> data) async {
    await _db.collection(collectionName).add(data);
  }

  Future<void> updateDocument(String collectionName, String documentId,
      Map<String, dynamic> data) async {
    await _db.collection(collectionName).doc(documentId).update(data);
  }
}
