import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  //
  DialogButton({
    this.text,
    this.onPress,
    this.color = Colors.transparent,
    this.textColor = Colors.purple,
  });
  final String text;
  final Function onPress;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(10.0),
      color: color,
      onPressed: onPress,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          fontSize: 18,
          color: textColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
