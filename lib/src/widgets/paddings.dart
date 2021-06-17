import 'package:flutter/material.dart';

class BottomPadding extends StatelessWidget {
  final double padding;

  const BottomPadding(
    this.padding, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: padding),
    );
  }
}

class TopPadding extends StatelessWidget {
  final double padding;

  const TopPadding(
    this.padding, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
    );
  }
}

class LeftPadding extends StatelessWidget {
  final double padding;

  const LeftPadding(
    this.padding, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
    );
  }
}
