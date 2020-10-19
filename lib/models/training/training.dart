import 'package:boilerplate/models/training/training_exercise.dart';
import 'package:boilerplate/utils/helpers/db_serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

DbSerializer _serializer;

class Training implements SerializableInterface {
  final String sport;
  final String name;
  final List<TrainingExercise> exercises;

  Training({
    this.sport,
    this.name,
    this.exercises,
  });

  factory Training.fromDocument(DocumentSnapshot doc) {
    return Training(
      sport: doc['sport'],
      name: doc['name'],
      exercises: doc['exercises'],
    );
  }

  Map<String, dynamic> toJson() => {
        'sport': sport,
        'name': name,
        'exercises': _serializer.manyToJson(exercises),
      };
}
