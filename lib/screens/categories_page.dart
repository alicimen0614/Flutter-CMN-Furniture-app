import 'package:cimenfurniture/widgets/card_of_categories.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> Products = [
      "Mutfak",
      "Yatak Odası",
      "Oturma Odası",
      "Çalışma Odası",
      "Antre",
      "Ofis",
      "Salon"
    ];
    List<String> categoriesImages = [
      'lib/images/mutfak2.jpg',
      'lib/images/yatak_odası2.jpg',
      'lib/images/oturma_odası.jpg',
      'lib/images/çalışma_odası.jpg',
      'lib/images/antre.jpg',
      'lib/images/ofis_odası.jpg',
      'lib/images/salon1.jpg',
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Kategoriler"),
          centerTitle: true,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardOfCategories(
                      text: Products[0],
                      imagelocation: categoriesImages[0],
                    ),
                    CardOfCategories(
                      text: Products[1],
                      imagelocation: categoriesImages[1],
                    ),
                  ],
                ),
                const Divider(color: Colors.black87, endIndent: 15, indent: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardOfCategories(
                        text: Products[2], imagelocation: categoriesImages[2]),
                    CardOfCategories(
                      text: Products[3],
                      imagelocation: categoriesImages[3],
                    ),
                  ],
                ),
                const Divider(color: Colors.black87, endIndent: 15, indent: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CardOfCategories(
                        text: Products[4], imagelocation: categoriesImages[4]),
                    CardOfCategories(
                      text: Products[5],
                      imagelocation: categoriesImages[5],
                    ),
                  ],
                ),
                const Divider(color: Colors.black87, endIndent: 15, indent: 15),
                CardOfCategories(
                    text: Products[6], imagelocation: categoriesImages[6])
              ],
            )
          ],
        ));
  }
}
