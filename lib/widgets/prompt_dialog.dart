import 'package:flutter/material.dart';
import 'package:material_dialog/material_dialog.dart';

class PromptDialog extends StatelessWidget {
  final List<Widget> children;
  final String title;

  PromptDialog({this.children, this.title});
  @override
  Widget build(BuildContext context) {
    return MaterialDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline3,
      ),
      children: children,
    );
  }
}
