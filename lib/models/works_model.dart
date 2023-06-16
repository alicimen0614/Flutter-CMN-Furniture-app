import 'package:cloud_firestore/cloud_firestore.dart';

class Works {
  final String id;
  final int price;
  final Timestamp dateOfTakingTheWork;
  final Timestamp estimatedDeliveryDate;
  final int deposit;
  final int earning;
  final String address;
  final int cost;
  final String notes;

  Works(
      {required this.id,
      required this.price,
      required this.dateOfTakingTheWork,
      required this.estimatedDeliveryDate,
      required this.deposit,
      this.earning = 0,
      required this.address,
      this.cost = 0,
      required this.notes});

  Map<String, dynamic> toMap() => {
        'id': id,
        'price': price,
        'dateOfTakingTheWork': dateOfTakingTheWork,
        'estimatedDeliveryDate': estimatedDeliveryDate,
        'deposit': deposit,
        'earning': earning,
        'address': address,
        'cost': cost,
        'notes': notes
      };

  factory Works.fromMap(Map map) {
    return Works(
        id: map['id'],
        address: map['address'],
        cost: map['cost'],
        dateOfTakingTheWork: map['dateOfTakingTheWork'],
        deposit: map['deposit'],
        earning: map['earning'],
        estimatedDeliveryDate: map['estimatedDeliveryDate'],
        price: map['price'],
        notes: map['notes']);
  }
}
