import 'package:boilerplate/models/serializable_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sports implements SerializableInterface {
  final String id;
  final String name;

  Sports({
    this.id,
    this.name,
  });

  factory Sports.fromDocument(DocumentSnapshot doc) {
    return Sports(
      id: doc['id'],
      name: doc['name'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
