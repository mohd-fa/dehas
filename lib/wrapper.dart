import 'package:flutter/material.dart';
import 'package:dehas/authenticate/sign_in.dart';
import 'package:dehas/services/auth.dart';
import 'package:dehas/screens/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return StreamBuilder(
      stream: auth.authStateChanges,
      builder: (context, snapshot) =>
          snapshot.hasData ? const Home() : const SignIn(),
    );
  }
}
