import 'package:boilerplate/data/database/constants/db_constants.dart';
import 'package:boilerplate/models/training/training_group.dart';
import 'package:boilerplate/models/users/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final DateTime timestamp = DateTime.now();

class DBTrainingGroupsController {
  Future getTrainingGroups() async {
    return await _fireStore
        .collection(DBConstants.TRAINING_GROUPS_ID)
        .where('user_id', isEqualTo: _auth.currentUser.uid)
        .get()
        .catchError((e) {
      print(e);
    });
  }

  Future<List<dynamic>> getUserTrainingGroupList() async {
    List<dynamic> trainingGroupList = [];
    await _fireStore
        .collection(DBConstants.USERS_ID)
        .doc(_auth.currentUser.uid)
        .get()
        .then((doc) => {
              if (doc != null)
                {
                  trainingGroupList
                      .add(AppUser.fromDocument(doc).trainingGroups)
                }
            });
    return trainingGroupList;
  }

  addTrainingGroup(String name) async {
    TrainingGroup trainingGroup = new TrainingGroup(
        userId: _auth.currentUser.uid, name: name, trainingIds: []);
    DocumentReference docRef = await _fireStore
        .collection(DBConstants.TRAINING_GROUPS_ID)
        .add(trainingGroup.toJson())
        .catchError((e) {
      print(e);
    });

    await _fireStore
        .collection(DBConstants.USERS_ID)
        .doc(_auth.currentUser.uid)
        .update({
      'training_groups': FieldValue.arrayUnion([docRef.id])
    }).catchError((e) {
      print(e);
    });
  }

  deleteTrainingGroup(String docId, String name) async {
    _fireStore
        .collection(DBConstants.TRAINING_GROUPS_ID)
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });

    await _fireStore
        .collection(DBConstants.USERS_ID)
        .doc(_auth.currentUser.uid)
        .update({
      'training_groups': FieldValue.arrayRemove([docId])
    }).catchError((e) {
      print(e);
    });
  }
}
