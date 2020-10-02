import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/data/database/controller/db_controller.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/ui/splash/splash.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes.dart';

final _fireStore = Firestore.instance;
DBController _dbController = DBController();

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //stores:---------------------------------------------------------------------
  final _store = FormStore();
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String messageText;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              color: Theme.of(context).textSelectionColor,
              onPressed: () async {
                await SharedPreferences.getInstance().then((preference) async {
                  preference.setBool(Preferences.is_logged_in, false);
                  await _store.logout();
                  Navigator.of(context).pushReplacementNamed(Routes.login);
                });
              }),
        ],
        title: Text('️Chat'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      controller: messageTextController,
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      //Implement send functionality.
                      messageTextController.clear();
                      if (messageText != null || messageText != '') {
                        _dbController.addMessage(
                            messageText, loggedInUser.email);
                        messageText = '';
                      }
                    },
                    color: Theme.of(context).textSelectionColor,
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String sender = '';
    bool senderRepeats = false;
    return StreamBuilder<QuerySnapshot>(
      stream: _dbController.messagesStream(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final Timestamp timeStamp = message.data['timeStamp'];
          (sender == messageSender)
              ? senderRepeats = true
              : senderRepeats = false;
          sender = messageSender;
          final currentUser = loggedInUser.email;

          if (currentUser == messageSender) {}
          final messageBubble = MessageBubble(
            text: messageText,
            sender: messageSender,
            isMe: currentUser == messageSender,
            senderRepeats: senderRepeats,
            timeStamp: timeStamp.toDate(),
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: false,
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;
  final senderRepeats;
  final DateTime timeStamp;

  MessageBubble(
      {this.sender, this.text, this.isMe, this.senderRepeats, this.timeStamp});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (senderRepeats)
          ? EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0)
          : EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          (senderRepeats)
              ? SizedBox()
              : Text(
                  sender,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Theme.of(context).textSelectionColor,
                  ),
                ),
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: <Widget>[
              Material(
                borderRadius: isMe
                    ? BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      )
                    : BorderRadius.only(
                        topRight: Radius.circular(15.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                elevation: 5.0,
                color: isMe ? Colors.lightBlueAccent : Colors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black54,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0, bottom: 2.0),
                child: Text(
                  (timeStamp.toLocal().minute < 10)
                      ? '${timeStamp.toLocal().hour}:0${timeStamp.toLocal().minute}'
                      : '${timeStamp.toLocal().hour}:${timeStamp.toLocal().minute}',
                  style: TextStyle(
                      fontSize: 8,
                      color: (isMe)
                          ? Theme.of(context).textSelectionColor
                          : Theme.of(context).dividerColor),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
