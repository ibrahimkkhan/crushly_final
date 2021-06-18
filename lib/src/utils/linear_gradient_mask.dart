import '../theme/theme.dart';
import 'package:flutter/material.dart';

class LinearGradientMask extends StatelessWidget {
  LinearGradientMask({required this.child, this.active = true, this.error = false});

  final Widget child;
  final bool active;
  final bool error;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return RadialGradient(
          center: Alignment.bottomCenter,
          radius: 0.7,
          colors: !active
              ? [
                  Color(0xFFC3C8D1),
                  Color(0xFFC3C8D1),
                ]
              : error
                  ? [
                      errorRed,
                      errorRed,
                    ]
                  : [
                      Color(0xFFFA709A),
                      Color(0xFF2D9CDB),
                    ],
          tileMode: TileMode.mirror,
        ).createShader(bounds);
      },
      child: child,
    );
  }
}
