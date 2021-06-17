import 'package:flutter/material.dart';

class WidgetUtils {
  //
  static getParentDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(20),
    );
  }
}
