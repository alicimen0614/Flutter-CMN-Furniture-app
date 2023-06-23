import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cimenfurniture/screens/photo_view_page.dart';
import 'package:cimenfurniture/viewmodels/detailed_categories_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
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
  bool isLongClicked = false;
  List<String> imageLinks = [];
  int length = 0;

  String createRandomName() {
    return randomName = DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
          source: source, imageQuality: 50, maxHeight: 960, maxWidth: 1280);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
      if (!mounted) return;
      await context
          .read<DetailedCategoriesViewModel>()
          .uploadFile(createRandomName(), widget.filePath, File(image.path));
      setState(() {});
    } on PlatformException catch (e) {
      print('Failed to take image $image');
    }
  }

  Future refresh() async {
    setState(() {});
    return await Future.delayed(const Duration(seconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: context
            .read<DetailedCategoriesViewModel>()
            .listOfImages(widget.filePath),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            length = snapshot.data!.length;
            print("ilk stream çalıştı");

            final images = snapshot.data;

            return Scaffold(
              floatingActionButton: FloatingActionButton(
                  child: const Icon(Icons.add_a_photo_rounded,
                      color: Colors.white),
                  onPressed: () => showModalBottomSheet(
                      context: context, builder: (context) => buildSheet())),
              appBar:
                  AppBar(centerTitle: true, title: Text(widget.categoryName)),
              body: RefreshIndicator(
                onRefresh: refresh,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  padding: EdgeInsets.all(1),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: images!.length,
                  itemBuilder: (context, index) {
                    imageLinks = snapshot.data!;
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
                          imageUrl: snapshot.data![index],
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
                height: 50,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.add_a_photo_rounded),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Kamera',
                    style: GoogleFonts.kanit(fontSize: 20),
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
                height: 50,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.camera_alt_rounded),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Galeri',
                    style: GoogleFonts.kanit(fontSize: 20),
                  ),
                  const SizedBox(width: 13),
                ])),
          )
        ]);
  }

  void deleteImage(int index, BuildContext context) {
    print("deleteImage'e girdi");
    Future(
      () => context
          .read<DetailedCategoriesViewModel>()
          .getImageNameAndDelete(widget.filePath, imageLinks[index]),
    );
  }
}
