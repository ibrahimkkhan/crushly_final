import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Widget child;

  AnimatedButton({required this.child});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late double _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTap: () {
        print('onTap');
      },
//onLongPress: _onTapDown,
//onLongPressEnd: _onTapUp,
//      onTap: () => _onTapDown(null),
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  void _onTapDown(TapDownDetails details) async {
    print('_onTapDown');
    _controller.forward();
    Future.delayed(Duration(milliseconds: 200), () {
      _onTapUp(null);
    });
  }

  void _onTapUp(TapUpDetails? details) {
    print('_onTapUp');
    _controller.reverse();
  }

  Widget get _animatedButtonUI => Container(
        height: 100,
        width: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
//      boxShadow: [ shadow ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA7BFE8),
              Color(0xFF6190E8),
            ],
          ),
        ),
        child: Center(
          child: Text(
            'tap!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
}
