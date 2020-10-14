import 'package:boilerplate/routes.dart';
import 'package:flutter/material.dart';

class ChatHistory extends StatelessWidget {
  List<Widget> _chats = [];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, position) {
          return Divider();
        },
        itemBuilder: (context, position) {
          return _buildListItem(position, context);
        },
      ),
    );
  }

  Widget _buildListItem(int position, BuildContext context) {
    return GestureDetector(
      onTap: _navigate(context),
      child: ListTile(
        dense: true,
        leading: Icon(
          Icons.chat_bubble_outline,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        title: Text(
          'Dear friend',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
          style: Theme.of(context).textTheme.headline4,
        ),
        subtitle: Text(
          'Hey, Johnny! I\'ve just benched 300 pounds!! Incredible',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          softWrap: false,
        ),
      ),
    );
  }

  _navigate(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(Routes.chat);
  }
}
