import 'package:flutter/material.dart';
import 'package:womensafety/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData( inputDecorationTheme: const InputDecorationTheme(fillColor: Colors.white54, filled: true)),
      home: const Wrapper()
    );
  }
}
