<<<<<<< HEAD
import 'package:cimenfurniture/screens/detailed_categories_view.dart';
=======
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
import 'package:flutter/material.dart';

class CardOfCategories extends StatelessWidget {
  String text = " ";
  String imagelocation = "";
<<<<<<< HEAD
  String storagePath = "";
  CardOfCategories(
      {super.key,
      required this.text,
      required this.imagelocation,
      required this.storagePath});

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return SizedBox(
        width: 190,
        height: MediaQuery.of(context).size.height < 800
            ? MediaQuery.of(context).size.height * 0.373
            : MediaQuery.of(context).size.height * 0.29,
        child: Card(
          elevation: 2.0,
          color: Colors.amberAccent,
          margin: EdgeInsets.all(mediaQueryWidth * 0.012),
          child: InkWell(
            onTap: (() {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailedCategoriesView(
                    filePath: storagePath, categoryName: text),
              ));
=======
  CardOfCategories(
      {super.key, required this.text, required this.imagelocation});

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return SizedBox(
        width: 200,
        height: 255,
        child: Card(
          elevation: 2.0,
          color: Colors.amberAccent,
          margin: const EdgeInsets.all(5.0),
          child: InkWell(
            onTap: (() {
              print("abc");
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(imagelocation,
                    fit: BoxFit.cover, alignment: Alignment.center),
<<<<<<< HEAD
                SizedBox(
                  height: mediaQueryHeight * 0.007,
=======
                const SizedBox(
                  height: 5.0,
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                    child: Text(
                  text,
<<<<<<< HEAD
                  style: TextStyle(
                      fontSize: mediaQueryWidth * 0.036, color: Colors.black),
=======
                  style: TextStyle(fontSize: 15),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
                )),
              ],
            ),
          ),
        ));
  }
}
