import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:dehas/models/models.dart' as m;
import 'package:dehas/services/database.dart';

class ContactPicker{
  final cont = FlutterContactPicker();
  final  db = DataBaseServices();
  Future<m.Contact?> _selectContact() async {
    Contact? contact = await cont.selectContact();
    return contact != null ? m.Contact(name: contact.fullName,number:  contact.phoneNumbers?[0]??"0"):null;
  }

  uploadContact() async {
    m.Contact? contact = await _selectContact();
    if (contact != null){
       return db.updateContact(contact);
    }
  }

}