import 'package:cimenfurniture/models/works_model.dart';
<<<<<<< HEAD
=======
import 'package:cloud_firestore/cloud_firestore.dart';
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165

class Customers {
  final String id;
  final String name;
  final String surname;
  final List<Works> works;

  Customers(
      {required this.id,
      required this.name,
      required this.surname,
      this.works = const []});

  Map<String, dynamic> toMap() {
    List<Map<String, dynamic>> newWorks =
        works.map((works) => works.toMap()).toList();

    return {'id': id, 'name': name, 'surname': surname, 'works': newWorks};
  }

  factory Customers.fromMap(Map map) {
    var workListAsMap = map['works'] as List;
    List<Works> works =
        workListAsMap.map((workAsMap) => Works.fromMap(workAsMap)).toList();
    return Customers(
        id: map['id'],
        name: map['name'],
        surname: map['surname'],
        works: works);
  }
}
