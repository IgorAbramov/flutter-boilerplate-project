import 'package:boilerplate/models/training/set.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TrainingExercise {
  final String id;
  final String name;
  final List<Set> sets;

  TrainingExercise({
    this.id,
    this.name,
    this.sets,
  });

  factory TrainingExercise.fromDocument(DocumentSnapshot doc) {
    return TrainingExercise(
      id: doc['id'],
      name: doc['name'],
      sets: doc['sets'],
    );
  }
}
