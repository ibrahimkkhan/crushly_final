import 'package:flutter/material.dart';

class DialogTitle extends StatelessWidget {
  //
  DialogTitle({required this.text, this.fontWeight = FontWeight.normal});
  final String text;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      style: TextStyle(
        fontSize: 20,
        fontWeight: fontWeight,
      ),
    );
  }
}
