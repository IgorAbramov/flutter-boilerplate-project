import 'package:boilerplate/data/database/constants/db_constants.dart';
import 'package:boilerplate/models/chat/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireStore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;

class DBChatController {
  createChat() {}

  addMessage(String chatId, String uid, String text) {
    Message message = new Message(
        chatId: chatId,
        senderId: uid,
        text: text,
        createdAt: FieldValue.serverTimestamp());
    _fireStore.collection(DBConstants.MESSAGES_ID).add(message.toJson());
  }

  Stream messagesStream<QuerySnapshot>(String chatId) {
    return _fireStore
        .collection('${DBConstants.MESSAGES_ID}')
        .where('chat_id', isEqualTo: chatId)
        .orderBy('created_at', descending: true)
        .snapshots();
  }
}
