import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

class TrainingGroup implements SerializableInterface {
  final String userId;
  final String name;
  final List<dynamic> trainingIds;

  TrainingGroup({
    this.userId,
    this.name,
    this.trainingIds,
  });

  factory TrainingGroup.fromDocument(DocumentSnapshot doc) {
    return TrainingGroup(
      userId: doc['user_id'],
      name: doc['name'],
      trainingIds: doc['trainings'],
    );
  }

  Map<String, dynamic> toJson() => {
        'user_id': userId,
        'name': name,
        'trainings': trainingIds,
      };
}
