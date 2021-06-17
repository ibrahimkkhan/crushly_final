import '../utils/utils.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class BigTxt extends StatelessWidget {
  //
  BigTxt({
    this.text,
    this.fontFamily = Fonts.POPPINS,
  });
  final String? text;
  final String fontFamily;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: darkBlue,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
