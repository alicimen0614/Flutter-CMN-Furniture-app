import 'package:cimenfurniture/widgets/sign_in_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

enum FormStatus { signIn, register, reset }

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();

  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();
  TextEditingController registerPasswordConfirmController =
      TextEditingController();
  TextEditingController resetEmailController = TextEditingController();

  @override
  void dispose() {
    signInEmailController.dispose();
    signInPasswordController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
    registerPasswordConfirmController.dispose();
    resetEmailController.dispose();
    super.dispose();
  }

  FormStatus _formStatus = FormStatus.signIn;

  Future<void>? _signInAnonymously() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    final user =
        await Provider.of<Auth>(context, listen: false).signInAnonymously();

    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void>? _signInWithGoogle() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    final user =
        await Provider.of<Auth>(context, listen: false).signInWithGoogle();

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("signin page çalıştı");
    return Scaffold(
      backgroundColor: Colors.amber,
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: Container(
          padding: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              color: Colors.grey[200], borderRadius: BorderRadius.circular(25)),
          height: 600,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _formStatus == FormStatus.signIn
                    ? buildSignInForm()
                    : _formStatus == FormStatus.register
                        ? buildRegisterForm()
                        : buildResetForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(
                      color: Colors.orangeAccent,
                      onPressed: _signInAnonymously,
                      child: const Text(
                        "Anonim Giriş",
                        style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  SignInButton(
                    color: Colors.redAccent,
                    onPressed: _signInWithGoogle,
                    child: const Text("Google ile giriş"),
                  )
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }

  Form buildSignInForm() {
    final signInFormKey = GlobalKey<FormState>();
    return Form(
        key: signInFormKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Giriş Yap",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: signInEmailController,
            validator: (value) {
              if (EmailValidator.validate(value!)) {
                return null;
              } else {
                return "Lütfen geçerli bir e-mail adresi giriniz";
              }
            },
            cursorColor: Colors.amberAccent,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.amberAccent)),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.amberAccent,
                ),
                hintText: "E-mail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: signInPasswordController,
            validator: (value) {
              if (value!.length < 6 || value.length > 16) {
                return "Şifreniz 6-16 karakter arasında olmalıdır";
              } else {
                return null;
              }
            },
            cursorColor: Colors.amberAccent,
            obscureText: true,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.amberAccent)),
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.amberAccent,
                ),
                hintText: "Şifre",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: SignInButton(
                color: Colors.amber,
                onPressed: () async {
                  if (signInFormKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) => const Center(
                              child: CircularProgressIndicator(),
                            ));
                    final user = await Provider.of<Auth>(context, listen: false)
                        .signInWithEmailAndPassword(signInEmailController.text,
                            signInPasswordController.text);
                    if (!mounted) return;
                    Navigator.pop(context);

                    if (!user!.emailVerified) {
                      await _emailDialog();
                    }
                  }
                },
                child: const Text("Giriş Yap")),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text("Üye değil misin?"),
            TextButton(
                onPressed: () {
                  setState(() {
                    _formStatus = FormStatus.register;
                  });
                },
                child: const Text(
                  "Üye Ol",
                  style: TextStyle(color: Colors.amberAccent),
                ))
          ]),
          TextButton(
              onPressed: () {
                setState(() {
                  _formStatus = FormStatus.reset;
                });
              },
              child: const Text(
                "Şifremi unuttum.",
                style: TextStyle(color: Colors.amberAccent),
              ))
        ]));
  }

  Form buildRegisterForm() {
    print("registerform çaıştı");
    final registerFormKey = GlobalKey<FormState>();

    return Form(
        key: registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Kayıt Ol",
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 25,
            ),
            TextFormField(
              controller: registerEmailController,
              validator: (value) {
                if (EmailValidator.validate(value!)) {
                  return null;
                } else {
                  return "Lütfen geçerli bir e-mail adresi giriniz";
                }
              },
              cursorColor: Colors.amberAccent,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.amberAccent)),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.amberAccent,
                  ),
                  hintText: "E-mail",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: registerPasswordController,
              validator: (value) {
                if (value!.length < 6 || value.length > 16) {
                  return "Şifreniz 6-16 karakter arasında olmalıdır";
                } else if (value != registerPasswordConfirmController.text) {
                  return 'Şifreler Uyuşmuyor';
                } else {
                  return null;
                }
              },
              cursorColor: Colors.amberAccent,
              obscureText: true,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.amberAccent)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.amberAccent,
                  ),
                  hintText: "Şifre",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: registerPasswordConfirmController,
              validator: (value) {
                if (value!.length < 6 || value.length > 16) {
                  return "Şifreniz 6-16 karakter arasında olmalıdır";
                } else if (value != registerPasswordController.text) {
                  return 'Şifreler Uyuşmuyor';
                } else {
                  return null;
                }
              },
              cursorColor: Colors.amberAccent,
              obscureText: true,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                      borderSide: const BorderSide(color: Colors.amberAccent)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.amberAccent,
                  ),
                  hintText: "Şifre tekrar",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0))),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 200,
              child: SignInButton(
                  color: Colors.amber,
                  onPressed: () async {
                    if (registerFormKey.currentState!.validate()) {
                      final user =
                          await Provider.of<Auth>(context, listen: false)
                              .createUserWithEmailAndPassword(
                                  registerEmailController.text,
                                  registerPasswordController.text);

                      if (!user!.emailVerified) {
                        await user.sendEmailVerification();
                      }
                      setState(() {
                        _formStatus = FormStatus.signIn;
                        print(_formStatus);
                      });
                      await _emailDialog();
                    }
                  },
                  child: const Text("Kayıt Ol")),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Zaten üye misin?"),
              TextButton(
                  onPressed: () {
                    setState(
                      () {
                        _formStatus = FormStatus.signIn;
                      },
                    );
                  },
                  child: const Text(
                    "Giriş Yap",
                    style: TextStyle(color: Colors.amberAccent),
                  ))
            ]),
          ],
        ));
  }

  Form buildResetForm() {
    print("resetform çaıştı");

    final resetFormKey = GlobalKey<FormState>();
    return Form(
        key: resetFormKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "Şifre Sıfırla",
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: resetEmailController,
            validator: (value) {
              if (EmailValidator.validate(value!)) {
                return null;
              } else {
                return "Lütfen geçerli bir e-mail adresi giriniz";
              }
            },
            cursorColor: Colors.amberAccent,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(color: Colors.amberAccent)),
                prefixIcon: const Icon(
                  Icons.email,
                  color: Colors.amberAccent,
                ),
                hintText: "E-mail",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 200,
            child: SignInButton(
                color: Colors.amber,
                onPressed: () async {
                  if (resetFormKey.currentState!.validate()) {
                    Provider.of<Auth>(context, listen: false)
                        .sendPasswordResetEmail(resetEmailController.text);
                    await _resetDialog();
                  }
                },
                child: const Text("Gönder")),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _formStatus = FormStatus.signIn;
                });
              },
              child: const Text(
                "Giriş yap.",
                style: TextStyle(color: Colors.amberAccent),
              ))
        ]));
  }

  Future<void> _emailDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('E-posta doğrulama gerekli'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                    'Lütfen e-posta adresinize giderek hesabınızı doğrulayınız.'),
                Text(
                    'Onay linkine tıklatıkdan sonra bilgilerinizle giriş yapabilirsiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Onayla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap the button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ŞİFRE YENİLEME'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Lütfen e-posta adresinizi kontrol ediniz.'),
                Text('Linke tıklayarak şifrenizi yenileyebilirsiniz.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Onayla'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
