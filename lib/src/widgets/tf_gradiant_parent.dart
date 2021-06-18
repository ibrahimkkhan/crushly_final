import '../utils/gradient_container_border.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class GradientBorder extends StatelessWidget {
  //
  GradientBorder({required this.child, required this.enabledGradient});
  final Widget child;
  final bool enabledGradient;

  @override
  Widget build(BuildContext context) {
    return GradientContainerBorder(
      radius: 40,
      onPressed: (){},
      strokeWidth: 1.0,
      width: MediaQuery.of(context).size.width,
      height: 50,
      gradient: enabledGradient ? appGradient : greyGradient,
      child: child,
    );
  }
}
