import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CustomersPageModel extends ChangeNotifier {
  final Database _database = Database();
  String customersRef = 'customers';

  Stream<List<Customers>> getCustomerList() {
    /// stream<QuerySnapshot> --> Stream<List<DocumentSnapshot>>

    Stream<List<DocumentSnapshot>> streamListDocument = _database
        .getCustomerListFromApi(customersRef)
        .map((querySnapshot) => querySnapshot.docs);

    ///Stream<List<DocumentSnapshot>> --> Stream<List<Book>>
    Stream<List<Customers>> streamListCustomer = streamListDocument.map(
        (listOfDocSnap) => listOfDocSnap
            .map((docSnap) =>
                Customers.fromMap(docSnap.data() as Map<String, dynamic>))
            .toList());

    return streamListCustomer;
  }

  Future<void> deleteCustomer(Customers customer) async {
    await _database.deleteDocument(
        referencePath: customersRef, id: customer.id);
  }
}
