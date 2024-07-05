
import 'package:chat_app/services/user_servise.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final _chatFirebaseServices = UserFirebaseServices();

  Stream<QuerySnapshot> get list {
    return _chatFirebaseServices.getUsers();
  }
}