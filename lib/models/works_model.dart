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
<<<<<<< HEAD
  final String notes;
=======
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165

  Works(
      {required this.id,
      required this.price,
      required this.dateOfTakingTheWork,
      required this.estimatedDeliveryDate,
      required this.deposit,
      this.earning = 0,
      required this.address,
<<<<<<< HEAD
      this.cost = 0,
      required this.notes});
=======
      this.cost = 0});
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165

  Map<String, dynamic> toMap() => {
        'id': id,
        'price': price,
        'dateOfTakingTheWork': dateOfTakingTheWork,
        'estimatedDeliveryDate': estimatedDeliveryDate,
        'deposit': deposit,
        'earning': earning,
        'address': address,
<<<<<<< HEAD
        'cost': cost,
        'notes': notes
=======
        'cost': cost
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
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
<<<<<<< HEAD
        price: map['price'],
        notes: map['notes']);
=======
        price: map['price']);
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
  }
}
