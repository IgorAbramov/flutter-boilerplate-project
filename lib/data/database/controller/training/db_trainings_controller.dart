import 'package:boilerplate/data/database/constants/db_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final DateTime timestamp = DateTime.now();

class DBTrainingsController {
  Stream trainingsStream<QuerySnapshot>() {
    return _fireStore
        .collection('${DBConstants.TRAININGS_ID}')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }
}
