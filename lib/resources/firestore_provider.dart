import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreProvider {
  Firestore _store = Firestore.instance;

  Stream<QuerySnapshot> getItems() {
    return _store.collection('item').snapshots();
  }

  Future<DocumentReference> addItem(Map<String, dynamic> item) {
    return _store.collection('item').add(item);
  }

  void delete(id) {
    _store.collection('item').document(id).delete();
    
  }

  Future<void> updateItem(String id, Map item) {
    return _store.collection('item').document(id).setData(item);
  }
}