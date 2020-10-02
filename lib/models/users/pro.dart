import 'package:boilerplate/models/users/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Pro extends User {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;
  final String experience;
  final double rating;
  final double price;
  final String speciality;

  Pro({
    this.id,
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
    this.experience,
    this.rating,
    this.price,
    this.speciality,
  });

  factory Pro.fromDocument(DocumentSnapshot doc) {
    return Pro(
      id: doc['id'],
      email: doc['email'],
      username: doc['username'],
      photoUrl: doc['photoUrl'],
      displayName: doc['displayName'],
      bio: doc['bio'],
      experience: doc['experience'],
      rating: doc['rating'],
      price: doc['price'],
      speciality: doc['speciality'],
    );
  }
}
