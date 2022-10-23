import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/services/database.dart';
import 'package:cimenfurniture/services/time_convert.dart';
import 'package:flutter/material.dart';

class AddCustomerViewModel extends ChangeNotifier {
  final Database _database = Database();
  String collectionPath = "customers";

//Creating a new customer object from the data of the formfields
  Future<void> addNewCustomer(
      String name,
      String surname,
      int price,
      DateTime dateOfTakingTheWork,
      DateTime estimatedDeliveryDate,
      int deposit,
      int earning,
      String address,
      int cost) async {
    Customers customer = Customers(
        id: DateTime.now().toIso8601String(),
        name: name,
        surname: surname,
        price: price,
        dateOfTakingTheWork:
            TimeConvert.datetimeToTimestamp(dateOfTakingTheWork),
        estimatedDeliveryDate:
            TimeConvert.datetimeToTimestamp(estimatedDeliveryDate),
        deposit: deposit,
        address: address);

    //Insert the object to Firestore
    await _database.setCustomerData(
        collectionPath: collectionPath, customerAsMap: customer.toMap());
  }
}
