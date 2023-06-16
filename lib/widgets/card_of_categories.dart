import 'package:cimenfurniture/screens/detailed_categories_view.dart';
import 'package:flutter/material.dart';

class CardOfCategories extends StatelessWidget {
  String text = " ";
  String imagelocation = "";
  String storagePath = "";
  double width;
  CardOfCategories(
      {super.key,
      required this.text,
      required this.imagelocation,
      required this.storagePath,
      this.width = 200});

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    return Material(
      elevation: 8,
      color: Colors.amberAccent,
      borderRadius: BorderRadius.circular(28),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: (() {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailedCategoriesView(
                filePath: storagePath, categoryName: text),
          ));
        }),
        child: Column(
          children: <Widget>[
            Ink.image(
              image: AssetImage(imagelocation),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              width: mediaQueryWidth / 2.1,
              height: mediaQueryHeight / 3.5,
            ),
            SizedBox(
              height: mediaQueryHeight * 0.007,
            ),
            // ignore: avoid_unnecessary_containers
            Text(
              text,
              style: TextStyle(
                  fontSize: mediaQueryWidth * 0.036, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
