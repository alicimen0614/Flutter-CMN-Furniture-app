import 'package:cimenfurniture/screens/customers_page.dart';
import 'package:cimenfurniture/screens/categories_page.dart';
import 'package:cimenfurniture/screens/home_page.dart';
import 'package:cimenfurniture/screens/user_page.dart';
import 'package:flutter/material.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  int currentIndex = 0;
  final screens = [
    const MyHomePage(),
    const CustomersPage(),
    const CategoriesPage(),
    const UserPage()
  ];
  @override
  Widget build(BuildContext context) {
    print("controlpage çalıştı");
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: bottomNavigationBarBuilder(),
    );
  }

  Widget bottomNavigationBarBuilder() {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    return BottomNavigationBar(
      iconSize: mediaQueryWidth * 0.073,
      fixedColor: Colors.brown[500],
      unselectedItemColor: Colors.black54,
      type: BottomNavigationBarType.fixed,
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
