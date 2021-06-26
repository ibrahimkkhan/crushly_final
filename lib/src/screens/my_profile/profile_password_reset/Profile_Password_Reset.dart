import '../../../screens/my_profile/profile_password_reset/PasswordResetBloc.dart';
import '../../../screens/my_profile/profile_password_reset/PasswordResetEvent.dart';
import '../../../utils/gradient_container_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../theme/theme.dart';
import 'PasswordResetState.dart';

class ProfilePasswordReset extends StatefulWidget {
  @override
  _ProfilePasswordResetState createState() => _ProfilePasswordResetState();
}

class _ProfilePasswordResetState extends State<ProfilePasswordReset> {
  late TextEditingController _currentPassword;
  late TextEditingController _newPassword;
  late TextEditingController _newPasswordConfirm;
  late FocusNode currentFocus;
  late FocusNode newFocus;
  late FocusNode confirmFocus;
  late PasswordResetBloc _bloc;
  bool isLoading = false, isSuccess = false, isFail = false;
  String error = "";
  late Size size;

  @override
  void initState() {
    currentFocus = FocusNode();
    newFocus = FocusNode();
    confirmFocus = FocusNode();
    _currentPassword = TextEditingController();
    _newPassword = TextEditingController();
    _newPasswordConfirm = TextEditingController();
    _bloc = PasswordResetBloc(InitialState());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  bool checkFields() {
    if (_currentPassword.text.isNotEmpty &&
        _currentPassword.text.length > 5 &&
        _newPassword.text.isNotEmpty &&
        _newPassword.text.length > 5 &&
        _newPasswordConfirm.text.isNotEmpty &&
        _newPasswordConfirm.text.length > 5 &&
        _newPassword.text == _newPasswordConfirm.text) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(top: size.height / 40.6),
          child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: pink,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: size.height / 40.6),
          child: Text(
            "Reset Password",
            style: TextStyle(
              fontSize: size.height / 38.0,
              color: darkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: BlocListener(
        bloc: _bloc,
        listener: (context, PasswordResetState state) {
          if (state is InitialState) {
            setState(() {
              _currentPassword.clear();
              _newPassword.clear();
              _newPasswordConfirm.clear();
              error = "";
            });
          }
          if (state is CurrentState) {
            if (state.isSuccess!) {
              Fluttertoast.showToast(
                  msg: "Success",
                  backgroundColor: toastSuccessColor,
                  textColor: Colors.white,
                  gravity: ToastGravity.TOP,
                  toastLength: Toast.LENGTH_SHORT);
              Navigator.pop(context);
            }
            setState(() {
              isLoading = state.isLoading!;
              isSuccess = state.isSuccess!;
              isFail = state.isFail!;
              error = state.error!;
            });
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, PasswordResetState state) {
            return Container(
              color: appBarBackgroundColor,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: size.height / 13.53,
                      left: size.width / 30.75,
                      right: size.width / 30.75,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _textWidget(size, "Enter your current password"),
                        Container(
                          width: size.width,
                          padding: EdgeInsets.symmetric(
                              vertical: size.height / 38.3,
                              horizontal: size.width / 18.75),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(size.height / 40.6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              AnimatedOpacity(
                                opacity: error.isNotEmpty ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 100),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      error,
                                      style: TextStyle(
                                        fontSize: size.height * 0.018,
                                        color: errorRed,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GradientContainerBorder(
                                onPressed: () {},
                                radius: size.width / 6.25,
                                height: size.height / 13,
                                strokeWidth: 1.0,
                                width: size.width / 1.36,
                                gradient: _currentPassword.text.length < 5
                                    ? greyGradient
                                    : appGradient,
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.0),
                                    child: TextField(
                                      focusNode: currentFocus,
                                      obscureText: true,
                                      controller: _currentPassword,
                                      maxLines: 1,
                                      textInputAction: TextInputAction.next,
                                      onSubmitted: (_) {
                                        currentFocus.unfocus();
                                        FocusScope.of(context)
                                            .requestFocus(newFocus);
                                      },
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      decoration: InputDecoration(
                                        hintText: 'Current Password',
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        hintStyle: TextStyle(
                                          color: textFieldHintTextColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text("")
                            ],
                          ),
                        ),
                        _textWidget(size, "Enter your new password"),
                        Container(
                            width: size.width,
                            padding: EdgeInsets.symmetric(
                                vertical: size.height / 38.3,
                                horizontal: size.width / 18.75),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(size.height / 40.6)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                AnimatedOpacity(
                                  opacity: _newPassword.text.isNotEmpty &&
                                          _newPasswordConfirm.text.isNotEmpty &&
                                          (_newPassword.text !=
                                                  _newPasswordConfirm.text ||
                                              (_newPassword.text.length < 6 ||
                                                  _newPasswordConfirm
                                                          .text.length <
                                                      6))
                                      ? 1.0
                                      : 0.0,
                                  duration: Duration(milliseconds: 100),
                                  child: Container(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        _newPasswordConfirm.text.length < 6 ||
                                                _newPassword.text.length < 6
                                            ? "Password should have minimum 6 lenght"
                                            : "Your password dont match",
                                        style: TextStyle(
                                          fontSize: size.height * 0.018,
                                          color: errorRed,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                GradientContainerBorder(
                                  onPressed: () {},
                                  radius: size.width / 6.25,
                                  height: size.height / 13,
                                  strokeWidth: 1.0,
                                  width: size.width / 1.36,
                                  gradient: _newPassword.text.length < 5
                                      ? greyGradient
                                      : appGradient,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.0),
                                      child: TextField(
                                        focusNode: newFocus,
                                        onSubmitted: (_) {
                                          newFocus.unfocus();
                                          FocusScope.of(context)
                                              .requestFocus(confirmFocus);
                                        },
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        obscureText: true,
                                        controller: _newPassword,
                                        maxLines: 1,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                          hintText: 'New Password',
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: textFieldHintTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height / 32.48,
                                ),
                                GradientContainerBorder(
                                  onPressed: () {},
                                  radius: size.width / 6.25,
                                  height: size.height / 13,
                                  strokeWidth: 1.0,
                                  width: size.width / 1.36,
                                  gradient: _newPasswordConfirm.text.length < 5
                                      ? greyGradient
                                      : appGradient,
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.0),
                                      child: TextField(
                                        focusNode: confirmFocus,
                                        onSubmitted: (_) {
                                          FocusScope.of(context).unfocus();
                                          if (!isLoading && checkFields()) {
                                            _bloc.add(PasswordResetSended(
                                                newPassword:
                                                    _newPasswordConfirm.text,
                                                oldPassword:
                                                    _currentPassword.text));
                                          }
                                        },
                                        obscureText: true,
                                        controller: _newPasswordConfirm,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                        maxLines: 1,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          hintText: 'Re-type New Password',
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: textFieldHintTextColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text("")
                              ],
                            )),
                        SizedBox(
                          height: size.height / 13.6,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width / 15.5),
                          width: size.width,
                          height: size.height / 12.5,
                          decoration: BoxDecoration(
                              border: Border.all(color: (lightBlue)),
                              color: checkFields()
                                  ? locationButtonColor
                                  : Colors.transparent,
                              borderRadius:
                                  BorderRadius.circular(size.width / 6)),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              if (!isLoading && checkFields()) {
                                _bloc.add(PasswordResetSended(
                                    newPassword: _newPasswordConfirm.text,
                                    oldPassword: _currentPassword.text));
                              }
                            },
                            child: Center(
                              child: isLoading
                                  ? Container(
                                      width: size.width * 0.04,
                                      height: size.width * 0.04,
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      "Change Password",
                                      style: TextStyle(
                                          color: checkFields()
                                              ? Colors.white
                                              : lightBlue),
                                    ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _textWidget(
  size,
  text,
) {
  return Padding(
    padding: EdgeInsets.symmetric(
        horizontal: size.width / 12.5, vertical: size.height / 81.2),
    child: Text(
      text,
      style: TextStyle(
          fontSize: size.height / 50.0,
          fontWeight: FontWeight.bold,
          color: Colors.black),
    ),
  );
}
