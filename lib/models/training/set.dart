import 'package:cloud_firestore/cloud_firestore.dart';

class Set {
  final String id;
  final bool completed;
  final int reps;
  final double count;

  Set({
    this.id,
    this.completed,
    this.reps,
    this.count,
  });

  factory Set.fromDocument(DocumentSnapshot doc) {
    return Set(
      id: doc['id'],
      completed: doc['completed'],
      reps: doc['reps'],
      count: doc['count'],
    );
  }
}
