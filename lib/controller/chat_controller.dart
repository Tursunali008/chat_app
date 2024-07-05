
import 'package:chat_app/services/chat_services.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  final _chatFirebaseServices = ChatFirebaseServices();

  Stream<QuerySnapshot> get list2 {
    return _chatFirebaseServices.getMessages();
  }
}