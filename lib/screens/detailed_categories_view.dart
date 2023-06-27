import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cimenfurniture/screens/photo_view_page.dart';
import 'package:cimenfurniture/viewmodels/detailed_categories_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class DetailedCategoriesView extends StatefulWidget {
  String filePath = "";
  String categoryName = "";

  DetailedCategoriesView(
      {super.key, required this.filePath, required this.categoryName});

  @override
  State<DetailedCategoriesView> createState() => _DetailedCategoriesViewState();
}

class _DetailedCategoriesViewState extends State<DetailedCategoriesView> {
  File? image;
  late String randomName;
  late String urlOfUploadedImage;

  String createRandomName() {
    return randomName = DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
          source: source, imageQuality: 75, maxHeight: 960, maxWidth: 1280);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      if (!mounted) return;
      urlOfUploadedImage = await context
          .read<DetailedCategoriesViewModel>()
          .uploadFile(createRandomName(), widget.filePath, File(image.path));
      if (!mounted) return;

      await context
          .read<DetailedCategoriesViewModel>()
          .addImageUrlToFireStore(widget.filePath, urlOfUploadedImage);
    } on PlatformException catch (e) {
      print('Failed to take image $image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: context
            .read<DetailedCategoriesViewModel>()
            .getImageUrlsFromFirebase(widget.filePath),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            Map mapOfImages = snapshot.data!.data() as Map;

            List listOfImageUrls = mapOfImages.values.toList().first;

            print("ilk stream çalıştı");

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add_a_photo_rounded,
                      color: Colors.white),
                  onPressed: () => showModalBottomSheet(
                      context: context, builder: (context) => buildSheet())),
              appBar:
                  AppBar(centerTitle: true, title: Text(widget.categoryName)),
              body: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                padding: EdgeInsets.all(1),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: listOfImageUrls.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(0.5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((_) => PhotoViewPage(
                                      index: index,
                                      filePath: widget.filePath,
                                    ))));
                      },
                      child: CachedNetworkImage(
                        imageUrl: listOfImageUrls[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey,
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.red.shade400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
                appBar: AppBar(centerTitle: true, title: Text("Yetki Gerekli")),
                body: Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(child: Text(snapshot.error.toString()))));
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }

  Future<void> _emailDialog(String path, String imageName) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fotoğraf silme'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Fotoğraf silinecektir onaylıyor musunuz?.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Onayla'),
              onPressed: () async {
                await context
                    .read<DetailedCategoriesViewModel>()
                    .deleteImage(path, imageName);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildSheet() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              pickImage(ImageSource.camera)
                  .then((value) => Navigator.pop(context));
            },
            child: SizedBox(
                height: height * 0.057,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.add_a_photo_rounded),
                  SizedBox(
                    width: width * 0.020,
                  ),
                  Text(
                    'Kamera',
                    style: GoogleFonts.kanit(fontSize: width * 0.051),
                  ),
                ])),
          ),
          const Divider(height: 1, color: Colors.white),
          ElevatedButton(
            onPressed: () {
              pickImage(ImageSource.gallery)
                  .then((value) => Navigator.pop(context));
            },
            child: SizedBox(
                height: height * 0.057,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.camera_alt_rounded),
                  SizedBox(
                    width: width * 0.020,
                  ),
                  Text(
                    'Galeri',
                    style: GoogleFonts.kanit(fontSize: width * 0.051),
                  ),
                  SizedBox(width: width * 0.033),
                ])),
          )
        ]);
  }
}
