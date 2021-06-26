import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../theme.dart';

class OTPage extends StatelessWidget {
  final Function(String) otpCall;
  final onTap;
  final String email;
  final String error;

  OTPage({
    this.onTap,
    this.error,
    this.otpCall,
    this.email,
  });

  final FocusNode _first = FocusNode();
  final FocusNode _second = FocusNode();
  final FocusNode _third = FocusNode();
  final FocusNode _forth = FocusNode();
  TextEditingController _textEditingController = new TextEditingController();
  TextEditingController _textEditingController1 = new TextEditingController();
  TextEditingController _textEditingController2 = new TextEditingController();
  TextEditingController _textEditingController3 = new TextEditingController();
  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: screenSize.height / 9.02, bottom: screenSize.height / 27.06),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                TextSpan(
                    text: 'Please enter the\n',
                    style: TextStyle(color: darkBlue)),
                TextSpan(
                    text: '4-digit ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: darkBlue)),
                TextSpan(
                    text: 'OTP you received on\n',
                    style: TextStyle(color: darkBlue)),
                TextSpan(text: email, style: TextStyle(color: pink)),
                TextSpan(text: " "),
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        otpCall("back");
                      },
                    text: "Change email",
                    style: TextStyle(
                        color: darkBlue, decoration: TextDecoration.underline)),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: screenSize.width / 5.5,
              vertical: screenSize.height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _otpBoxes(
                controller: _textEditingController,
                context: context,
                screenSize: screenSize,
                focusNode: _first,
                onChange: (value) {
                  otpCall(value);
                  _fieldFocusChange(context, _first, _second);
                },
                error: error,
              ),
              _otpBoxes(
                controller: _textEditingController1,
                context: context,
                screenSize: screenSize,
                focusNode: _second,
                onChange: (value) {
                  otpCall(value);
                  _fieldFocusChange(context, _second, _third);
                },
                error: error,
              ),
              _otpBoxes(
                controller: _textEditingController2,
                context: context,
                screenSize: screenSize,
                focusNode: _third,
                onChange: (value) {
                  otpCall(value);
                  _fieldFocusChange(context, _third, _forth);
                },
                error: error,
              ),
              _otpBoxes(
                controller: _textEditingController3,
                context: context,
                screenSize: screenSize,
                focusNode: _forth,
                onChange: (value) {
                  otpCall(value);
                  _fieldFocusChange(context, _forth, null);
                },
                error: error,
              )
            ],
          ),
        ),
        SizedBox(
          height: screenSize.height * 0.07,
        ),
        Text(
          error != null ? error : "",
          style: TextStyle(color: redError),
        ),
        SizedBox(
          height: screenSize.height * 0.07,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Didn't receive an OTP?",
              style: TextStyle(color: pink),
            ),
            Text(" "),
            ArgonTimerButton(
              height: screenSize.height / 40,
              width: screenSize.width / 3.75,
              minWidth: screenSize.width / 3.75,
              color: Colors.transparent,
              borderRadius: 0,
              elevation: 0,
              child: Text(
                "Resend Code",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: resendColor),
              ),
              loader: (timeLeft) {
                return Text(
                  "Wait $timeLeft sec",
                  style: TextStyle(
                      decoration: TextDecoration.underline, color: resendColor),
                );
              },
              onTap: (startTimer, btnState) {
                if (btnState == ButtonState.Idle) {
                  onTap();
                  _textEditingController.clear();
                  _textEditingController1.clear();
                  _textEditingController2.clear();
                  _textEditingController3.clear();
                  startTimer(120);
                }
              },
            ),
            /*GestureDetector(
              onTap: onTap,
              child: Text(
                "Resend code",
                style: TextStyle(
                    decoration: TextDecoration.underline, color: pink),
              ),
            )*/
          ],
        )
      ],
    );
  }
}

_otpBoxes({context, screenSize, focusNode, onChange, controller, error}) {
  print(error);
  return Container(
    width: screenSize.width * 0.12,
    height: screenSize.height * 0.08,
    decoration: BoxDecoration(
        color: boxColor,
        border:
            Border.all(color: error.isEmpty ? Colors.transparent : errorRed),
        borderRadius: BorderRadius.circular(screenSize.height * 0.015)),
    child: Padding(
      padding: EdgeInsets.symmetric(
          vertical: screenSize.height * 0.01,
          horizontal: screenSize.width * 0.033),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        onChanged: onChange,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        showCursor: false,
        style: TextStyle(
          fontSize: screenSize.height * 0.04,
        ),
        decoration: null,
      ),
    ),
  );
}
