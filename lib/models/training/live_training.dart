import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

class LiveTraining implements SerializableInterface {
  final String id;
  final String userId;
  final String trainingId;
  final FieldValue startedAt;
  final FieldValue finishedAt;

  LiveTraining({
    this.id,
    this.userId,
    this.trainingId,
    this.startedAt,
    this.finishedAt,
  });

  factory LiveTraining.fromDocument(DocumentSnapshot doc) {
    return LiveTraining(
      id: doc['id'],
      userId: doc['user_id'],
      trainingId: doc['training_id'],
      startedAt: doc['started_at'],
      finishedAt: doc['finished_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'training_id': trainingId,
        'started_at': startedAt,
        'finished_at': finishedAt,
      };
}
