import 'package:cloud_firestore/cloud_firestore.dart';

class Customers {
  final String id;
  final String name;
  final String surname;
  final int price;
  final Timestamp dateOfTakingTheWork;
  final Timestamp estimatedDeliveryDate;
  final int deposit;
  final int earning;
  final String address;
  final int cost;

  Customers(
      {required this.id,
      required this.name,
      required this.surname,
      required this.price,
      required this.dateOfTakingTheWork,
      required this.estimatedDeliveryDate,
      required this.deposit,
      this.earning = 0,
      required this.address,
      this.cost = 0});

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'surname': surname,
        'price': price,
        'dateOfTakingTheWork': dateOfTakingTheWork,
        'estimatedDeliveryDate': estimatedDeliveryDate,
        'deposit': deposit,
        'earning': earning,
        'address': address,
        'cost': cost
      };

  factory Customers.fromMap(Map map) {
    return Customers(
        id: map['id'],
        address: map['address'],
        cost: map['cost'],
        dateOfTakingTheWork: map['dateOfTakingTheWork'],
        deposit: map['deposit'],
        earning: map['earning'],
        estimatedDeliveryDate: map['estimatedDeliveryDate'],
        name: map['name'],
        price: map['price'],
        surname: map['surname']);
  }
}
