import 'package:cimenfurniture/widgets/card_of_categories.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    List<String> products = [
=======
    List<String> Products = [
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
      "Mutfak",
      "Yatak Odası",
      "Oturma Odası",
      "Çalışma Odası",
      "Antre",
      "Ofis",
<<<<<<< HEAD
      "Salon",
      "Banyo",
    ];

    List<String> storagePaths = [
      "mutfak",
      "yatak_odası",
      "oturma_odası",
      "çalışma_odası",
      "antre",
      "ofis",
      "salon",
      "banyo"
=======
      "Salon"
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
    ];
    List<String> categoriesImages = [
      'lib/images/mutfak2.jpg',
      'lib/images/yatak_odası2.jpg',
      'lib/images/oturma_odası.jpg',
      'lib/images/çalışma_odası.jpg',
      'lib/images/antre.jpg',
      'lib/images/ofis_odası.jpg',
      'lib/images/salon1.jpg',
<<<<<<< HEAD
      'lib/images/banyo_resized.jpg'
=======
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Kategoriler"),
          centerTitle: true,
        ),
        body: ListView(
<<<<<<< HEAD
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.all(mediaQueryWidth * 0.012),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: mediaQueryHeight * 0.014,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardOfCategories(
                        text: products[0],
                        imagelocation: categoriesImages[0],
                        storagePath: storagePaths[0],
                      ),
                      CardOfCategories(
                          text: products[1],
                          imagelocation: categoriesImages[1],
                          storagePath: storagePaths[1]),
                    ],
                  ),
                  Divider(
                      color: Colors.black87,
                      endIndent: mediaQueryWidth * 0.021,
                      indent: mediaQueryWidth * 0.021),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardOfCategories(
                          text: products[2],
                          imagelocation: categoriesImages[2],
                          storagePath: storagePaths[2]),
                      CardOfCategories(
                          text: products[3],
                          imagelocation: categoriesImages[3],
                          storagePath: storagePaths[3]),
                    ],
                  ),
                  Divider(
                      color: Colors.black87,
                      endIndent: mediaQueryWidth * 0.021,
                      indent: mediaQueryWidth * 0.021),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CardOfCategories(
                          text: products[4],
                          imagelocation: categoriesImages[4],
                          storagePath: storagePaths[4]),
                      CardOfCategories(
                          text: products[5],
                          imagelocation: categoriesImages[5],
                          storagePath: storagePaths[5]),
                    ],
                  ),
                  Divider(
                      color: Colors.black87,
                      endIndent: mediaQueryWidth * 0.021,
                      indent: mediaQueryWidth * 0.021),
                  CardOfCategories(
                      text: products[6],
                      imagelocation: categoriesImages[6],
                      storagePath: storagePaths[6]),
                  Divider(
                      color: Colors.black87,
                      endIndent: mediaQueryWidth * 0.021,
                      indent: mediaQueryWidth * 0.021),
                  CardOfCategories(
                      text: products[7],
                      imagelocation: categoriesImages[7],
                      storagePath: storagePaths[7]),
                ],
              ),
=======
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
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
            )
          ],
        ));
  }
}
