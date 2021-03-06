import 'dart:convert';

import '../../resources/UniApi.dart';
import 'package:crushly/Common/UniversitySearchDelegate.dart';
import 'package:crushly/Screens/auth/singup/greek_house.dart';
import 'package:crushly/Screens/auth/singup/school_view.dart';
import 'package:crushly/Screens/auth/singup/signup_page.dart';
import 'package:crushly/models/University.dart';
import 'package:crushly/theme.dart';
import 'package:crushly/utils/selectable_button.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:page_transition/page_transition.dart';

class SchoolChoiceView extends StatefulWidget {
  final Function(University) schoolNameChanged;
  final Function(String) greekHouseChanged;
  final String schoolName;
  final String greekHouse;

  const SchoolChoiceView({
    Key key,
    this.schoolNameChanged,
    this.greekHouseChanged,
    this.greekHouse,
    this.schoolName,
  }) : super(key: key);

  @override
  _SchoolChoiceViewState createState() => _SchoolChoiceViewState();
}

class _SchoolChoiceViewState extends State<SchoolChoiceView> {
  SchoolType selectedSchoolType;
  String uniName = "";
  //String selectedSchoolName;
  //String selectedGreekHouse;

  PageController _controller;
  Size screenSize;
  @override
  void initState() {
    // selectedSchoolName = widget.schoolName;
    //   selectedGreekHouse = widget.greekHouse;
    _controller = PageController(initialPage: 0);
//    _controller = PageController(initialPage: selectedSchoolType == null ? 0 : 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    value = 6 / 7;
    screenSize = MediaQuery.of(context).size;
    print(widget.greekHouse);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: screenSize.width / 5,
                right: screenSize.width / 15.625,
                bottom: screenSize.height / 27.06),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "My Uni...",
                style: TextStyle(
                  fontSize: screenSize.width / 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: screenSize.height / 20.3),
            margin: EdgeInsets.symmetric(horizontal: screenSize.width / 12.5),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SelectableButton(
                    option: widget.schoolName.isEmpty
                        ? 'University/College'
                        : widget.schoolName,
                    selectedOption:
                        widget.schoolName.isNotEmpty ? widget.schoolName : '',
                    onClick: () async {
                      selectedSchoolType = SchoolType.university;
                      final uni = await showSearch(
                          context: context,
                          delegate: UserSearchDelegate((uniName) {
                            widget.schoolNameChanged(uniName);
                          }));

                      /*_controller.nextPage(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn);*/
                      setState(() {});
                    },
                  ),
                ),
//                    TopPadding(20.0),
//                    Padding(
//                      padding: EdgeInsets.symmetric(horizontal: 20.0),
//                      child: SelectableButton(
//                        option: 'High School',
//                        onClick: () {
//                          widget.schoolTypeChanged(SchoolType.highSchool);
//                          selectedSchoolType = SchoolType.highSchool;
//                          _controller.nextPage(
//                              duration: Duration(milliseconds: 350),
//                              curve: Curves.easeIn);
//                          setState(() {});
//                        },
//                      ),
//                    ),
                SizedBox(
                  height: screenSize.height / 27.06,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: SelectableButton(
                    option: widget.greekHouse.isNotEmpty
                        ? widget.greekHouse
                        : 'Greek House',
                    selectedOption:
                        widget.greekHouse.isNotEmpty ? widget.greekHouse : '',
                    onClick: () {
                      selectedSchoolType = SchoolType.greekHouse;
                      Navigator.push(
                          context,
                          PageTransition(
                            child: GreekHouse(
                                houseName: widget.greekHouse,
                                houseNameChanged: (greekHouse) {
                                  widget.greekHouseChanged(greekHouse);
                                  //                       selectedGreekHouse = greekHouse;
                                }),
                            type: PageTransitionType.fade,
                            alignment: Alignment.center,
                          ));
                      /*_controller.nextPage(
                          duration: Duration(milliseconds: 350),
                          curve: Curves.easeIn);
                      setState(() {});*/
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*GreekHouse(
              houseName: widget.greekHouse,
              houseNameChanged: (greekHouse) {
                widget.greekHouseChanged(greekHouse);
                //                       selectedGreekHouse = greekHouse;
              })*/

//add
enum SchoolType {
  university,
//  highSchool,
  greekHouse,
}
/* selectedSchoolType == SchoolType.university
              ? SchoolView(
                  isCollege: true,
                  schoolName: widget.schoolName,
                  schoolNameChanged: (schoolName) {
                    //print('!!!! schoolName = $schoolName');
                    widget.schoolNameChanged(schoolName);
//                    selectedSchoolName = schoolName;
                  },
                )
//              : selectedSchoolType == SchoolType.highSchool
//                  ? SchoolView(
//                      isCollege: false,
//                      schoolName: widget.schoolName,
//                      schoolNameChanged: widget.schoolNameChanged,
//                    )
              : GreekHouse(
                  houseName: widget.greekHouse,
                  houseNameChanged: (greekHouse) {
                    widget.greekHouseChanged(greekHouse);
//                        selectedGreekHouse = greekHouse;
                  }*/
