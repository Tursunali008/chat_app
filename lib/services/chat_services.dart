import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseServices {
  final _chatCollection = FirebaseFirestore.instance.collection("messages");

  Stream<QuerySnapshot> getMessages() {
    return _chatCollection.snapshots();
  }

  Future<void> sendMessage(
      String fromUserId, String toUserId, String text) async {
    try {
      // Firestore instance
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Adding new document to the messages collection
      await firestore.collection('messages').add({
        'fromUserId': fromUserId,
        'toUserId': toUserId,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(), // storing the timestamp
      });
    } catch (e) {
      // Print the error for debugging
      print('Error sending message: $e');
    }
  }
}