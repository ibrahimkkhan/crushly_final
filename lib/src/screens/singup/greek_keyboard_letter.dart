import 'package:crushly/theme.dart';
import 'package:flutter/material.dart';

class GreeKeyboardLetter extends StatefulWidget {
  final String letter;

  final Function onPressed;

  const GreeKeyboardLetter({Key key, this.letter, this.onPressed})
      : super(key: key);

  @override
  _GreeKeyboardLetterState createState() => _GreeKeyboardLetterState();
}

class _GreeKeyboardLetterState extends State<GreeKeyboardLetter> {
  Color fillColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onHighlightChanged: (isHighlight) {
        if (isHighlight && widget.letter != "")
          setState(() {
            fillColor = yellow;
          });
        else
          setState(() {
            fillColor = Colors.transparent;
          });
      },
      onPressed: () {
        widget.onPressed();
      },
      fillColor: fillColor,
      highlightElevation: 0,
      hoverElevation: 0,
      disabledElevation: 0,
      focusElevation: 0,
      highlightColor: Colors.transparent,
      elevation: 0,
      shape: CircleBorder(),
      child: Text(
        widget.letter,
        style: TextStyle(
          fontSize: 20,
          color: fillColor == Colors.transparent ? lightBlue : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
