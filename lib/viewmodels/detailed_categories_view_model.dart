import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedCategoriesViewModel extends ChangeNotifier {
  final _firebaseStorage = FirebaseStorage.instance;

  Future<ListResult> listAllFiles(String path) async {
    final listResult = await _firebaseStorage.ref(path).listAll();
    return listResult;
  }

  Future<String> getImageUrl(String path, String imageName) async {
    return await _firebaseStorage.ref(path).child(imageName).getDownloadURL();
  }

  Future<void> deleteImage(String path, String imageName) async {
    await _firebaseStorage.ref(path).child(imageName).delete();
  }

  Future<void> uploadFile(String ipath, String fpath, File file) async {
    await _firebaseStorage.ref().child(fpath).child(ipath).putFile(file);
  }
}
