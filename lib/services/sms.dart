import 'package:flutter_sms/flutter_sms.dart';
import 'package:location/location.dart';
import 'package:dehas/models/models.dart';
class SMSService{
  
  sendMessage(List<Contact> contacts, LocationData location) async {
  
    
      List<String> phone = [];
      for (var i in contacts){
        if (i.isSMS){
          phone.add(i.number);
        }
      }
      
    await sendSMS(message: "This message is form an alert app in my phone. \nI am in Danger here.\n\nMy location: https://maps.google.com/?q=${location.latitude},${location.longitude}", recipients: phone,sendDirect: true);
  }
  sendMessageAdmin(String number,LocationData location) async {
      
    await sendSMS(message: "This message is form an alert app in my phone. \nI am in Danger here.\n\nMy location: https://maps.google.com/?q=${location.latitude},${location.longitude}", recipients: [number],sendDirect: true);
  }
}