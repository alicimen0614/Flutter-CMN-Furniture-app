import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/services/database.dart';
<<<<<<< HEAD
=======
import 'package:cimenfurniture/services/time_convert.dart';
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
import 'package:flutter/material.dart';

import '../models/works_model.dart';

class AddWorkViewModel extends ChangeNotifier {
  final Database _database = Database();
  String collectionPath = "customers";

//Creating a new customer object from the data of the formfields
  Future<void> addNewWork(
      {required List<Works> workList, required Customers customer}) async {
    Customers newCustomer = Customers(
        name: customer.name,
        surname: customer.surname,
        id: customer.id,
        works: workList);

    //Insert the object to Firestore
    await _database.setCustomerData(
        collectionPath: collectionPath, customerAsMap: newCustomer.toMap());
  }
}
