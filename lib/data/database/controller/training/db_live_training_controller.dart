import 'package:boilerplate/data/database/constants/db_constants.dart';
import 'package:boilerplate/data/database/push_id_generator.dart';
import 'package:boilerplate/models/training/live_training.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final DateTime timestamp = DateTime.now();

class DBLiveTrainingsController {
  Future<LiveTraining> initiateLiveTraining(String trainingId) async {
    LiveTraining liveTraining = new LiveTraining(
      id: generatePushId(),
      userId: _auth.currentUser.uid,
      trainingId: trainingId,
      startedAt: FieldValue.serverTimestamp(),
    );
    _fireStore
        .collection(DBConstants.LIVE_TRAININGS_ID)
        .add(liveTraining.toJson());
    return liveTraining;
  }

  getLiveTrainings() async {
    List<LiveTraining> list;
    _fireStore
        .collection(DBConstants.LIVE_TRAININGS_ID)
        .where('userId', isEqualTo: _auth.currentUser.uid)
        .get()
        .then((snapshot) => {
              if (snapshot != null)
                {
                  snapshot.docs.forEach(
                      (doc) => {list.add(LiveTraining.fromDocument(doc))})
                }
            });
    return list;
  }
}
