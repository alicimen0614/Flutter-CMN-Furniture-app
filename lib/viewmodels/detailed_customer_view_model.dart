import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/services/database.dart';
import 'package:cimenfurniture/services/time_convert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailedCustomerViewModel extends ChangeNotifier {
  final Database _database = Database();
  String collectionPath = "customers";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Creating a new customer object from the data of the formfields
  Future<void> updateNewCustomer(
      String name, String surname, Customers customer) async {
    Customers newcustomer = Customers(
        id: customer.id, name: name, surname: surname, works: customer.works);

    //Insert the object to Firestore
    await _database.setCustomerData(
        collectionPath: collectionPath, customerAsMap: newcustomer.toMap());
  }

  Stream<DocumentSnapshot<Object?>> getNewCustomer(String docId) {
    CollectionReference customersRef = _firestore.collection(collectionPath);
    var customerRef = customersRef.doc(docId);

    return customerRef.snapshots();
  }
}
