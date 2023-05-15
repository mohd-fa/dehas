import 'package:flutter/material.dart';
import 'package:womensafety/authenticate/sign_in.dart';
import 'package:womensafety/services/auth.dart';
import 'package:womensafety/screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return StreamBuilder(stream: auth.authStateChanges,builder: (context, snapshot) => snapshot.hasData ? Home() : const SignIn(), );
  }
}