import 'package:boilerplate/data/database/constants/db_constants.dart';
import 'package:boilerplate/models/users/pro.dart';
import 'package:boilerplate/models/users/trainee.dart';
import 'package:boilerplate/models/users/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = Firestore.instance;
final _auth = FirebaseAuth.instance;
final DateTime timestamp = DateTime.now();

class DBController {
  Stream messagesStream<QuerySnapshot>() {
    return _fireStore
        .collection('${DBConstants.MESSAGES_ID}')
        .orderBy('timeStamp', descending: true)
        .snapshots();
  }

  Future<bool> checkUser(String email) async {
    QuerySnapshot doc = await _fireStore
        .collection('${DBConstants.USERS_ID}')
        .where('email', isEqualTo: email)
        .getDocuments();
    print(doc.documents.toString());
    return (doc.documents.length > 0) ? true : false;
  }

  addMessage(String messageText, String sender) {
    _fireStore.collection('messages').add(
        {'text': messageText, 'sender': sender, 'timeStamp': DateTime.now()});
  }

  addPro(Pro pro, String uid) async {
    await _fireStore
        .collection('${DBConstants.PROS_ID}')
        .document('$uid')
        .setData({
      "id": pro.id,
      "username": pro.username,
      "photoUrl": pro.photoUrl,
      "email": pro.email,
      "displayName": pro.displayName,
      "bio": pro.bio,
      "experience": pro.experience,
      "rating": pro.rating,
      "price": pro.price,
      "speciality": pro.speciality,
      "timestamp": timestamp
    });
  }

  addTrainee(Trainee user, String uid) async {
    await _fireStore
        .collection('${DBConstants.TRAINEES_ID}')
        .document('$uid')
        .setData({
      "id": user.id,
      "username": user.username,
      "photoUrl": user.photoUrl,
      "email": user.email,
      "displayName": user.displayName,
      "timestamp": timestamp
    });
  }

  addUser(User user, String uid) async {
    await _fireStore
        .collection('${DBConstants.USERS_ID}')
        .document('$uid')
        .setData({
      "id": user.id,
      "email": user.email,
      "isTrainer": user.isPro,
      "timestamp": timestamp,
    });
  }
}
