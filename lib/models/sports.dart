import 'package:boilerplate/models/training/exercise.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sports {
  final String id;
  final String name;
  final List<Exercise> exercises;

  Sports({
    this.id,
    this.name,
    this.exercises,
  });

  factory Sports.fromDocument(DocumentSnapshot doc) {
    return Sports(
      id: doc['id'],
      name: doc['name'],
      exercises: doc['exercises'],
    );
  }
}
