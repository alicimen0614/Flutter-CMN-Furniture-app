import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/services/database.dart';
<<<<<<< HEAD
=======
import 'package:cimenfurniture/services/time_convert.dart';
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
import 'package:flutter/material.dart';

class AddCustomerViewModel extends ChangeNotifier {
  final Database _database = Database();
  String collectionPath = "customers";

//Creating a new customer object from the data of the formfields
  Future<void> addNewCustomer(
    String name,
    String surname,
  ) async {
    Customers customer = Customers(
        id: DateTime.now().toIso8601String(),
        name: name,
        surname: surname,
        works: []);

    //Insert the object to Firestore
    await _database.setCustomerData(
        collectionPath: collectionPath, customerAsMap: customer.toMap());
  }
}
