import '../theme/theme.dart';
import 'gradient_container_border.dart';
import 'package:flutter/material.dart';

class GenderButton extends StatelessWidget {
  final String selectedOption;
  final Function() onClick;
  final String option;

  GenderButton({
    required this.option,
    required this.selectedOption,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    print(selectedOption);
    final Shader textSelectedGradient =
        appGradient.createShader(Rect.fromLTWH(0.0, 0.0, 30.0, 20.0));

    Color womanColor = pink;
    Color manColor = lightBlue;
    final screenSize = MediaQuery.of(context).size;

    if (option != 'OTHER') {
      if (selectedOption == option) {
        womanColor = Colors.pink;
        manColor = Colors.blue;
      } else {
        womanColor = Colors.grey;
        manColor = Colors.grey;
      }
      return GestureDetector(
        onTap: onClick,
        child: Container(
          height: screenSize.height / 13.5,
          width: screenSize.width,
          decoration: BoxDecoration(
              border: Border.all(
                  color: (option == 'WOMAN' || option == 'WOMEN')
                      ? womanColor
                      : manColor,
                  width: screenSize.width * 0.006),
              borderRadius: BorderRadius.circular(screenSize.width / 6.25)),
          child: Center(
            child: Text(
              option,
              style: TextStyle(
                color: (option == 'WOMAN' || option == 'WOMEN')
                    ? womanColor
                    : manColor,
                fontSize: screenSize.width / 20.78,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }
    return Material(
      color: Colors.transparent,
      shadowColor: Colors.black12,
      child: GradientContainerBorder(
        onPressed: onClick,
        strokeWidth: screenSize.width * 0.006,
        radius: screenSize.width,
        width: screenSize.width,
        height: screenSize.height / 13.5,
        gradient: selectedOption == option ? appGradient : greyGradient,
        child: Center(
          child: Text(option,
              maxLines: 1,
              style: option == selectedOption
                  ? TextStyle(
                      foreground: Paint()..shader = textSelectedGradient,
                      fontSize: screenSize.width / 20.78,
                      fontWeight: FontWeight.bold,
                    )
                  : TextStyle(
                      color: Colors.grey,
                      fontSize: screenSize.width / 20.78,
                      fontWeight: FontWeight.bold,
                    )),
        ),
      ),
    );
  }
}
/*if (selectedOption == option)
      return Container(
        width: screenSize.width,
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: appGradient,
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          color: Colors.transparent,
          shadowColor: Colors.black54,
          child: InkWell(
            onTap: onClick,
            child: Text(
              option,
              maxLines: 1,
              style: TextStyle(
                color: white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      );*/
