import 'package:cloud_firestore/cloud_firestore.dart';

import '../serializable_interface.dart';

class Chat implements SerializableInterface {
  final String chatId;
  final List<String> participants;

  Chat({this.chatId, this.participants});

  factory Chat.fromDocument(DocumentSnapshot doc) {
    return Chat(
      chatId: doc['chat_id'],
      participants: doc['participants'],
    );
  }

  Map<String, dynamic> toJson() => {
        'chat_id': chatId,
        'participants': participants,
      };
}
