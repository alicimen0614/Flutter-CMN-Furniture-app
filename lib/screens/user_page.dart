import 'package:cached_network_image/cached_network_image.dart';
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
      backgroundColor: Colors.amberAccent.shade400,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user!.photoURL != null
                ? ClipOval(
                    child: CachedNetworkImage(
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      imageUrl: user.photoURL as String,
                      placeholder: (context, url) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: const [CircularProgressIndicator()]),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  )
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
                  title: (user.displayName != "" && user.displayName != null)
                      ? Text(
                          user.displayName as String,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        )
                      : const Text(
                          "Kullanıcı adı yok",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        )),
            ),
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.mail,
                  color: Colors.teal,
                ),
                title: user.email != null
                    ? Text(
                        user.email as String,
                        style: const TextStyle(fontSize: 20),
                      )
                    : const Text("********"),
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
