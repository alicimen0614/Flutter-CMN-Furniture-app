import 'dart:ffi';

import 'package:cimenfurniture/models/works_model.dart';

class Customers {
  final String id;
  final String name;
  final String surname;
  final List<Works> works;
  final bool isDone;

  Customers(
      {required this.id,
      required this.name,
      required this.surname,
      this.works = const [],
      this.isDone = false});

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> newWorks =
        works.map((works) => works.toMap()).toList();

    return {
      'id': id,
      'name': name,
      'surname': surname,
      'works': newWorks,
      'isDone': isDone
    };
  }

  factory Customers.fromMap(Map map) {
    var workListAsMap = map['works'] as List;
    List<Works> works =
        workListAsMap.map((workAsMap) => Works.fromMap(workAsMap)).toList();
    return Customers(
        id: map['id'],
        name: map['name'],
        surname: map['surname'],
        works: works,
        isDone: map['isDone']);
  }
}
