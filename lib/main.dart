import 'package:flutter/material.dart';
import 'package:womensafety/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return  MaterialApp(
      theme: ThemeData( cardColor: Colors.red[100],
        scaffoldBackgroundColor: Colors.red[300], inputDecorationTheme: const InputDecorationTheme( fillColor: Colors.white54, filled: true)),
      home: const Wrapper()
    );
  }
}
