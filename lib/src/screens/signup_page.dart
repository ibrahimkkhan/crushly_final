import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/Messenger_Bloc/bloc.dart';
import '../bLocs/User_Bloc/bloc.dart';

import 'package:flutter/material.dart';

import 'package:page_indicator/page_indicator.dart';
import 'package:crushly/Screens/MyProfile.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class NoKeyboardEditableText extends EditableText {
  NoKeyboardEditableText({
    required TextEditingController controller,
    required TextStyle style,
    required Color cursorColor,
    bool autofocus = false,
    required Color selectionColor,
  }) : super(
            controller: controller,
            focusNode: NoKeyboardEditableTextFocusNode(),
            style: style,
            cursorColor: cursorColor,
            autofocus: autofocus,
            selectionColor: selectionColor,
            backgroundCursorColor: Colors.black);

  @override
  EditableTextState createState() {
    return NoKeyboardEditableTextState();
  }
}

class NoKeyboardEditableTextState extends EditableTextState {
  @override
  void requestKeyboard() {
    super.requestKeyboard();
    //hide keyboard
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}

class NoKeyboardEditableTextFocusNode extends FocusNode {
  @override
  bool consumeKeyboardToken() {
    // prevents keyboard from showing on first focus
    return false;
  }
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  PageController _pageController = PageController(initialPage: 0);

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
    "Β",
    "Ν",
    "Μ",
  ];

  Widget text() {
    return Container(
      child: Text("data"),
    );
  }

  String input = "";
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: PageIndicatorContainer(
        length: 2,
        indicatorColor: Colors.grey,
        indicatorSelectorColor: Theme.of(context).primaryColor,
        child: PageView(
          controller: _pageController,
          children: <Widget>[
            Column(
              children: <Widget>[
                Divider(
                  height: height * 0.2,
                  color: Colors.white,
                ),
                //Icon(IconData(0xeb03, fontFamily: 'MyFlutterApp')),
                Image.asset("lib/Fonts/photo.jpg"),
                Divider(height: 50, color: Colors.white),
                Center(
                  child: Text(
                    "Enter your Greek House Name",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.025),
                  ),
                ),
                Divider(
                  color: Colors.white,
                  height: height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 150),
                  child: GestureDetector(
                    onTap: () {
                      print("Muhn");

                      FocusScope.of(context).unfocus();
                    },
                    child: NoKeyboardEditableText(
                      selectionColor: Colors.grey,
                      //// focusNode: _focusNode,
                      controller: TextEditingController(text: input),
                      cursorColor: Colors.black,
                      style: TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                ),

                Divider(height: height * 0.03, color: Colors.white),
                ////textField(),
                Expanded(child: keyboard()),
              ],
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Divider(
                    height: height * 0.2,
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.location_city,
                    size: height * 0.22,
                  ),
                  Divider(
                    height: height * 0.05,
                    color: Colors.white,
                  ),
                  Center(
                    child: Text(
                      "Enter your Building's Name",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.025),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: width * 0.05, left: width * 0.05),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: height * 0.2,
                  ),
                  Center(
                    child: SizedBox(
                      width: 320.0,
                      height: 60.0,
                      child: RaisedButton(
                        elevation: 2,
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        onPressed: () {
                          BlocProvider.of<UserBloc>(context)
                              .add(FetchUser());

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyProfile()));
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(fontSize: 20, color: Colors.white),
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
    );
  }

  GridView keyboard() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
      ),
      itemCount: 25,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: index < 24
              ? GestureDetector(
                  child: Text(
                    letters[index],
                    style: TextStyle(
                        fontSize: 25,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  onTap: () {
                    setState(() {
                      input += letters[index];
                      print(letters[index]);
                    });
                  },
                )
              : GestureDetector(
                  child: Icon(
                    Icons.backspace,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    setState(
                      () {
                        input = input.substring(0, input.length - 1);
                        // print(letters[index]);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}

class SignUpForm extends StatefulWidget {
  SignUpForm({required Key key}) : super(key: key);

  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation animationEmail,
      createAccountAnimation,
      animationPass,
      animationDOB,
      animationFN,
      animationLN;
  late String password, email, fname;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);

    animationEmail = Tween(begin: -0.3, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutSine),
    );

    animationDOB = Tween(begin: -0.2, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutSine),
    );

    createAccountAnimation = Tween(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutSine),
    );

    animationFN = Tween(begin: -0.5, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutSine),
    );

    animationLN = Tween(begin: -0.4, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutSine),
    );

    animationPass = Tween(begin: -0.1, end: 0.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutSine),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<UserBloc, UserState>(
          condition: (prevoius, current) {
            if (current is AddUserSuccess || current is AddUserFailed)
              return true;
            else
              return false;
          },
          listener: (context, state) {
            if (state is AddUserSuccess) {
              BlocProvider.of<MassengerBloc>(context).add(Connect());
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            }
            if (state is AddUserFailed) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: AnimatedBuilder(
            animation: _animController,
            builder: (context, child) {
              return Align(
                alignment: Alignment.center,
                child: Container(
                  child: Form(
                    key: formKey,
                    child: ListView(
                      children: <Widget>[
                        Transform(
                          transform: Matrix4.translationValues(
                              0.0, createAccountAnimation.value * height, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Divider(
                                height: 80,
                                color: Colors.white,
                              ),
                              Center(
                                child: Text(
                                  "Create Your Account",
                                  style: TextStyle(fontSize: 25),
                                ),
                              ),
                              Divider(
                                height: 50,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animationFN.value * width, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: Text(
                                  "First Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: TextFormField(
                                  validator: (text) =>
                                      text == " " || text!.isEmpty
                                          ? "please insert your first name "
                                          : null,
                                  onSaved: (t) => fname = t!,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animationLN.value * width, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Divider(
                                height: 20,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: Text(
                                  "Last Name",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    // border: Border(
                                    //     bottom: BorderSide(
                                    //         color: Theme.of(context).primaryColor)),
                                    // focusColor: Colors.pink
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animationEmail.value * width, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Divider(
                                height: 20,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: Text(
                                  "Email",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  // validator: (text) =>
                                  //     RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  //             .hasMatch(text)
                                  //         ? null
                                  //         : "insert a valid email",
                                  onSaved: (t) => email = t!,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animationDOB.value * width, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Divider(
                                height: 20,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: Text(
                                  "DOB",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Transform(
                          transform: Matrix4.translationValues(
                              animationPass.value * width, 0.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Divider(
                                height: 20,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 0),
                                child: TextFormField(
                                  // validator: (text) {
                                  //   if (text.length < 6 || text == " ") {
                                  //     return "Password must be at least 6 character";
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (t) => password = t!,
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 30,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<UserBloc, UserState>(
                            condition: (prev, cur) {
                          return cur is LoadingFetch || cur is AddUserFailed;
                        }, builder: (context, state) {
                          if (state is LoadingFetch) {
                            return Center(
                              child: Theme(
                                  data: ThemeData(
                                      primaryColor:
                                          Theme.of(context).primaryColor),
                                  child: CircularProgressIndicator()),
                            );
                          }
                          return Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                width: width * 0.7,
                                height: 60.0,
                                child: RaisedButton(
                                  elevation: 2,
                                  color: Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  onPressed: () {
                                    var form = formKey.currentState;

                                    if (form!.validate()) {
                                      form.save();

                                      BlocProvider.of<UserBloc>(context)
                                          .add(NewUser(
                                              fname.trim().toLowerCase()));
                                    }
                                     ;
                                  },
                                  child: Text(
                                    "Save and Continue",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
