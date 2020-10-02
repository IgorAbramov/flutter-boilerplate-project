import 'package:boilerplate/models/users/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Trainee extends User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;

  Trainee({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
  });

  factory Trainee.fromDocument(DocumentSnapshot doc) {
    return Trainee(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
    );
  }
}
