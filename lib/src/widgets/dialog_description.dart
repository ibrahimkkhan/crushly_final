import 'package:flutter/material.dart';

class DialogDescription extends StatelessWidget {
  //
  DialogDescription({this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
