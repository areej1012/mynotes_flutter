import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mynotes/View/loginView.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';
import 'dart:developer' as devtools show log;

import 'package:mynotes/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: "Password"),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                 await FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: email, password: password);
                final user = FirebaseAuth.instance.currentUser;
                if(user?.emailVerified ?? false) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, notesRoute, (route) => false);
                }else{
                   Navigator.pushNamedAndRemoveUntil(
                     context, verifyEmailRoute, (route) => false);
                }
                devtools.log(user.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == "user-not-found") {
                 await showErrorDialog(context, "The user not found");
                 // devtools.log("Not found");
                }
                else if (e.code == 'wrong-password') {
                  await showErrorDialog(context, "Wrong password");
                }
                else {
                  await showErrorDialog(context, "Error ${e.code}");
                  //devtools.log("something bad");
                }
              }
              catch (e){
                 await showErrorDialog(context, e.toString());
              }
            },
            child: const Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: const Text("Register"))
        ],
      ),
    );
  }
}


