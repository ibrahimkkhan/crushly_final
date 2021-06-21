import 'package:crushly/BLocs/Massenger_Bloc/massenger_bloc.dart';
import 'package:crushly/BLocs/User_Bloc/user_bloc.dart';
import 'package:crushly/BLocs/User_Bloc/user_event.dart';
import 'package:crushly/Screens/auth/sign_in.dart';
import 'package:crushly/Screens/my_profile/profile_password_reset/Profile_Password_Reset.dart';
import 'package:crushly/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme.dart';
import 'profile_settings/profile_settings_page.dart';

class MyProfileDetails extends StatefulWidget {
  final User user;

  MyProfileDetails({
    this.user,
  });

  @override
  _MyProfileDetailsState createState() => _MyProfileDetailsState();
}

class _MyProfileDetailsState extends State<MyProfileDetails> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            'Settings',
            style: TextStyle(
              fontSize: size.height / 38.0,
              color: darkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        color: appBarBackgroundColor,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size.height / 40.6),
              ),
              margin: EdgeInsets.only(
                  top: size.height / 32.6,
                  bottom: size.height / 81.2,
                  left: size.width / 23.43,
                  right: size.width / 23.43),
              padding: EdgeInsets.only(
                  top: size.height / 32.48,
                  left: size.width / 30.75,
                  right: size.width / 30.75,
                  bottom: size.height / 40.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProfileSettingsPage(
                          user: widget.user,
                        ),
                      ),
                    ),
                    child: _getItem(size, "My Account", true),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ProfilePasswordReset()),
                    ),
                    child: _getItem(size, "Reset Password", true),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: _getItem(size, "Choose Anonymous Name", false),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size.height / 40.6),
              ),
              margin: EdgeInsets.only(
                  top: size.height / 20.3,
                  bottom: size.height / 81.2,
                  left: size.width / 23.43,
                  right: size.width / 23.43),
              padding: EdgeInsets.only(
                  top: size.height / 32.48,
                  left: size.width / 30.75,
                  right: size.width / 30.75,
                  bottom: size.height / 40.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: _getItem(size, "Privacy Policy", true),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: _getItem(size, "Terms & Conditions", false),
                  ),
                ],
              ),
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(size.height / 40.6),
                ),
                margin: EdgeInsets.only(
                    top: size.height / 20.3,
                    bottom: size.height / 81.2,
                    left: size.width / 23.43,
                    right: size.width / 23.43),
                padding: EdgeInsets.only(
                    top: size.height / 80.48,
                    left: size.width / 30.75,
                    right: size.width / 30.75,
                    bottom: size.height / 80.6),
                child: FlatButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(bottom: size.height / 60),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      icon: Icon(Icons.close),
                                      color: gray,
                                      onPressed: () => Navigator.pop(context),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: size.width / 20,
                                    right: size.width / 20,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Are you sure you want to log out?',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.3,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height / 50,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: size.width / 50,
                                          right: size.width / 50,
                                        ),
                                        child: Text(
                                          "We can't notify you about your Crushes if you log out.",
                                          textScaleFactor: 0.85,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      FlatButton(
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        child: Text(
                                          'Log Out',
                                          textScaleFactor: 1.2,
                                          style: TextStyle(
                                            color: red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          BlocProvider.of<MassengerBloc>(
                                                  context)
                                              .disconnect();
                                          BlocProvider.of<UserBloc>(context)
                                              .add(Logout());
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                            MaterialPageRoute(
                                              builder: (_) {
                                                return SignIn();
                                              },
                                            ),
                                            (_) => false,
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                        // return CupertinoAlertDialog(
                        //   title: Text(
                        //     'Logout',
                        //     style: TextStyle(
                        //       color: Colors.black,
                        //     ),
                        //   ),
                        //   content: Text(
                        //       'Are you sure you want to logout from the app?'),
                        //   actions: <Widget>[
                        //     CupertinoDialogAction(
                        //       child: Text('Cancel'),
                        //       onPressed: () {
                        //         Navigator.of(context).pop();
                        //       },
                        //     ),
                        //     CupertinoDialogAction(
                        //       child: Text('Logout'),
                        //       isDestructiveAction: true,
                        //       onPressed: () {
                        //         Navigator.of(context).pop();
                        //         BlocProvider.of<MassengerBloc>(context)
                        //             .disconnect();
                        //         BlocProvider.of<UserBloc>(context)
                        //             .add(Logout());
                        //         Navigator.of(context).pushAndRemoveUntil(
                        //           MaterialPageRoute(
                        //             builder: (_) {
                        //               return SignIn();
                        //             },
                        //           ),
                        //           (_) => false,
                        //         );
                        //       },
                        //     ),
                        //   ],
                        // );
                      },
                    );
                  },
                  child: Center(
                    child: Text(
                      "Logout",
                      style:
                          TextStyle(color: pink, fontSize: size.height / 35.11),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget _getItem(Size size, String text, bool hasDivider) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.symmetric(horizontal: size.width / 12.75),
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: size.height / 42.11),
        ),
      ),
      hasDivider
          ? Container(
              margin: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
              child: Divider(
                thickness: 1,
                height: 2,
                color: dividerColor,
              ))
          : Container()
    ],
  );
}
