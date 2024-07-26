import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getEmergenci() async {
  List emergenci = [];
  CollectionReference collectionReferenceEmergenci = db.collection('people');

  QuerySnapshot queryEmergenci = await collectionReferenceEmergenci.get();

  queryEmergenci.docs.forEach((element) {
    final Map<String, dynamic> data = element.data() as Map<String, dynamic>;
    final emergenciData = {
      "name": data['name'],
      "lastname": data['lastname'],
      "message": data['message'],
      "latitude": data['latitude'],
      "longitude": data['longitude'],
      "uid": element.id
    };
    emergenci.add(emergenciData);
  });

  return emergenci;
}

Future<void> addEmergenci(String name, String lastname, String message,
    double latitude, double longitude) async {
  await db.collection('people').add({
    'name': name,
    'lastname': lastname,
    'latitude': latitude,
    'message': message,
    'longitude': longitude
  });
}

Future<void> deleteEmergenci(String uid) async {
  await db.collection('people').doc(uid).delete();
}
