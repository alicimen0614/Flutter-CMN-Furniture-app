import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/customers_model.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getCustomerListFromApi(
      String collectionPath) {
    return _firestore.collection(collectionPath).snapshots();
  }

  //Deleting a data in Firebase.
  Future<void> deleteDocument(
      {required String referencePath, required String id}) async {
    await _firestore.collection(referencePath).doc(id).delete();
    print("database girdi");
  }

  //inserting and updating a data in Firebase.

  Future<void> setCustomerData(
      {required String collectionPath,
      required Map<String, dynamic> customerAsMap}) async {
    await _firestore
        .collection(collectionPath)
        .doc(Customers.fromMap(customerAsMap).id)
        .set(customerAsMap);
  }

  Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getCustomerWorks(
      {required String collectionPath, required String id}) async {
    return await _firestore
        .collection(collectionPath)
        .doc(id)
        .get()
        .then((value) => value.data()!['works']);
  }
}
