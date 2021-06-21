import '../theme/theme.dart';
import 'package:flutter/material.dart';

class AnimatedCount extends ImplicitlyAnimatedWidget {
  final int count;

  AnimatedCount(
      {Key? key,
      required this.count,
      required Duration duration,
      Curve curve = Curves.linear})
      : super(duration: duration, curve: curve, key: key);

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _AnimatedCountState();
}

class _AnimatedCountState extends AnimatedWidgetBaseState<AnimatedCount> {
  late IntTween _count;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return new Text(
      _count.evaluate(animation).toString(),
      style: TextStyle(
        color: darkBlue,
        fontWeight: FontWeight.bold,
        fontSize: size.height / 40,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor visitor) {
   _count = visitor(
        _count, widget.count, (dynamic value) => new IntTween(begin: value));
  }
}
