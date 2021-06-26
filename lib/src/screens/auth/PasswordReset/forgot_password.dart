import 'dart:async';

import 'package:crushly/BLocs/Massenger_Bloc/bloc.dart';
import 'package:crushly/MainScreen.dart';
import 'package:crushly/Screens/auth/PasswordReset/Bloc/ResetBloc.dart';
import 'package:crushly/Screens/auth/PasswordReset/Bloc/ResetState.dart';
import 'package:crushly/Screens/auth/PasswordReset/email_page.dart';
import 'package:crushly/Screens/auth/PasswordReset/new_password.dart';
import 'package:crushly/Screens/auth/PasswordReset/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../theme.dart';
import 'Bloc/ResetEvent.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ResetBloc _bloc;
  PageController _pageController = PageController(initialPage: email_page);
  int currentPage = email_page;
  String email, password, confirmPassword;
  String otp = "";
  bool success = false, loading = false;
  String error = "";

  bool checkPassword() {
    if (password == confirmPassword &&
        (password.isNotEmpty &&
            confirmPassword.isNotEmpty &&
            password.length > 6)) return true;
    return false;
  }

  RegExp regExp = new RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
    caseSensitive: false,
    multiLine: false,
  );

  bool checkEmail() {
    if (regExp.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    _bloc = ResetBloc();
    email = "";
    password = "";
    confirmPassword = "";
    _pageController.addListener(
      () => WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
            currentPage = _pageController.page.toInt();
          })),
    );
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Reset Password",
          style: TextStyle(color: accent),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: pink,
          ),
          onPressed: () {
            if (_pageController.page == 0) {
              return Navigator.of(context).pop();
            } else {
              _pageController.previousPage(
                  duration: Duration(milliseconds: 350), curve: Curves.ease);
            }
            return null;
          },
        ),
      ),
      body: BlocListener(
          bloc: _bloc,
          listener: (context, ResetState state) {
            if (state is CurrentState) {
              setState(() {
                success = state.success;
                loading = state.loading;
                if (state.error != null) {
                  otp = "";
                  error = state.error;
                }
              });
              if (success) {
                otp = "";
                _pageController.nextPage(
                  duration: Duration(milliseconds: 350),
                  curve: Curves.ease,
                );
              }
              if (state.forgotPasswordSuccess) {
                BlocProvider.of<MassengerBloc>(context).add(Connect());
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MainScreen()),
                  ),
                );
              }
            }
          },
          child: BlocBuilder(
              bloc: _bloc,
              builder: (context, ResetState state) {
                return PageView(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    EmailPage(
                      onTap: () {
                        if (!loading && checkEmail())
                          _bloc.add(SendEmail(email));
                      },
                      disable: !checkEmail(),
                      loading: loading,
                      error: error,
                      email: (value) async {
                        setState(() {
                          email = value;
                          error = "";
                        });
                      },
                    ),
                    OTPage(
                      email: email,
                      error: error,
                      onTap: () {
                        if (!loading && checkEmail()) {
                          otp = "";
                          _bloc.add(ResendOTP(email)); //Resend OTP
                        }
                      },
                      otpCall: (value) {
                        if (value == "back") {
                          _pageController.previousPage(
                              duration: Duration(milliseconds: 350),
                              curve: Curves.ease);
                        }
                        error = "";
                        otp = otp + value;

                        print(otp);
                        if (otp.length == 4) {
                          print(otp.substring(otp.length - 4, otp.length));
                          _bloc.add(SendOTP(
                              otp.substring(otp.length - 4, otp.length),
                              email)); //Check if OTP is correct
                        }
                      },
                    ),
                    NewPassword(
                      disable: !checkPassword(),
                      loading: loading,
                      error: error,
                      onTap: () {
                        if (!loading && checkPassword()) {
                          print("here");
                          _bloc.add(
                              SendNewPassword(email, otp, confirmPassword));
                        }
                      },
                      passwordFun: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      confirmPass: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                    )
                  ],
                );
              })),
    );
  }
}

const email_page = 0;
const otp_page = 1;
const new_password_page = 2;
/*if (currentPage == email_page) {
                          if (email.length > 6 && emailChecking == false) {
                            if (await checkEmail() == 200) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 350),
                                curve: Curves.ease,
                              );
                            } else {
                              Scaffold.of(context)
                                ..showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Login Failure',
                                        ),
                                        Icon(Icons.error)
                                      ],
                                    ),
                                  ),
                                );
                            }
                          }
                        }*/
