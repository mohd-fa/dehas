import 'package:flutter/material.dart';
import 'package:dehas/models/models.dart';
import 'package:dehas/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:dehas/screens/homecards.dart';
import 'package:dehas/services/database.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final db = DataBaseServices();

    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    List<Contact> contacts = [];

    return Provider<String>.value(
      value: '+915555555555',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              SosButton(heigth: heigth, width: width),
              const SizedBox(height: 10),
              const ContactCard(),
              const SizedBox(
                height: 8,
              ),
              Row(children: const [
                Expanded(
                  child: DroneCard(),
                ),
                Expanded(
                  child: SmsCard(),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Center(
                  child: ElevatedButton(
                onPressed: auth.signOut,
                child: const Text("Sign Out"),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
