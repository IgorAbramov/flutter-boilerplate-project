import 'package:boilerplate/models/serializable_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Progress implements SerializableInterface {
  final double value;
  final FieldValue date;

  Progress({
    this.value,
    this.date,
  });

  factory Progress.fromDocument(DocumentSnapshot doc) {
    return Progress(
      value: doc['value'],
      date: doc['date'],
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'value': value,
        'date': date,
      };
}
