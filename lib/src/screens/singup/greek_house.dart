import 'package:crushly/Screens/auth/singup/greek_keyboard.dart';
import 'package:crushly/Widgets/paddings.dart';
import 'package:crushly/theme.dart';
import 'package:crushly/utils/gradient_container_border.dart';
import 'package:crushly/utils/no_keyboard_editable_text.dart';
import 'package:crushly/utils/utils.dart';
import 'package:flutter/material.dart';

class GreekHouse extends StatefulWidget {
  //
  final Function(String) houseNameChanged;
  final String houseName;

  const GreekHouse({Key key, this.houseNameChanged, this.houseName})
      : super(key: key);

  @override
  _GreekHouseState createState() => _GreekHouseState();
}

class _GreekHouseState extends State<GreekHouse> {
  String houseName = '';

  @override
  void initState() {
    houseName = widget.houseName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //       icon: Icon(
      //         Icons.arrow_back_ios,
      //         color: pink,
      //       ),
      //       onPressed: () => Navigator.pop(context)),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: size.width / 12.5,
                    right: size.width / 12.5,
                    bottom: size.height / 27.06),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "I rushed...",
                    style: TextStyle(
                      fontSize: size.height / 27,
                      fontWeight: FontWeight.bold,
                      color: darkBlue,
                      fontFamily: Fonts.SOMANTIC_FONT,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: size.height / 20.3,
                    horizontal: size.width / 18.75),
                margin: EdgeInsets.symmetric(horizontal: size.width / 12.5),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius:
                        BorderRadius.all(Radius.circular(size.height / 40.6))),
                child: Column(
                  children: <Widget>[
                    GradientContainerBorder(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                      },
                      radius: size.height / 13.38,
                      height: size.height / 13.38,
                      strokeWidth: 1.0,
                      width: MediaQuery.of(context).size.width,
                      gradient: houseName.isEmpty ? greyGradient : appGradient,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width / 12.5),
                          child: NoKeyboardEditableText(
                            selectionColor: Colors.grey,
                            controller: TextEditingController.fromValue(
                              TextEditingValue(
                                text: houseName,
                                selection: TextSelection.collapsed(
                                  offset: houseName.length,
                                ),
                              ),
                            ),
                            cursorColor: accent,
                            style: TextStyle(
                                fontSize: size.width / 23.43, color: darkBlue),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height / 27.06,
                    ),
                    GreekKeyboard(
                      inputChanged: (houseName) {
                        setState(() {
                          this.houseName = houseName;
                          widget.houseNameChanged(houseName);
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
