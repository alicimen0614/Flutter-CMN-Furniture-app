import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedCategoriesViewModel extends ChangeNotifier {
  final _firebaseStorage = FirebaseStorage.instance;

  final _firestore = FirebaseFirestore.instance;
  Stream<DocumentSnapshot> getImageUrlsFromFirebase(String path) {
    return _firestore.collection('images').doc(path).snapshots();
  }

  Stream<ListResult> listAllFiles(String path) async* {
    final listResult = await _firebaseStorage.ref(path).listAll();
    yield listResult;
  }

  addImageUrlToFireStore(String path, String url) {
    _firestore.collection("images").doc(path).update({
      path: FieldValue.arrayUnion([url])
    });
  }

  /*  Stream<List<String>> listOfImages(String path) async* {
    final listResult = await _firebaseStorage.ref(path).listAll();
    List<String> imagesList = [];
    List<Reference> files = listResult.items;

    for (var i = 0; i < files.length; i++) {
      imagesList.add(await _firebaseStorage
          .ref(path)
          .child(files[i].name)
          .getDownloadURL());
    }
    yield imagesList;
    // I used this to get the imagesList on firebase storage because when ı try to get it from detailed_categories_view the future builder loaded
    //the pictures mixed and the picture didn't match when it navigated to the gallery.
  } */

  Stream<String> getImageUrl(String path, String imageName) async* {
    yield await _firebaseStorage.ref(path).child(imageName).getDownloadURL();
  }

  Future<void> deleteImage(String path, String imageName) async {
    await _firebaseStorage.ref(path).child(imageName).delete();
  }

  Future<void> getImageNameAndDelete(String path, String url) async {
    String name = _firebaseStorage.refFromURL(url).name;
    await _firebaseStorage.ref(path).child(name).delete();
    await _firestore.collection('images').doc(path).update({
      path: FieldValue.arrayRemove([url])
    });
  }

  Future<String> uploadFile(String name, String fpath, File file) async {
    await _firebaseStorage.ref().child(fpath).child(name).putFile(file);
    return await _firebaseStorage
        .ref()
        .child(fpath)
        .child(name)
        .getDownloadURL();
  }
}
