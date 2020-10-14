import 'package:boilerplate/data/database/constants/db_constants.dart';
import 'package:boilerplate/models/users/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
final DateTime timestamp = DateTime.now();

class DBUserController {
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
        .get();
    print(doc.docs.toString());
    return (doc.docs.length > 0) ? true : false;
  }

  addMessage(String messageText, String sender) {
    _fireStore.collection('messages').add(
        {'text': messageText, 'sender': sender, 'timeStamp': DateTime.now()});
  }

  addUser(AppUser user, String uid) async {
    await _fireStore.collection('${DBConstants.USERS_ID}').doc('$uid').set({
      "id": user.id,
      "email": user.email,
      "userName": user.userName,
      "photoUrl": user.photoUrl,
      "isPro": user.isPro,
      "registered": user.registered,
      "lastLogin": user.lastLogin,
      "height": user.height,
      "weight": user.weight,
      "weightHistory": user.weightHistory,
      "bio": user.bio,
      "experience": user.experience,
      "rating": user.rating,
      "price": user.price,
      "speciality": user.speciality,
      "timestamp": timestamp,
    });
  }
}
