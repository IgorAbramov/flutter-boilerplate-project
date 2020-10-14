import 'package:boilerplate/models/progress.dart';
import 'package:boilerplate/models/training/training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String userName;
  final String email;
  final String photoUrl;
  final String fullName;
  final bool isPro;
  final DateTime registered;
  final DateTime lastLogin;
  final List<Training> favTrainings;
  final List<Training> trainingHistory;
  final double height;
  final double weight;
  final List<Progress> weightHistory;
  final String country;
  final String city;
  final String bio;
  final String experience;
  final double rating;
  final double price;
  final String speciality;

  AppUser({
    this.id,
    this.userName,
    this.email,
    this.photoUrl,
    this.fullName,
    this.isPro,
    this.registered,
    this.lastLogin,
    this.favTrainings,
    this.trainingHistory,
    this.height,
    this.weight,
    this.weightHistory,
    this.country,
    this.city,
    this.bio,
    this.experience,
    this.rating,
    this.price,
    this.speciality,
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      id: doc['id'],
      userName: doc['userName'],
      email: doc['email'],
      fullName: doc['fullName'],
      photoUrl: doc['photoUrl'],
      isPro: doc['isPro'],
      registered: doc['registered'],
      lastLogin: doc['lastLogin'],
      favTrainings: doc['favTrainings'],
      trainingHistory: doc['trainingHistory'],
      height: doc['height'],
      weight: doc['weight'],
      weightHistory: doc['weightHistory'],
      country: doc['country'],
      city: doc['city'],
      bio: doc['bio'],
      experience: doc['experience'],
      rating: doc['rating'],
      price: doc['price'],
      speciality: doc['speciality'],
    );
  }
}
