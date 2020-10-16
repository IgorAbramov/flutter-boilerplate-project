import 'package:boilerplate/models/training/set.dart';
import 'package:boilerplate/utils/helpers/db_serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

DbSerializer _serializer;

class TrainingExercise implements SerializableInterface {
  final String name;
  final List<Set> sets;

  TrainingExercise({
    this.name,
    this.sets,
  });

  factory TrainingExercise.fromDocument(DocumentSnapshot doc) {
    return TrainingExercise(
      name: doc['name'],
      sets: doc['sets'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'sets': _serializer.manyToJson(sets),
      };
}
