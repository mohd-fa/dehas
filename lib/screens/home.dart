import 'package:flutter/material.dart';
import 'package:womensafety/services/auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Center(child: ElevatedButton(onPressed: _auth.signOut, child: const Text('Sign Out'),)),);
  }
}