import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RoundButtonWidget extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundButtonWidget({
    Key key,
    this.buttonText,
    this.buttonColor,
    this.textColor = Colors.white,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: buttonColor,
      shape: StadiumBorder(),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: Theme.of(context).textTheme.button.copyWith(color: textColor),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final Color color;
  final String title;
  final Function onPressed;

  RoundButton({this.color, this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
        elevation: 5.0,
        color: color,
        shape: CircleBorder(),
        onPressed: onPressed,
        minWidth: 50.0,
        height: 50.0,
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
