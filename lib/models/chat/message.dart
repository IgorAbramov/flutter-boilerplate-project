import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

class Message implements SerializableInterface {
  final String chatId;
  final String senderId;
  final String text;
  final FieldValue createdAt;

  Message({this.chatId, this.senderId, this.text, this.createdAt});

  factory Message.fromDocument(DocumentSnapshot doc) {
    return Message(
        chatId: doc['chat_id'],
        senderId: doc['sender_id'],
        text: doc['text'],
        createdAt: doc['created_at']);
  }

  Map<String, dynamic> toJson() => {
        'chat_id': chatId,
        'sender_id': senderId,
        'text': text,
        'created_at': createdAt,
      };
}
