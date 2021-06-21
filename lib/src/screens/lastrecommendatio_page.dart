import 'package:flutter/material.dart';
import '../theme/theme.dart';

class LastRecommendationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        gradient: reversedGradient,
      ),
      child: Center(
        child: Text(
          'You\'ve hit the end of the list',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
