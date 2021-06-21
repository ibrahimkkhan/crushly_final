import 'package:crushly/BLocs/Massenger_Bloc/massenger_bloc.dart';
import 'package:crushly/BLocs/Massenger_Bloc/massenger_event.dart';
import 'package:crushly/BLocs/User_Bloc/user_bloc.dart';
import 'package:crushly/BLocs/User_Bloc/user_event.dart';
import 'package:crushly/Screens/auth/PasswordReset/forgot_password.dart';
import 'package:crushly/Screens/auth/sign_in.dart';
import 'package:crushly/Screens/auth/singup/birthday_view.dart';
import 'package:crushly/Screens/auth/singup/gender_screen.dart';
import 'package:crushly/Screens/auth/singup/gender_view.dart';
import 'package:crushly/Screens/auth/singup/school_choice_view.dart';
import 'package:crushly/Screens/auth/singup/signup_page.dart';
import 'package:crushly/Screens/auth/social_connect.dart';
import 'package:crushly/models/User.dart';
import 'package:crushly/theme.dart';
import 'package:crushly/utils/linear_gradient_mask.dart';
import 'package:crushly/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileSettingsPage extends StatefulWidget {
  final User user;

  const ProfileSettingsPage({Key key, this.user}) : super(key: key);

  @override
  _ProfileSettingsPageState createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: appBarBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: appBarBackgroundColor,
        leading: Padding(
          padding: EdgeInsets.only(top: size.height / 40.6),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: pink,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: size.height / 40.6),
          child: Text(
            'My Account',
            style: TextStyle(
              fontSize: size.width / 23.43,
              color: darkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
                top: size.height / 32.6,
                bottom: size.height / 81.2,
                left: size.width / 23.43,
                right: size.width / 23.43),
            padding: EdgeInsets.only(
                top: size.height / 80.6,
                left: size.width / 30.75,
                right: size.width / 30.75,
                bottom: size.height / 40.6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.height / 40.6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: size.width / 18.75,
                ),
                _getItem(size, 'Name', capitalizeNames(widget.user.name), true),
                _getItem(size, 'Email', widget.user.email, true),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          body: GenderView(
                            secondText: 'I\'m a...',
                            gender: capitalizeNames(widget.user.gender),
                            genderType: GenderType.GENDER,
                          ),
                        ),
                      ),
                    );
                    print('the result is $result');
                    if (result != null)
                      setState(() {
                        widget.user.gender = result;
                      });
                  },
                  child: _getItem(
                    size,
                    'Gender',
                    widget.user.gender,
                    true,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                          body: GenderView(
                            secondText: 'I\'m interested in...',
                            gender: capitalizeNames(widget.user.interestedIn),
                            genderType: GenderType.INTERESTED_IN,
                          ),
                        ),
                      ),
                    );

                    print('the result is $result');
                    if (result != null) widget.user.interestedIn = result;
                  },
                  child: _getItem(
                    size,
                    'Interested in',
                    capitalizeNames(widget.user.interestedIn),
                    true,
                  ),
                ),
                GestureDetector(
                    onTap: () async {
                      final result = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                              body: BirthdayView(
                            birthDate: widget.user.birthday,
                          )),
                        ),
                      );

                      print('the result is $result');
                      //   if (result != null) widget.user.birthday = result;
                    },
                    child: _getItem(
                        size, 'Birthday', widget.user.birthday ?? 'N/A', true)),
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => Scaffold(
                            body: SchoolChoiceView(
                          schoolName: widget.user.schoolName ?? "",
                          greekHouse: widget.user.greekHouse ?? "",
                        )),
                      ),
                    );

                    print('the result is $result');
                    //if (result != null) widget.user.schoolName = result;
                  },
                  child: _getItem(size, 'University/College/Greek House',
                      capitalizeNames(widget.user.schoolName ?? 'N/A'), false),
                ),
              ],
            ),
          ),
          //Terms and policy
          /* Container(
            margin: EdgeInsets.symmetric(
                vertical: size.height / 162, horizontal: size.width / 18.75),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(size.width / 18.75),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: size.width / 18.75,
                      right: size.width / 18.75,
                      top: size.height / 50.75),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: darkBlue,
                    ),
                  ),
                ),
                _getDivider(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(
                      left: size.width / 18.75,
                      right: size.width / 18.75,
                      bottom: size.height / 50.75),
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      color: darkBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),*/

          //Log out button
          /*GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    content:
                        Text('Are you sure you want to logout from the app?'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('Logout'),
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                          BlocProvider.of<MassengerBloc>(context).disconnect();
                          BlocProvider.of<UserBloc>(context).add(Logout());
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) {
                                return SignIn();
                              },
                            ),
                            (_) => false,
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 30, left: 20, right: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(size.width / 18.75),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.all(size.width / 18.75),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: size.width / 23.43,
                        color: pink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }

  Widget _getItem(Size size, String text, String value, bool withDivider) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(horizontal: size.width / 18.75),
          child: Text(
            text,
            style: TextStyle(color: settingsGrey, fontSize: size.width / 27.43),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: size.width / 18.75,
                ),
                child: Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: size.width / 23.43,
                    color: darkBlue,
                  ),
                ),
              ),
            ),
          ],
        ),
        withDivider ? _getDivider() : Container(),
      ],
    );
  }

  Widget _getDivider() {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 20.0),
      child: Divider(
        thickness: 1,
        height: 2,
        color: grey,
      ),
    );
  }
}
