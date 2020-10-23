import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

class AppUser implements SerializableInterface {
  final String id;
  final String userName;
  final String email;
  final String photoUrl;
  final String fullName;
  final bool isPro;
  final DateTime registered;
  final DateTime lastLogin;
  final List<String> trainingGroups;
  final List<String> favTrainings;
  final List<String> trainingHistory;
  final double height;
  final double weight;
  final List<String> weightHistory;
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
    this.trainingGroups,
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
      userName: doc['user_name'],
      email: doc['email'],
      fullName: doc['full_name'],
      photoUrl: doc['photo_url'],
      isPro: doc['is_pro'],
      registered: doc['registered'],
      lastLogin: doc['last_login'],
      favTrainings: doc['fav_trainings'],
      trainingGroups: doc['training_groups'],
      trainingHistory: doc['training_history'],
      height: doc['height'],
      weight: doc['weight'],
      weightHistory: doc['weight_history'],
      country: doc['country'],
      city: doc['city'],
      bio: doc['bio'],
      experience: doc['experience'],
      rating: doc['rating'],
      price: doc['price'],
      speciality: doc['speciality'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'user_name': userName,
        'email': email,
        'full_name': fullName,
        'photo_url': photoUrl,
        'is_pro': isPro,
        'registered': registered,
        'last_login': lastLogin,
        'fav_trainings': favTrainings,
        'training_groups': trainingGroups,
        'training_history': trainingHistory,
        'height': height,
        'weight': weight,
        'weight_history': weightHistory,
        'country': country,
        'city': city,
        'bio': bio,
        'experience': experience,
        'rating': rating,
        'price': price,
        'speciality': speciality,
      };
}
