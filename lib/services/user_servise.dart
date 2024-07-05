import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserFirebaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUsers() async* {
    yield* _firestore.collection('users').snapshots();
  }

  void addUser(String name) {
    Map<String, dynamic> data = {
      "user-name": name,
      'user-email': FirebaseAuth.instance.currentUser!.email,
    };
    _firestore.collection('users').add(data);
  }
}