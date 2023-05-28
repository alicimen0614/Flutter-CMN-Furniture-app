import 'package:flutter/material.dart';

class CardOfCategories extends StatelessWidget {
  String text = " ";
  String imagelocation = "";
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
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(imagelocation,
                    fit: BoxFit.cover, alignment: Alignment.center),
                const SizedBox(
                  height: 5.0,
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                    child: Text(
                  text,
                  style: TextStyle(fontSize: 15),
                )),
              ],
            ),
          ),
        ));
  }
}
