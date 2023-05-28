import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/models/works_model.dart';
import 'package:cimenfurniture/services/database.dart';
import 'package:cimenfurniture/services/time_convert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailedWorkViewModel extends ChangeNotifier {
  final Database _database = Database();
  String collectionPath = "customers";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//Creating a new customer object from the data of the formfields
  Future<void> updateNewWork(
      Works updatedWorks, Customers customer, Works unupdatedWorks) async {
    int indexOfUnUpdatedWork = customer.works.indexOf(unupdatedWorks);
    customer.works.removeAt(indexOfUnUpdatedWork);
    customer.works.insert(indexOfUnUpdatedWork, updatedWorks);

    //Insert the object to Firestore
    await _database.setCustomerData(
        collectionPath: collectionPath, customerAsMap: customer.toMap());
  }

  Future<void> deleteWork(
      {required Customers customer, required Works unupdatedWorks}) async {
    int indexOfUnUpdatedWork = customer.works.indexOf(unupdatedWorks);
    customer.works.removeAt(indexOfUnUpdatedWork);

    await _database.setCustomerData(
        collectionPath: collectionPath, customerAsMap: customer.toMap());
  }
}
