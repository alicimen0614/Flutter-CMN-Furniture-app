import 'package:cimenfurniture/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context, listen: false).currentUser();
    bool isAnonymous = user?.isAnonymous as bool;

    return Scaffold(
      backgroundColor: Colors.amber,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isAnonymous == false
                ? ClipOval(
                    child: Image.network(
                    user!.photoURL as String,
                    fit: BoxFit.cover,
                    height: 150,
                  ))
                : ClipOval(
                    child:
                        Image.asset('lib/images/user.png', fit: BoxFit.cover),
                  ),
            const SizedBox(
              height: 20,
            ),
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Colors.teal,
                ),
                title: isAnonymous == false
                    ? Text(
                        user!.displayName as String,
                        style: TextStyle(
                            fontSize: 20, color: Colors.teal.shade900),
                      )
                    : const Text("Anonim"),
              ),
            ),
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.mail,
                  color: Colors.teal,
                ),
                title: isAnonymous == false
                    ? Text(
                        user!.email as String,
                        style: TextStyle(
                            fontSize: 20, color: Colors.teal.shade900),
                      )
                    : Text("********"),
              ),
            ),
            SizedBox(
              height: 70,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.exit_to_app_rounded),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () async {
                    await Provider.of<Auth>(context, listen: false).signOut();
                  },
                  label: const Text('Çıkış Yap'),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
