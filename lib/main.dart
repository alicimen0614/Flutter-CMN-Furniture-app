import 'package:cimenfurniture/services/auth.dart';
import 'package:cimenfurniture/widgets/on_board.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Provider<Auth>(
      create: (context) => Auth(),
      child: MaterialApp(
          home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("hata oluştu");
          } else if (snapshot.hasData) {
            print("Onboard çalıştı");
            return const OnBoardWidget();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
