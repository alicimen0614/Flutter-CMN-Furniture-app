import 'package:cimenfurniture/widgets/sign_in_button.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth.dart';

enum FormStatus { signIn, register }

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FormStatus _formStatus = FormStatus.signIn;
  bool _isLoading = false;

  Future<void>? _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });

    final user =
        await Provider.of<Auth>(context, listen: false).signInAnonymously();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.amber,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.only(bottom: 20, top: 20),
        child: Container(
          padding: EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
              color: Colors.brown[400],
              borderRadius: BorderRadius.circular(25)),
          height: 600,
          width: 350,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: _formStatus == FormStatus.signIn
                    ? buildSignInForm()
                    : buildRegisterForm(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignInButton(
                      color: Colors.orangeAccent,
                      onPressed: _isLoading ? null : _signInAnonymously,
                      child: const Text(
                        "Anonim Giriş",
                        style: TextStyle(color: Colors.black),
                      )),
                  const SizedBox(
                    width: 40,
                  ),
                  SignInButton(
                    color: Colors.redAccent,
                    onPressed: () {},
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
    TextEditingController signInEmailController = TextEditingController();
    TextEditingController signInPasswordController = TextEditingController();

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
                    final user = await Provider.of<Auth>(context, listen: false)
                        .signInWithEmailAndPassword(signInEmailController.text,
                            signInPasswordController.text);
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
        ]));
  }

  Form buildRegisterForm() {
    final registerFormKey = GlobalKey<FormState>();

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController passwordConfirmController = TextEditingController();

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
              controller: emailController,
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
              controller: passwordController,
              validator: (value) {
                if (value!.length < 6 || value.length > 16) {
                  return "Şifreniz 6-16 karakter arasında olmalıdır";
                } else if (value != passwordConfirmController.text) {
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
              controller: passwordConfirmController,
              validator: (value) {
                if (value!.length < 6 || value.length > 16) {
                  return "Şifreniz 6-16 karakter arasında olmalıdır";
                } else if (value != passwordController.text) {
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
                      final user = await Provider.of<Auth>(context,
                              listen: false)
                          .createUserWithEmailAndPassword(
                              emailController.text, passwordController.text);
                      print(user!.email);
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
}
