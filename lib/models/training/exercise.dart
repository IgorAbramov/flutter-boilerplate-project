import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  final String id; //first 3digits - sport Id, last 5 - exercise id)
  final String name;
  final String technique;
  final String imageUrl;
  final String linkToVideo;
  final List<String> measures; // ('sets', 'reps', 'rounds', 'laps')

  Exercise({
    this.id,
    this.name,
    this.technique,
    this.imageUrl,
    this.linkToVideo,
    this.measures,
  });

  factory Exercise.fromDocument(DocumentSnapshot doc) {
    return Exercise(
      id: doc['id'],
      name: doc['name'],
      technique: doc['technique'],
      imageUrl: doc['imageUrl'],
      linkToVideo: doc['linkToVideo'],
      measures: doc['measures'],
    );
  }
}
