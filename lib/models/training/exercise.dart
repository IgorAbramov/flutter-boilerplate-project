import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

class Exercise implements SerializableInterface {
  final String sportId;
  final String name;
  final String technique;
  final String imageUrl;
  final String videoUrl;
  final List<String> measures; // ('sets', 'reps', 'rounds', 'laps')

  Exercise({
    this.sportId,
    this.name,
    this.technique,
    this.imageUrl,
    this.videoUrl,
    this.measures,
  });

  factory Exercise.fromDocument(DocumentSnapshot doc) {
    return Exercise(
      sportId: doc['sport_id'],
      name: doc['name'],
      technique: doc['technique'],
      imageUrl: doc['image_url'],
      videoUrl: doc['video_url'],
      measures: doc['measures'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sport_id': sportId,
        'name': name,
        'technique': technique,
        'image_url': imageUrl,
        'video_url': videoUrl,
        'measures': measures,
      };
}
