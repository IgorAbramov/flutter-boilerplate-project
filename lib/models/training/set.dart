import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

class Set implements SerializableInterface {
  final bool isCompleted;
  final int reps;
  final double count;

  Set({
    this.isCompleted,
    this.reps,
    this.count,
  });

  factory Set.fromDocument(DocumentSnapshot doc) {
    return Set(
      isCompleted: doc['is_completed'],
      reps: doc['reps'],
      count: doc['count'],
    );
  }

  Map<String, dynamic> toJson() => {
        'is_completed': isCompleted,
        'reps': reps,
        'count': count,
      };
}
