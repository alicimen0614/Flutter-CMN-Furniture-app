import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cimenfurniture/viewmodels/detailed_categories_view_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  bool isLongClicked = false;

  String createRandomName() {
    int random = Random().nextInt(1000000);
    String random2 = DateTime.now().microsecondsSinceEpoch.toString();
    randomName = "$random$random2";
    return randomName;
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
    return FutureBuilder<ListResult>(
        future: context
            .read<DetailedCategoriesViewModel>()
            .listAllFiles(widget.filePath),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("ilk future çalıştı");
            final files = snapshot.data!.items;
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
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: files.length,
                  itemBuilder: (context, index) {
                    Color color = Colors.white;
                    final file = files[index];
                    return FutureBuilder(
                        future: context
                            .read<DetailedCategoriesViewModel>()
                            .getImageUrl(widget.filePath, file.name),
                        builder: (context, futureSnapshot) {
                          if (futureSnapshot.hasData) {
                            print("2. future çalıştı");
                            return Padding(
                                padding: const EdgeInsets.all(15),
                                child: Dismissible(
                                  onDismissed: (direction) async {
                                    await _emailDialog(
                                        widget.filePath, file.name);
                                  },
                                  background: Container(
                                    padding: const EdgeInsets.all(25),
                                    alignment: Alignment.centerRight,
                                    color: Colors.redAccent,
                                    child: const Icon(Icons.delete,
                                        size: 75, color: Colors.white),
                                  ),
                                  key: ObjectKey(file),
                                  child: CachedNetworkImage(
                                    imageUrl: futureSnapshot.data as String,
                                  ),
                                ));
                          } else if (futureSnapshot.hasError) {
                            return Center(
                              child: Text(futureSnapshot.error.toString()),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        });
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
}
