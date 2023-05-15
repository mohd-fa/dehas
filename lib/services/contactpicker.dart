import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:womensafety/models/contact.dart' as m;

class ContactPicker{
  var cont = FlutterContactPicker();

  selectcontact() async {
    Contact? contact = await cont.selectContact();
    return contact != null ? m.Contact(name: contact.fullName,number:  contact.phoneNumbers):null;
  }

}