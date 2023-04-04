import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';


class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("verify email"),),
      body: Column(
        children: [
          const Text("We've sent to you email verification, Please open it to verify your account"),
          const Text("If you haven't received a verification email yet, press the button below"),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: Text('Send email verification'),),
          TextButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(registerRoute, (route) => false);
          }, child: const Text("Reset"))
        ],
      ),
    );
  }
}