<<<<<<< HEAD
import 'package:cached_network_image/cached_network_image.dart';
=======
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
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
<<<<<<< HEAD
      backgroundColor: Colors.amberAccent.shade400,
=======
      backgroundColor: Colors.amber,
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< HEAD
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
=======
            isAnonymous == false
                ? ClipOval(
                    child: Image.network(
                    user!.photoURL as String,
                    fit: BoxFit.cover,
                    height: 150,
                  ))
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
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
<<<<<<< HEAD
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
=======
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
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
            ),
            Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: const Icon(
                  Icons.mail,
                  color: Colors.teal,
                ),
<<<<<<< HEAD
                title: user.email != null
                    ? Text(
                        user.email as String,
                        style: const TextStyle(fontSize: 20),
                      )
                    : const Text("********"),
=======
                title: isAnonymous == false
                    ? Text(
                        user!.email as String,
                        style: TextStyle(
                            fontSize: 20, color: Colors.teal.shade900),
                      )
                    : Text("********"),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
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
