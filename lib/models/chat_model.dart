import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String id;
  final String senderId;
  final String text;
  final Timestamp timestamp;

 const  Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.timestamp,
  });

  factory Message.fromQuerySnapshot(QueryDocumentSnapshot query) {
    return Message(
      id: query.id,
      senderId: query['sender-email'] ?? 'unknown',
      text: query['text'] ?? '',
      timestamp: query['time-stamp'] ?? Timestamp.now(),
    );
  }
}