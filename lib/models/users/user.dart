import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String email;
  final bool isPro;

  User({
    this.id,
    this.email,
    this.isPro,
  });

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc['id'],
      email: doc['email'],
      isPro: doc['isPro'],
    );
  }
}
