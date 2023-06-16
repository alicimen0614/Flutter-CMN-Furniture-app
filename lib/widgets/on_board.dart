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
    print("onboard çalıştı");
    final auth = Provider.of<Auth>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStatus(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          print("snapshota girdi");
          print(snapshot.data);
          if (snapshot.data?.emailVerified == false &&
              snapshot.data?.isAnonymous == false) {
            Provider.of<Auth>(context).signOut();
            print("çıkış yapıldı from onboard");
          } else if (snapshot.data?.isAnonymous == true) {
            return const ControlPage();
          }

          return snapshot.data != null && snapshot.data!.emailVerified != false
              ? const ControlPage()
              : const SignInPage();
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
