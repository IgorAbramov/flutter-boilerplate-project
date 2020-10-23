import 'package:boilerplate/models/training/training_exercise.dart';
import 'package:boilerplate/utils/helpers/db_serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

DbSerializer _serializer;

class Training implements SerializableInterface {
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
      id: doc.id,
      sport: doc['sport'],
      name: doc['name'],
      exercises: doc['exercises'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'sport': sport,
        'name': name,
        'exercises': _serializer.manyToJson(exercises),
      };
}
