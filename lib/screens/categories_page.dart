import 'package:cimenfurniture/widgets/card_of_categories.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    List<String> products = [
      "Mutfak",
      "Yatak Odası",
      "Oturma Odası",
      "Çalışma Odası",
      "Antre",
      "Ofis",
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
    ];
    List<String> categoriesImages = [
      'lib/images/mutfak_dolabi.jpeg',
      'lib/images/yatak_odasi.jpg',
      'lib/images/oturma_odasi.jpg',
      'lib/images/calisma_masasi.png',
      'lib/images/antre.jpg',
      'lib/images/ofis_odasi2.jpg',
      'lib/images/salon.png',
      'lib/images/banyo_1.jpeg'
    ];

    return Scaffold(
        appBar: AppBar(
          title: const Text("Kategoriler"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(10),
            itemCount: categoriesImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: mediaQueryHeight / 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              return CardOfCategories(
                text: products[index],
                imagelocation: categoriesImages[index],
                storagePath: storagePaths[index],
              );
            },
          ),
        ));
  }
}
