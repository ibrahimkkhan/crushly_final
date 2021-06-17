// import 'dart:math';

// import 'package:auto_size_text/auto_size_text.dart';
// import 'signup_page.dart';
import '../../widgets/big_text.dart';
import '../../widgets/error_label.dart';
// import '../../widgets/paddings.dart';
import '../../widgets/tf_gradiant_parent.dart';
import '../../widgets/widget_utils.dart';
import '../../theme/theme.dart';
// import '../../utils/gradient_container_border.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordView extends StatelessWidget {
  final Function(String)? passwordChanged;
  final Function(String)? emailChanged;
  final bool? passwordValidationError;
  final bool? emailValidationError;
  final bool? isEmailAvailable;
  final String? password;
  final String? email;
  final focus1, focus2;
  final onSubmitted;
  Size? screenSize;

  EmailAndPasswordView(
      {Key? key,
      this.focus1,
      this.focus2,
      this.onSubmitted,
      this.email,
      this.emailChanged,
      this.emailValidationError,
      this.passwordValidationError,
      this.isEmailAvailable,
      this.passwordChanged,
      this.password})
      : super(key: key);

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text = email!;
    passwordController.text = password!;
    emailController.selection = TextSelection(
      baseOffset: email!.length,
      extentOffset: email!.length,
    );
    passwordController.selection = TextSelection(
      baseOffset: password!.length,
      extentOffset: password!.length,
    );

    bool ismailAvailable =
        emailController.text.isNotEmpty && !emailValidationError! ||
            (isEmailAvailable != null && !isEmailAvailable!);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BigTxt(
                text: 'My email and\npassword...',
                fontFamily: Fonts.SOMANTIC_FONT,
              ),
              SizedBox(height: 30),
              Container(
                decoration: WidgetUtils.getParentDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                      child: GradientBorder(
                        enabledGradient: email!.isNotEmpty,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                          child: TextField(
                            focusNode: focus1,
                            onChanged: emailChanged,
                            controller: emailController,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              _fieldFocusChange(context, focus1, focus2);
                            },
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              hintText: 'example@example.edu',
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                color: grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: emailController.text.isNotEmpty &&
                              !emailValidationError! ||
                          (isEmailAvailable != null && !isEmailAvailable!),
                      child: ErrorLabel(
                        marginInsets: EdgeInsets.fromLTRB(40, 10, 30, 10),
                        text: emailController.text.isNotEmpty
                            ? !emailValidationError!
                                ? "Please signup with your university email."
                                : 'The email you entered already exists.'
                            : 'The email you entered already exists.',
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                      child: GradientBorder(
                        enabledGradient: password!.isNotEmpty,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            focusNode: focus2,
                            onChanged: passwordChanged,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                onSubmitted();
                              }
                            },
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                color: grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    !passwordValidationError! && password!.isNotEmpty
                        ? ErrorLabel(
                            marginInsets: EdgeInsets.fromLTRB(40, 10, 30, 0),
                            text:
                                'The password must contain at least 6 characters',
                          )
                        : SizedBox(height: 0),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_fieldFocusChange(
    BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
