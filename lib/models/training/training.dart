import 'package:boilerplate/models/training/training_exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Training {
  final String id;
  final String sport;
  final String name;
  final List<TrainingExercise> exercises;

  Training({
    this.id,
    this.sport,
    this.name,
    this.exercises,
  });

  factory Training.fromDocument(DocumentSnapshot doc) {
    return Training(
      id: doc['id'],
      sport: doc['sport'],
      name: doc['name'],
      exercises: doc['exercises'],
    );
  }
}
