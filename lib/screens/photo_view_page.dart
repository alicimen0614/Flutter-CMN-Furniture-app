import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:provider/provider.dart';

import '../viewmodels/detailed_categories_view_model.dart';

class PhotoViewPage extends StatelessWidget {
  late int index;
  final String filePath;
  late List<String> imageLinks;
  PhotoViewPage({
    super.key,
    required this.index,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: context
            .read<DetailedCategoriesViewModel>()
            .getImageUrlsFromFirebase(filePath),
        builder: (context, AsyncSnapshot<DocumentSnapshot> listOfImages) {
          print("galeri stream girdi");
          if (listOfImages.hasData) {
            Map mapOfImages = listOfImages.data!.data() as Map;
            List listOfImageUrls = mapOfImages.values.toList().first;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: (() => deleteImage(context, listOfImageUrls)),
                      icon: Icon(Icons.delete))
                ],
              ),
              body: PhotoViewGallery.builder(
                onPageChanged: (galleyIndex) {
                  index = galleyIndex;
                  print("$galleyIndex -- $index");
                },
                itemCount: listOfImageUrls.length,
                builder: ((context, index) =>
                    PhotoViewGalleryPageOptions.customChild(
                        child: CachedNetworkImage(
                          imageUrl: listOfImageUrls[index],
                          placeholder: (context, url) => Container(
                            color: Colors.grey,
                          ),
                          errorWidget: (context, url, error) =>
                              Container(color: Colors.red.shade400),
                        ),
                        minScale: PhotoViewComputedScale.covered)),
                pageController: PageController(initialPage: index),
                enableRotation: true,
              ),
            );
          } else if (listOfImages.hasError) {
            return Scaffold(
                appBar: AppBar(centerTitle: true, title: Text("Yetki Gerekli")),
                body: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text(listOfImages.error.toString()))));
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  void deleteImage(BuildContext context, List<dynamic> listOfImageUrls) {
/* ı played with the indexes in here because when ı delete an image the index stays the same in the gallery even if its not. 
so ı figured it with this: if the index is the last index decrease 1 because in the gallery when you delete the last image it moves to the
one before it. If its not the last index don't change the it because when you delete an image the index stays the same and the image next to
that image is now the new image on that index :)  */
    Future(
      () => context
          .read<DetailedCategoriesViewModel>()
          .getImageNameAndDelete(filePath, listOfImageUrls[index])
          .whenComplete(() {
        ScaffoldMessenger.of(context).showSnackBar(snackBar());
        if (index == listOfImageUrls.length - 1) {
          index = index - 1;
        }
        if (index == -1) {
          Navigator.pop(context);
        }
      }),
    );
  }

  SnackBar snackBar() {
    return SnackBar(
      content: const Text('Fotoğraf başarılı bir şekilde silindi!'),
      action: SnackBarAction(
        label: 'Tamam',
        onPressed: () {},
      ),
    );
  }
}
