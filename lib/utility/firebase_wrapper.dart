import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_crud/utility/firebase_response.dart';
import 'package:flutter/cupertino.dart';

class FirebaseWrapper {
  FirebaseWrapper._();

  static final _instance = FirebaseWrapper._();

  factory FirebaseWrapper() {
    return _instance;
  }

  late final FirebaseFirestore _firestore;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
  }

  Future<FirebaseResponse> create(String person, String location) async {
    try {
      final querySnapshot = await _firestore
          .collection('person_locations')
          .where('person', isEqualTo: person)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return FirebaseResponse(false,
            error:
                'Person \'$person\' already exists in collection \'person_locations\'');
      }

      await _firestore.collection('person_locations').add({
        'person': person,
        'location': location,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return FirebaseResponse(true);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }

  Future<FirebaseResponse> read(String person) async {
    try {
      final querySnapshot = await _firestore
          .collection('person_locations')
          .where('person', isEqualTo: person)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return FirebaseResponse(false,
            error:
                'Can\'t find Person \'$person\' in collection \'person_locations\'');
      }

      return FirebaseResponse(true,
          location: querySnapshot.docs.first['location']);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }

  Future<FirebaseResponse> update(String person, String location) async {
    try {
      final querySnapshot = await _firestore
          .collection('person_locations')
          .where('person', isEqualTo: person)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return FirebaseResponse(false,
            error:
                'Can\'t find Person \'$person\' in collection \'person_locations\'');
      }

      final docId = querySnapshot.docs.first.id;
      await _firestore
          .collection('person_locations')
          .doc(docId)
          .set({'location': location}, SetOptions(merge: true));

      return FirebaseResponse(true);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }

  Future<FirebaseResponse> delete(String person) async {
    try {
      final querySnapshot = await _firestore
          .collection('person_locations')
          .where('person', isEqualTo: person)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return FirebaseResponse(false,
            error:
                'Can\'t find Person \'$person\' in collection \'person_locations\'');
      }

      final docId = querySnapshot.docs.first.id;
      await _firestore.collection('person_locations').doc(docId).delete();

      return FirebaseResponse(true);
    } catch (e) {
      return FirebaseResponse(false, error: e.toString());
    }
  }
}
