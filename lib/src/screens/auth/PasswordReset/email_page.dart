import 'package:flutter/material.dart';

import '../../../theme.dart';

import 'package:crushly/utils/gradient_container_border.dart';

class EmailPage extends StatefulWidget {
  final bool loading, disable;
  final String error;
  final onTap;
  final Function(String) email;

  EmailPage({
    this.error,
    this.onTap,
    this.disable,
    this.loading,
    this.email,
  });
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  String email = "";

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenSize.height / 9.02,
                        left: screenSize.width / 12.5,
                        bottom: screenSize.height / 27.06),
                    child: Text(
                      "Enter your registered email",
                      style: TextStyle(
                          color: darkBlue,
                          fontSize: screenSize.width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width / 18.75, vertical: 25),
                    margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width / 12.5),
                    width: screenSize.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(screenSize.height * 0.03)),
                    child: GradientContainerBorder(
                      onPressed: () {},
                      radius: screenSize.width / 6.25,
                      height: screenSize.height / 16.91,
                      strokeWidth: 1.0,
                      width: screenSize.width / 1.36,
                      gradient: email.isEmpty ? greyGradient : appGradient,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.0),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            maxLines: 1,
                            onChanged: (value) {
                              widget.email(value);
                            },
                            style: TextStyle(fontSize: screenSize.height / 40),
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: textFieldHintTextColor,
                                  fontSize: screenSize.height / 40),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenSize.height * 0.02),
                    child: AnimatedOpacity(
                      opacity: widget.error != null ? 1.0 : 0.0,
                      duration: Duration(milliseconds: 100),
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.error != null ? widget.error : "",
                            style: TextStyle(
                              fontSize: screenSize.height * 0.018,
                              color: errorRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: widget.onTap,
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width / 12.5),
                width: screenSize.width,
                height: screenSize.height / 14.5,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: (widget.disable ? lightBlue : Colors.blue)),
                    color: (widget.disable ? Colors.transparent : Colors.blue),
                    borderRadius: BorderRadius.circular(screenSize.width / 6)),
                child: Center(
                  child: widget.loading
                      ? Container(
                          width: screenSize.width * 0.04,
                          height: screenSize.width * 0.04,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text(
                          "Next",
                          style: TextStyle(
                              color:
                                  (widget.disable ? lightBlue : Colors.white)),
                        ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
