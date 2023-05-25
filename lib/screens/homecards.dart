import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:dehas/models/models.dart';
import 'package:dehas/screens/contactelem.dart';
import 'package:provider/provider.dart';
import 'package:dehas/services/contactpicker.dart';
import 'package:dehas/services/database.dart';
import 'package:dehas/services/sms.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SmsCard extends StatefulWidget {
  const SmsCard({
    super.key,
  });
  @override
  State<SmsCard> createState() => _SmsCardState();
}

class _SmsCardState extends State<SmsCard> {
bool smsFlag = true;
  @override
  Widget build(BuildContext context) {
    late SharedPreferences pref;
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if( snapshot.hasData){
          pref = snapshot.data!;
          smsFlag = pref.getBool('SMS')??true;
        }
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text('SMS Service',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              const Icon(
                Icons.sms,
                size: 50,
              ),
              Switch(
                activeColor: Colors.red,
                splashRadius: 40.0,
                value: smsFlag,
                onChanged: (value) async{
                  setState(()  {
                    smsFlag = value;
                  });
                    await pref.setBool('SMS', value);
                    
                },
              ),
            ]),
          ),
        );
      }
    );
  }
}

class DroneCard extends StatefulWidget {
  const DroneCard({
    super.key,
  });

  @override
  State<DroneCard> createState() => _DroneCardState();
}

class _DroneCardState extends State<DroneCard> {
  @override
  Widget build(BuildContext context) {
    late SharedPreferences pref;
    bool droneFlag = true;
    SharedPreferences.getInstance().then((value) {
      pref = value;
      droneFlag = pref.getBool('drone') ?? false;
    });
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Drone Service',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          const SizedBox(
            height: 10,
          ),
          Image.asset(
            'assets/drone.png',
            height: 50,
          ),
          Switch(
            activeColor: Colors.red,
            splashRadius: 40.0,
            value: droneFlag,
            onChanged: (value) {
              if (value) {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                        content: Text('Drone service currently not available.'),
                        title: Text('Coming Soon')));
                sleep(const Duration(seconds: 2));
              }
            },
          ),
        ]),
      ),
    );
  }
}

class ContactCard extends StatefulWidget {
  const ContactCard({super.key});

  @override
  State<ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  final _cp = ContactPicker();

  final _db = DataBaseServices();
  List<Contact> contacts = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, fsnapshot) => StreamBuilder(
          stream: _db.getContacts(),
          builder: (context, snapshot) {
            if (fsnapshot.hasData) {
              SharedPreferences? pref = fsnapshot.data;
              if (snapshot.hasData) {
                contacts = snapshot.data ??
                    pref?.getStringList('contacts')?.map((e) {
                      Map m = jsonDecode(e);
                      return Contact(number: m['number'], name: m['name'],docid: m['docid']);
                    }).toList() ??
                    [];
              } else {
                contacts = pref?.getStringList('contacts')?.map((e) {
                      Map m = jsonDecode(e);
                      return Contact(number: m['number'], name: m['name'],docid: m['docid']);
                    }).toList() ??
                    [];
              }
              pref?.setStringList(
                  'contacts', contacts.map((e) => e.toJstring()).toList());
              return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                        minWidth: double.infinity, minHeight: 100),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Column(
                        children: [
                          const Text('Emergency Contacts',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18)),
                          const SizedBox(
                            height: 10,
                          ),
                          ...contacts
                              .map((e) => ContactElem(
                                    contact: e,
                                  ))
                              .toList(),
                          contacts.length < 5
                              ? TextButton.icon(
                                  onPressed: _cp.uploadContact,
                                  label: const Text('Add Contact'),
                                  icon: const Icon(Icons.person_add))
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ));
            } else {
              return Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(0),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(
                          minWidth: double.infinity, minHeight: 50),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Center(
                            child: SpinKitFadingCircle(
                              color: Colors.blue[300],
                              size: 50,
                            ),
                          ))));
            }
          }),
    );
  }
}

class SosButton extends StatefulWidget {
  const SosButton({
    super.key,
    required this.heigth,
    required this.width,
  });

  final double heigth;
  final double width;

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton> {
  Timer? _timer;
  final _sms = SMSService();
  int _start = 3;
  late bool smsFlag;
  late List<Contact> _contacts;
  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((value) {
      smsFlag = value.getBool('SMS') ?? true;
      _contacts = value.getStringList('contacts')?.map((e) {
            Map m = jsonDecode(e);
            return Contact(number: m['number'], name: m['name'], docid: m['docid']);
          }).toList() ??
          [];
    });
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(0),
      color: Colors.red[100],
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Stack(children: [
        Container(
            padding: EdgeInsets.only(
                top: widget.heigth / 20, bottom: widget.heigth / 20),
            height: widget.heigth / 4,
            width: widget.width,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 5),
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 220, 0, 0)),
              child: _timer == null
                  ? Icon(
                      Icons.sos_rounded,
                      color: Colors.white,
                      size: widget.heigth / 10,
                    )
                  : Text(
                      '$_start',
                      style: TextStyle(
                          color: Colors.white, fontSize: widget.heigth / 10),
                    ),
            )),
        Positioned.fill(
          child: _timer == null
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _start = 3;
                      });
                      const oneSec = Duration(milliseconds: 1500);
                      _timer = Timer.periodic(
                        oneSec,
                        (Timer timer) {
                          if (_start == 0) {
                            var locdata = DataBaseServices().updateLoc();
                            locdata.then((value) {
                              if (smsFlag) {
                                _sms.sendMessageAdmin(
                                    Provider.of<String>(context, listen: false),
                                    value);
                                _sms.sendMessage(_contacts, value);
                              }
                              setState(() {
                                timer.cancel();
                                _timer = null;
                              });
                            });
                          } else {
                            setState(() {
                              _start--;
                            });
                          }
                        },
                      );
                    },
                  ))
              : Container(
                  padding: EdgeInsets.all(widget.width / 10),
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: Color.fromARGB(255, 220, 0, 0),
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        _timer!.cancel();
                        _timer = null;
                      });
                    },
                  )),
        )
      ]),
    );
  }
}
