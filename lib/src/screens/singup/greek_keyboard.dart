import 'package:crushly/Screens/auth/singup/greek_keyboard_letter.dart';
import 'package:crushly/theme.dart';
import 'package:flutter/material.dart';

class GreekKeyboard extends StatefulWidget {
  final Function(String) inputChanged;

  const GreekKeyboard({Key key, @required this.inputChanged}) : super(key: key);

  @override
  _GreekKeyboardState createState() => _GreekKeyboardState();
}

class _GreekKeyboardState extends State<GreekKeyboard> {
  List<dynamic> letters = [
    "Θ",
    "Ω",
    "Ε",
    "Ρ",
    "Τ",
    "Ψ",
    "Υ",
    "Ι",
    "Ο",
    "Π",
    "Α",
    "Σ",
    "Δ",
    "Φ",
    "Γ",
    "Η",
    "Κ",
    "Λ",
    "Ζ",
    "Χ",
    "Ξ",
    "",
    "",
    "Β",
    "Ν",
    "Μ",
    "",
  ];

  String input = '';

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
      ),
      itemCount: 28,
      itemBuilder: (context, index) {
        return index < 27
            ? GreeKeyboardLetter(
                letter: letters[index],
                onPressed: () {
                  setState(() {
                    if(letters[index] != "") {
                      input += letters[index];
                      widget.inputChanged(input);
                      print(letters[index]);
                    }
                  });
                })
            : GestureDetector(
                child: Icon(
                  Icons.backspace,
                  color: pink,
                ),
                onTap: () {
                  setState(
                    () {
                      input = input.substring(0, input.length - 1);
                      widget.inputChanged(input);
                      // print(letters[index]);
                    },
                  );
                },
              );
      },
    );
  }
}
