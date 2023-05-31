import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:location/location.dart';
import 'package:dehas/services/auth.dart';
import 'package:dehas/models/models.dart';
import 'package:dehas/services/location.dart';

final auth = AuthService();

class DataBaseServices {
  final CollectionReference contactF = FirebaseFirestore.instance
      .collection('userData')
      .doc(auth.currentUser!.uid)
      .collection('contacts');
  final CollectionReference locationF = FirebaseFirestore.instance
      .collection('userData')
      .doc(auth.currentUser!.uid)
      .collection('location');

  final CollectionReference user = FirebaseFirestore.instance
      .collection('userData');

  updateContact(Map contact) {
    return contactF
        .doc()
        .set({'name': contact['name'], 'number': contact['number']});
  }

  deleteContact(String? docid) {
    contactF.doc(docid).delete();
  }

  Stream<List<Contact>> getContacts() async* {
    await for (QuerySnapshot data in contactF.snapshots()) {
      yield data.docs.map((e) {
        var m = e.data() as Map;
        return Contact(name: m['name'], number: m['number'], docid: e.id);
      }).toList();
    }
  }

  Future<LocationData> updateLoc() async {
    var t = Timestamp.now();
    var locData = await LocationService().getUploadLoc();
    locationF.doc(t.toDate().toIso8601String()).set({
      'latitude': locData.latitude,
      'longitude': locData.longitude,
      'timestamp': t,
      'uid': auth.currentUser!.uid,

    });
    return locData;
  }

  updateUser(User userdata
     ) async {
    return await user.doc(userdata.uid).set(
        {'type': 0, 'email': userdata.email,});
  }

  updateName(
     ) async {
    return await user.doc(auth.currentUser!.uid).update(
        {'name': auth.currentUser!.displayName,});
  }
}
