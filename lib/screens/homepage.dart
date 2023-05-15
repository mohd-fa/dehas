import 'dart:io';

import 'package:flutter/material.dart';
import 'package:womensafety/models/contact.dart';
import 'package:womensafety/screens/contactelem.dart';
import 'package:womensafety/services/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = AuthService();

  List<Contact> contacts = [
    Contact(name: 'hai'),
    Contact(name: 'hai'),
    Contact(name: 'hai'),
    Contact(name: 'hai')
  ];
  bool smsbool = true;
  bool dronebool = true;

  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        children: [
          SosButton(heigth: heigth, width: width),
          SizedBox(height: 10),
          ContactCard(contacts: contacts),
          SizedBox(
            height: 8,
          ),
          Row(children: [
            Expanded(
              child: DroneCard(dronebool: dronebool),
            ),
            Expanded(
              child: SmsCard(smsbool: smsbool),
            ),
          ]),
          SizedBox(height: 10,),
          Center(
              child: ElevatedButton(
            child: const Text("Sign Out"),
            onPressed: auth.signOut,
          )),
        ],
      ),
    );
  }
}

class SmsCard extends StatelessWidget {
  const SmsCard({
    super.key,
    required this.smsbool,
  });

  final bool smsbool;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('SMS Service',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Icon(
                Icons.sms,
                size: 50,
              ),
              Switch(
                activeColor: Colors.red,
                splashRadius: 40.0,
                value: smsbool,
                onChanged: (value) {
                    if(value) {
                      showDialog(context: context, builder: (context) => AlertDialog(content: Text('SMS service currently not available.'),title: Text('Coming Soon'),));
                      sleep(Duration(seconds: 2));
                    }},

                    
              ),
              
            ]),
      ),
    );
  }
}

class DroneCard extends StatelessWidget {
  const DroneCard({
    super.key,
    required this.dronebool,
  });

  final bool dronebool;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Drone Service',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/drone.png',
                height: 50,
              ),
              Switch(
                activeColor: Colors.red,
                splashRadius: 40.0,
                value: dronebool,
                onChanged: (value) {
                    if(value) {
                      showDialog(context: context, builder: (context) => AlertDialog(content: Text('Drone service currently not available.'),title: Text('Coming Soon')));
                      sleep(Duration(seconds: 2));
                    }},

                    
              ),
            ]),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
    required this.contacts,
  });

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        margin: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              Text('Emergency Contacts',
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              SizedBox(
                height: 10,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: contacts
                          .map((e) => ContactElem(
                                name: e.name,
                              ))
                          .toList() +
                      [
                        ContactElem(
                          add: true,
                        )
                      ]),
            ],
          ),
        ));
  }
}

class SosButton extends StatelessWidget {
  const SosButton({
    super.key,
    required this.heigth,
    required this.width,
  });

  final double heigth;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(0),
      color: Colors.red[100],
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bg1.jpg'),
                    fit: BoxFit.cover)),
            padding: EdgeInsets.only(top: heigth / 10, bottom: 15),
            height: heigth / 4,
            width: width,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 5),
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 220, 0, 0)),
              child: Icon(
                Icons.sos_rounded,
                color: Colors.white,
                size: heigth / 10,
              ),
            )),
        Positioned.fill(
          child: Material(
              color: Colors.transparent,
              child: new InkWell(
                onTap: () {},
              )),
        )
      ]),
    );
  }
}
