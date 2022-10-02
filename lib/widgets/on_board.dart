import 'package:cimenfurniture/screens/control_page.dart';
import 'package:cimenfurniture/screens/sign_in_page.dart';
import 'package:cimenfurniture/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnBoardWidget extends StatefulWidget {
  const OnBoardWidget({super.key});

  @override
  State<OnBoardWidget> createState() => _OnBoardWidgetState();
}

class _OnBoardWidgetState extends State<OnBoardWidget> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print("snapshot active");
          print(snapshot.data);
          return snapshot.data != null
              ? const ControlPage()
              : const SignInPage();
        } else {
          return Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 20),
              child: const CircularProgressIndicator(
                value: 0.8,
                backgroundColor: Colors.transparent,
                color: Colors.brown,
              ));
        }
      },
    );
  }
}
