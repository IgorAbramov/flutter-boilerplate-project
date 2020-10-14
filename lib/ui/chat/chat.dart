import 'package:boilerplate/constants/app_theme.dart';
import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/data/database/controller/db_user_controller.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../routes.dart';

final _fireStore = FirebaseFirestore.instance;
DBUserController _dbController = DBUserController();

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //stores:---------------------------------------------------------------------
  final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  String messageText;

  void _getCurrentUser() async {
    try {
      final user = _auth.currentUser;
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
    _getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          color: Theme.of(context).scaffoldBackgroundColor,
          onPressed: () =>
              Navigator.of(context).pushReplacementNamed(Routes.home),
        ),
        title: Text(
          '️Chat',
          style: Theme.of(context).textTheme.headline3,
        ),
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
                      style: Theme.of(context).textTheme.headline4,
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
                    color: Theme.of(context).scaffoldBackgroundColor,
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
              backgroundColor: Theme.of(context).accentColor,
            ),
          );
        }
        final messages = snapshot.data.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data()['text'];
          final messageSender = message.data()['sender'];
          final Timestamp timeStamp = message.data()['timeStamp'];
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
                  style: Theme.of(context).textTheme.subtitle1,
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
                color: isMe ? AppColors.lightBlue : AppColors.white,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: isMe ? AppColors.white : AppColors.gray,
                      fontSize: Dimens.font_size_headline4,
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
                      fontSize: Dimens.font_size_subtitle2,
                      color: (isMe)
                          ? Theme.of(context).scaffoldBackgroundColor
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
