import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String email;
  final bool isPro;

  AppUser({
    this.id,
    this.email,
    this.isPro,
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      id: doc['id'],
      email: doc['email'],
      isPro: doc['isPro'],
    );
  }
}
