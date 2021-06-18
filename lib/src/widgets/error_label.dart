import 'package:flutter/material.dart';

class ErrorLabel extends StatelessWidget {
  //
  ErrorLabel({required this.text, this.height = 40, required this.marginInsets});
  final String text;
  final double height;
  final EdgeInsets marginInsets;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginInsets ?? EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: Colors.red,
        ),
      ),
    );
  }
}
