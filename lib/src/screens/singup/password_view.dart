import 'package:flutter/material.dart';

class PasswordView extends StatelessWidget {
  final passwordController = TextEditingController();
  final Function(String) passwordChanged;
  final String password;

  PasswordView({Key? key, required this.passwordChanged, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    passwordController.text = password;
    passwordController.selection = TextSelection(
      baseOffset: password.length,
      extentOffset: password.length,
    );
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24.0, bottom: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My password is...",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 69, 79, 99),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 69, 79, 99),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(60),
            ),
            margin: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20),
            child: Center(
              child: TextField(
                onChanged: passwordChanged,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Type password',
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 69, 79, 99),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }
}
