import 'package:cached_network_image/cached_network_image.dart';
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
    return StreamBuilder(
        stream:
            context.read<DetailedCategoriesViewModel>().listOfImages(filePath),
        builder: (context, listOfImages) {
          print("galeri stream girdi");
          if (listOfImages.hasData) {
            imageLinks = listOfImages.data as List<String>;
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: (() => deleteImage(index, context)),
                      icon: Icon(Icons.delete))
                ],
              ),
              body: PhotoViewGallery.builder(
                onPageChanged: (galleyIndex) {
                  index = galleyIndex;
                  print("$galleyIndex -- $index");
                },
                itemCount: imageLinks.length,
                builder: ((context, index) =>
                    PhotoViewGalleryPageOptions.customChild(
                        child: CachedNetworkImage(
                          imageUrl: imageLinks[index],
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

  void deleteImage(int index, BuildContext context) {
    print("deleteImage'e girdi");
    Future(
      () => context
          .read<DetailedCategoriesViewModel>()
          .getImageNameAndDelete(filePath, imageLinks[index]),
    );
  }
}
