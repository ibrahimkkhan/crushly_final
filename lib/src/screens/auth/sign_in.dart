import 'package:auto_size_text/auto_size_text.dart';
import '../../blocs/Messenger_Bloc/messenger_bloc.dart';
import '../../blocs/Messenger_Bloc/messenger_event.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';
// import 'package:crushly/MainScreen.dart';
// import 'package:crushly/Screens/auth/PasswordReset/forgot_password.dart';
import '../../screens/auth/location.dart';
import '../../screens/singup/signup_page.dart';
import '../../theme/theme.dart';
import '../../utils/gradient_container_border.dart';
import '../../utils/linear_gradient_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
// import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'PasswordReset/forgot_password.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late bool show;
  final _bloc = new AuthBloc(AuthInitialState());
  late Size screenSize;

  @override
  void initState() {
    show = true;
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     print("here => " + visible.toString());
    //     show = !visible;
    //   },
    // );
    _bloc.add(GetSignInInitialState());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return KeyboardDismisser(
      gestures: [GestureType.onTap, GestureType.onPanUpdateDownDirection],
      child: BlocListener(
        bloc: _bloc,
        listener: (context, AuthState state) {
          if (state is SignInState) if (state.signInSuccessfully) {
            BlocProvider.of<MassengerBloc>(context).add(Connect());
            WidgetsBinding.instance!.addPostFrameCallback(
              (_) => Navigator.pushAndRemoveUntil(
                context,
                // MaterialPageRoute(builder: (_) => MainScreen()),
                MaterialPageRoute(builder: (_) => Text("Homescreen")),

                (_) => false,
              ),
            );
          }
        },
        child: BlocBuilder(
          bloc: _bloc,
          builder: (context, AuthState state) {
            if (state is SignInState) {
              print('state = $state');
//
//            if (state.signInError != NO_ERROR) {
//              print('test error ${state.signInError}');
//              // TODO: handle error & show error message
//
//              _bloc.add(ResetSignInError());
//            }
              return Stack(
                children: <Widget>[
                  Scaffold(
                    appBar: PreferredSize(
                      preferredSize: Size.fromHeight(
                          show ? screenSize.height / 20 : bottom / 60),
                      child: Container(),
                    ),
                    //  resizeToAvoidBottomInset: false,
                    backgroundColor: pageBackground,
                    body: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width / 12.5),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: screenSize.height / 35,
                              ),
                              Text(
                                'Welcome to Crushly!',
                                style: TextStyle(
                                  color: darkBlue,
                                  fontSize: screenSize.width / 13.9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height / 48.3,
                              ),
                              show
                                  ? Container(
                                      height: screenSize.height / 8,
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            'Find your crush.',
                                            style: TextStyle(
                                              color: darkBlue,
                                              fontSize: screenSize.width / 20.8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'Crush. Chat. Date!',
                                            style: TextStyle(
                                              color: darkBlue,
                                              fontSize: screenSize.width / 20.8,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Container(
                                width: screenSize.width / 1.19,
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenSize.width / 18.75,
                                    vertical: screenSize.height / 80),
                                decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(
                                    screenSize.width / 18.75,
                                  ),
                                ),
                                child: Column(
                                  children: <Widget>[
                                    _emailField(state),
                                    SizedBox(
                                      height: screenSize.height / 33.83,
                                    ),
                                    _passwordField(state),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            // builder: (_) => ForgotPassword(),
                                            builder: (_) => Text("Forgot pwd"),

                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Forgot password?',
                                        style: TextStyle(
                                          color: darkBlue,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenSize.height / 70,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: screenSize.height / 20,
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: bottom),
                                child: Container(
                                  height: screenSize.height / 15.25,
                                  width: screenSize.width * 0.7,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          screenSize.height / 27.36)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        screenSize.height / 27.36),
                                    child: FlatButton(
                                        onPressed: () {
                                          if (!state.signingIn &&
                                              state.emailValidation &&
                                              emailController.text.isNotEmpty &&
                                              state.passwordValidation &&
                                              passwordController
                                                  .text.isNotEmpty) {
                                            emailController.text.trim();
                                            passwordController.text.trim();
                                            _bloc.add(LoginInitiated());
                                          }
                                        },
                                        child: ShaderMask(
                                          shaderCallback: (bounds) {
                                            if (!state.signingIn &&
                                                state.emailValidation &&
                                                emailController
                                                    .text.isNotEmpty &&
                                                state.passwordValidation &&
                                                passwordController
                                                    .text.isNotEmpty)
                                              return appGradient.createShader(
                                                Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    bounds.width,
                                                    bounds.height),
                                              );
                                            return grayGradient.createShader(
                                                Rect.fromLTWH(
                                                    0.0,
                                                    0.0,
                                                    bounds.width,
                                                    bounds.height));
                                          },
                                          child: Text(
                                            "Login",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxHeight: screenSize.height / 10,
                                ),
                                child: Container(),
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    width: screenSize.width * 0.68,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          height: 1,
                                          width: screenSize.width * 0.2,
                                          color: dividerColor3,
                                        ),
                                        Text(
                                          "OR",
                                          style: TextStyle(),
                                        ),
                                        Container(
                                          height: 1,
                                          width: screenSize.width * 0.2,
                                          color: dividerColor3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height / 70,
                                  ),
                                  Container(
                                    height: screenSize.height / 15,
                                    width: screenSize.width * 0.7,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Colors.black26,
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        gradient: messageGradient,
                                        borderRadius: BorderRadius.circular(
                                            screenSize.height / 27.36)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          screenSize.height / 27.36),
                                      child: FlatButton(
                                          onPressed: () async {
                                            if (await Permission
                                                .location.isGranted) {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        SignUp()),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                CupertinoPageRoute(
                                                    builder: (context) =>
                                                        Location()),
                                              );
                                            }
                                          },
                                          child: Text(
                                            "Create an Account",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  state.signingIn
                      ? Center(child: CircularProgressIndicator())
                      : Container()
                ],
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }

  _emailField(SignInState state) {
    return Column(
      children: <Widget>[
        state.signInError != 1
            ? AnimatedOpacity(
                opacity:
                    emailController.text.isNotEmpty && !state.emailValidation
                        ? 1.0
                        : 0.0,
                duration: Duration(milliseconds: 100),
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AutoSizeText(
                      'This is not a valid email form',
                      minFontSize: 10,
                      style: TextStyle(
                        fontSize: screenSize.width / 26.78,
                        color: errorRed,
                      ),
                    ),
                  ),
                ),
              )
            : Row(
                children: <Widget>[
                  Text(
                    "Email doesn\'t exist. ",
                    style: TextStyle(color: redError),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (await Permission.location.isGranted) {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => SignUp()),
                        );
                      } else {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(builder: (context) => Location()),
                        );
                      }
                    },
                    child: Text(
                      "Create account.",
                      style: TextStyle(
                        color: redError,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
        GradientContainerBorder(
          onPressed: () {},
          radius: screenSize.width / 6.25,
          height: screenSize.height / 15,
          strokeWidth: 1.0,
          width: screenSize.width,
          gradient: emailController.text.isEmpty
              ? greyGradient
              : state.emailValidation ? appGradient : errorGradient,
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width / 18.75),
              child: TextField(
                onChanged: (email) {
                  _bloc.add(EmailChanged(email, state.passwordValidation));
                  _bloc.add(ResetSignInError());
//                  if (email.isEmpty) setState(() {});
                },
                controller: emailController,
                focusNode: emailFocus,
                style: TextStyle(
                  fontSize: screenSize.width / 26.78,
                  color: darkBlue,
                ),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onSubmitted: (_) {
                  FocusScope.of(context).requestFocus(passwordFocus);
                },
                decoration: InputDecoration(
                  hintText: 'Email',
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  icon: !state.emailValidation
                      ? Icon(
                          Icons.email,
                          color: errorRed,
                          size: screenSize.height / 40.6,
                        )
                      : emailController.text.isNotEmpty
                          ? LinearGradientMask(
                              child: Icon(
                                Icons.email,
                                color: Colors.white,
                                size: screenSize.height / 40.6,
                              ),
                            )
                          : Icon(
                              Icons.email,
                              color: textFieldHintTextColor,
                              size: screenSize.height / 40.6,
                            ),
                  hintStyle: TextStyle(
                    fontSize: screenSize.width / 26,
                    color: grey,
                  ),
                  /* active: emailController.text.isNotEmpty,
                      error: !state.emailValidation,*/
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _passwordField(SignInState state) {
    return Column(
      children: <Widget>[
        GradientContainerBorder(
          onPressed: () {},
          radius: screenSize.width / 6.25,
          height: screenSize.height / 15,
          strokeWidth: 1.0,
          width: screenSize.width,
          gradient: passwordController.text.isEmpty
              ? greyGradient
              : state.passwordValidation ? appGradient : errorGradient,
          child: Center(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width / 18.75),
              child: TextField(
                focusNode: passwordFocus,
                obscureText: true,
                onChanged: (password) {
                  _bloc.add(PasswordChanged(password, state.emailValidation));
                  _bloc.add(ResetSignInError());
//                  if (password.isEmpty) setState(() {});
                },
                controller: passwordController,
                style: TextStyle(
                  fontSize: screenSize.width / 26.78,
                  color: darkBlue,
                ),
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  if (!state.signingIn) {
                    _bloc.add(LoginInitiated());
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Password',
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  icon: !state.passwordValidation
                      ? Icon(
                          Icons.lock,
                          color: errorRed,
                          size: screenSize.height / 40.6,
                        )
                      : passwordController.text.isNotEmpty
                          ? LinearGradientMask(
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: screenSize.height / 40.6,
                              ),
                            )
                          : Icon(
                              Icons.lock,
                              color: textFieldHintTextColor,
                              size: screenSize.height / 40.6,
                            ),
                  hintStyle: TextStyle(
                    fontSize: screenSize.width / 26,
                    color: grey,
                  ),
                ),
              ),
            ),
          ),
        ),
        AnimatedOpacity(
          opacity:
              passwordController.text.isNotEmpty && !state.passwordValidation
                  ? 1.0
                  : 0.0,
          duration: Duration(milliseconds: 100),
          child: Container(
            child: Align(
              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                'The password must contain at least 6 characters',
                minFontSize: 10,
                maxLines: 1,
                style: TextStyle(
                  fontSize: screenSize.width / 26.78,
                  color: errorRed,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/* Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () async {
                                    if (await Permission.location.isGranted) {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => SignUp()),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) => Location()),
                                      );
                                    }
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        'Don\'t have an account?',
                                        style: TextStyle(
                                          color: grey,
                                          fontSize: screenSize.width / 23.43,
                                        ),
                                      ),
                                      Text(
                                        'Signup',
                                        style: TextStyle(
                                          color: darkBlue,
                                          fontSize: screenSize.width / 23.43,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: pink,
                                    size: screenSize.height * 0.04,
                                  ),
                                  onPressed: () {
                                    if (!state.signingIn) {
                                      _bloc.add(LoginInitiated());
                                    }
                                  },
                                ),
                              ],
                            )*/
/*Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TopPadding(45.0),
                            Text(
                              'Welcome Back!',
                              style: TextStyle(
                                color: darkBlue,
                                fontSize: screenSize.width / 12.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height / 20.3,
                            ),
                            Container(
                              width: screenSize.width / 1.19,
                              height: screenSize.height / 2.79,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenSize.width / 18.75),
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(
                                      screenSize.width / 18.75)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 60,
                                  ),
                                  _emailField(state),
                                  SizedBox(
                                    height: screenSize.height / 50.83,
                                  ),
                                  _passwordField(state),
                                  Text(
                                    'Forgot password?',
                                    style: TextStyle(
                                      color: darkBlue,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height / 13.53,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height / 5.63,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenSize.height * 0.1),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Don\'t have an account?',
                                          style: TextStyle(
                                            color: grey,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          'Signup',
                                          style: TextStyle(
                                            color: darkBlue,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _bloc.add(LoginInitiated());
                                    },
                                    child: Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        gradient: state.signInValidation
                                            ? appGradient
                                            : greyGradient,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30.0)),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  state.signingIn
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(),
                ],
              ),*/
