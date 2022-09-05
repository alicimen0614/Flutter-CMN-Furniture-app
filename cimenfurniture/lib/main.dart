import 'package:cimenfurniture/screens/customers_page.dart';
import 'package:cimenfurniture/screens/furnitures_page.dart';
import 'package:cimenfurniture/screens/home_page.dart';
import 'package:cimenfurniture/screens/user_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    const MyHomePage(),
    const CustomersPage(),
    const FurnituresPage(),
    const UserPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        title: const Text(
          'CMN',
          style: TextStyle(
              color: Colors.amberAccent,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: bottomNavigationBarBuilder(),
    ));
  }

  Widget bottomNavigationBarBuilder() {
    return BottomNavigationBar(
      iconSize: 30,
      fixedColor: Colors.brown[500],
      unselectedItemColor: Colors.black54,
      type: BottomNavigationBarType.shifting,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Anasayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Müşteriler',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.format_list_bulleted_outlined),
          label: 'Kategoriler',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.account_circle_rounded,
          ),
          label: 'Kullanıcı',
        ),
      ],
    );
  }
}
