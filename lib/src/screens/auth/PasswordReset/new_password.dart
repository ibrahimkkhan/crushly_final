import 'package:flutter/material.dart';
import 'package:crushly/utils/gradient_container_border.dart';

import '../../../theme.dart';

class NewPassword extends StatelessWidget {
  final String error;
  final onTap;
  final bool disable, loading;
  final Function(String) passwordFun;
  final Function(String) confirmPass;

  NewPassword({
    this.disable,
    this.loading,
    this.onTap,
    this.error,
    this.confirmPass,
    this.passwordFun,
  });

  @override
  Widget build(BuildContext context) {
    /*TextEditingController passwordController = new TextEditingController();
    TextEditingController confirmPasswordController =
        new TextEditingController();*/
    String password = "";
    String confirmPassword = "";
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
                    "Enter your new password",
                    style: TextStyle(
                        color: darkBlue,
                        fontSize: screenSize.width * 0.05,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width / 18.75, vertical: 25),
                  margin:
                      EdgeInsets.symmetric(horizontal: screenSize.width / 12.5),
                  width: screenSize.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(screenSize.height * 0.03)),
                  child: Column(
                    children: <Widget>[
                      GradientContainerBorder(
                        onPressed: () {},
                        radius: screenSize.width / 6.25,
                        height: screenSize.height / 16.91,
                        strokeWidth: 1.0,
                        width: screenSize.width / 1.36,
                        gradient: password.isEmpty ? greyGradient : appGradient,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width / 15.625),
                            child: TextField(
                              onChanged: (value) {
                                passwordFun(value);
                              },
                              style:
                                  TextStyle(fontSize: screenSize.height / 40),
                              obscureText: true,
                              //controller: passwordController,
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'New password',
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: screenSize.height / 40,
                                  color: textFieldHintTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.025,
                      ),
                      GradientContainerBorder(
                        onPressed: () {},
                        radius: screenSize.width / 6.25,
                        height: screenSize.height / 16.91,
                        strokeWidth: 1.0,
                        width: screenSize.width / 1.36,
                        gradient: confirmPassword.isEmpty
                            ? greyGradient
                            : appGradient,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width / 15.625),
                            child: TextField(
                              onChanged: (value) {
                                confirmPass(value);
                              },
                              obscureText: true,
                              style:
                                  TextStyle(fontSize: screenSize.height / 40),
                              //controller: confirmPasswordController,
                              maxLines: 1,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'Confirm new password',
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: screenSize.height / 40,
                                  color: textFieldHintTextColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize.width / 12.5),
                width: screenSize.width,
                height: screenSize.height / 14.5,
                decoration: BoxDecoration(
                    border:
                        Border.all(color: (disable ? lightBlue : Colors.blue)),
                    color: (disable ? Colors.transparent : Colors.blue),
                    borderRadius: BorderRadius.circular(screenSize.width / 6)),
                child: Center(
                  child: loading
                      ? Container(
                          width: screenSize.width * 0.04,
                          height: screenSize.width * 0.04,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        )
                      : Text(
                          "Change Password",
                          style: TextStyle(
                              color: (disable ? lightBlue : Colors.white)),
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
