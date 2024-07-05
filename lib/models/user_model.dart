
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModels {
  final String id;
  final String name;
  final String email;

  UserModels({
    required this.id,
    required this.name,
    required this.email,
  });

  factory UserModels.fromJson(QueryDocumentSnapshot query) {
    return UserModels(
      id: query.id,
      name: query["user-name"],
      email: query["user-email"],
    );
  }
}
