import 'package:cloud_firestore/cloud_firestore.dart';

class Progress {
  final double value;
  final DateTime date;

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
}
