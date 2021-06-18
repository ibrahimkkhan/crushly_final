import 'package:auto_size_text/auto_size_text.dart';
import '../theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectableButton extends StatelessWidget {
  final String selectedOption;
  final Function() onClick;
  final String option;

  SelectableButton({
    required this.option,
    required this.selectedOption,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (selectedOption == option) {
      print(selectedOption + " " + option);
      return Container(
        width: screenSize.width,
        height: screenSize.height / 12.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
              width: screenSize.width * 0.006, color: locationButtonColor),
          borderRadius: BorderRadius.circular(screenSize.width / 6.25),
        ),
        padding: EdgeInsets.symmetric(
            vertical: screenSize.height / 60.14,
            horizontal: screenSize.width / 19),
        child: Material(
          color: Colors.transparent,
          shadowColor: Colors.black54,
          child: InkWell(
              onTap: onClick,
              child: AutoSizeText(
                option,
                maxLines: 1,
                style: TextStyle(
                  color: locationButtonColor,
                  fontSize: screenSize.width / 20.78,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ),
      );
    }
    return Container(
      width: screenSize.width,
      height: screenSize.height / 12.5,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(width: screenSize.width * 0.006, color: lightBlue),
        borderRadius: BorderRadius.circular(screenSize.width / 6.25),
      ),
      padding: EdgeInsets.symmetric(vertical: screenSize.height / 60.14),
      child: Material(
        color: Colors.transparent,
        shadowColor: Colors.black54,
        child: InkWell(
          onTap: onClick,
          child: AutoSizeText(
            option,
            maxLines: 1,
            style: TextStyle(
              color: lightBlue,
              fontSize: screenSize.width / 20.78,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
    /*return Material(
      color: Colors.transparent,
      shadowColor: Colors.black12,
      child: InkWell(
        child: GradientContainerBorder(
          onPressed: onClick,
          strokeWidth: screenSize.width * 0.006,
          radius: screenSize.width,
          width: screenSize.width,
          height: screenSize.height / 13.5,
          gradient: appGradient,
          child: Center(
            child: Text(
              option,
              maxLines: 1,
              style: TextStyle(
                color: darkGrey,
                fontSize: screenSize.width / 20.78,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );*/
  }
}
/**/
