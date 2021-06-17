import '../../widgets/big_text.dart';
import '../../theme/theme.dart';
import '../../utils/gradient_container_border.dart';
import '../../utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';

class BirthdayView extends StatefulWidget {
  final Function(String, bool, bool)? birthdayChanged;
  final String? birthDate;

  const BirthdayView({Key? key, this.birthdayChanged, this.birthDate})
      : super(key: key);

  @override
  _BirthdayViewState createState() => _BirthdayViewState();
}

class _BirthdayViewState extends State<BirthdayView>
    with SingleTickerProviderStateMixin {
  final dateController = TextEditingController();
  final dateNode = FocusNode();
  String birthDate = '';
  Size? screenSize;
  Map<String, dynamic> currentDate = {
    'date': 'MM-DD-YYYY',
    'errorInput': false,
    'nextInputIndex': -1,
  };

  AnimationController? controller;

  @override
  void initState() {
    birthDate = widget.birthDate!;
    controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    super.initState();
  }

  bool checkAge(String birthday) {
    if (birthday.length == 8 && !birthday.contains("-")) {
      int month = int.tryParse(birthday.substring(0, 2))!;
      int day = int.tryParse(birthday.substring(2, 4))!;
      int year = int.tryParse(birthday.substring(4, 8))!;

      var difference = DateTime.now().difference(DateTime(year, month, day));
      if (difference.inDays > 6570) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  bool checkFeb(String birthday) {
    if (birthday.length == 8 && !birthday.contains("-")) {
      int month = int.tryParse(birthday.substring(0, 2))!;
      int day = int.tryParse(birthday.substring(2, 4))!;
      int year = int.tryParse(birthday.substring(4, 8))!;
      if (year % 4 != 0 && day > 28 && month == 2) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    value = 5 / 7;
    screenSize = MediaQuery.of(context).size;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: BigTxt(
              text: "Wish me on...",
              fontFamily: Fonts.SOMANTIC_FONT,
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(
          //       left: screenSize.width / 7,
          //       right: screenSize.width / 12.5,
          //       bottom: screenSize.width / 37.5),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       "Wish me on...",
          //       style: TextStyle(
          //         fontSize: screenSize.width / 12.5,
          //         fontWeight: FontWeight.bold,
          //         color: darkBlue,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(
            height: screenSize!.height / 27.06,
          ),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: screenSize!.width / 12.5),
                child: TextField(
                  maxLines: 1,
                  focusNode: dateNode,
                  controller: dateController,
                  cursorColor: Colors.transparent,
                  showCursor: false,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusColor: Colors.transparent,
                    fillColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                  ),
                  onChanged: (str) {
                    setState(() {
                      birthDate = str;
                      if (birthDate.length >= 8) {
                        birthDate = birthDate.substring(0, 8);
//                        FocusScope.of(context).unfocus(focusPrevious: true);
                      }
                      currentDate = getDate();
                      controller!.forward(from: 0.0);
                      widget.birthdayChanged!(currentDate['date'],
                          checkAge(birthDate), checkFeb(birthDate));
                    });
                  },
                ),
              ),
              /*
                    vertical: screenSize.height / 20.03,
                    horizontal: screenSize.width / 18.75*/
              Container(
                padding: EdgeInsets.only(
                  left: screenSize!.width / 18.75,
                  right: screenSize!.width / 18.75,
                  bottom: screenSize!.height / 20.03,
                ),
                margin:
                    EdgeInsets.symmetric(horizontal: screenSize!.width / 12.5),
                decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(screenSize!.width / 18.75))),
                child: Column(
                  children: <Widget>[
                    AnimatedOpacity(
                      opacity: ((checkAge(birthDate)) || checkFeb(birthDate))
                          ? 1.0
                          : 0.0,
                      duration: Duration(milliseconds: 100),
                      child: Container(
                        height: screenSize!.height / 20.3,
                        margin: EdgeInsets.symmetric(
                            horizontal: screenSize!.width / 12.5),
                        child: Align(
                          alignment: Alignment.center,
                          child: AutoSizeText(
                            checkFeb(birthDate)
                                ? "29 Feb doesnt exists at that date!"
                                : "Sorry, you are too young!",
                            minFontSize: 10,
                            style: TextStyle(
                              fontSize: 14,
                              color: errorRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GradientContainerBorder(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(dateNode);
                      },
                      radius: 60,
                      height: screenSize!.width / 5.53,
                      strokeWidth: 1.0,
                      width: MediaQuery.of(context).size.width,
                      gradient:
                          birthDate.length >= 8 ? appGradient : greyGradient,
                      child: Center(
                        child: GestureDetector(
                          onTap: () =>
                              FocusScope.of(context).requestFocus(dateNode),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: getRichText(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getRichText() {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: 5.0)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(controller!)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller!.reverse();
            }
          });
    final str = currentDate['date'];

    final errorInput = currentDate['errorInput'];
    final nextInputIndex = currentDate['nextInputIndex'];

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: nextInputIndex >= 0
                ? str.substring(0, nextInputIndex)
                : birthDate.length > 8 ? birthDate : str,
            style: TextStyle(
                fontSize: screenSize!.height / 50.75,
                letterSpacing: 10,
                color: Colors.black),
          ),
          WidgetSpan(
            child: nextInputIndex >= 0
                ? errorInput
                    ? AnimatedBuilder(
                        animation: offsetAnimation,
                        builder: (buildContext, child) {
                          if (offsetAnimation.value < 0.0) {
                            //  print('${offsetAnimation.value + 8.0}');
                          }

                          return Container(
                            padding: EdgeInsets.only(
                                left: offsetAnimation.value + 5.0,
                                right: 5.0 - offsetAnimation.value),
                            child: Text(
                              str[nextInputIndex],
                              style: TextStyle(color: pink),
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Text(
                          str[nextInputIndex],
                          style: TextStyle(color: pink),
                        ),
                      )
                : SizedBox(),
          ),
          TextSpan(
            text: nextInputIndex >= 0 && nextInputIndex < str.length
                ? str.substring(nextInputIndex + 1, str.length)
                : '',
            style: TextStyle(letterSpacing: 10, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> getDate() {
    String str = '';
    int nextInputIndex = 0;
    bool errorInput = false;
    print(currentDate['date']);
    switch (birthDate.length) {
      case 0:
        str = 'MM-DD-YYYY';
        break;
      case 1:
        if (int.parse(birthDate) <= 1) {
          str = '${birthDate}M-DD-YYYY';
          nextInputIndex = 1;
        } else {
          birthDate = '0' + birthDate;
          str = '$birthDate-DD-YYYY';
          nextInputIndex = 3;
          dateController.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: birthDate,
                      selection: TextSelection(baseOffset: 2, extentOffset: 2)))
              .value;
        }
        break;
      case 2:
        if (int.parse(birthDate) <= 12 && int.parse(birthDate) > 0) {
          str = '$birthDate-DD-YYYY';
          nextInputIndex = 3;
        } else {
          birthDate = birthDate[0];
          errorInput = true;
          nextInputIndex = 1;
          str = '${birthDate}M-DD-YYYY';
          dateController.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: birthDate,
                      selection: TextSelection(baseOffset: 1, extentOffset: 1)))
              .value;
        }
        break;
      case 3:
        if (birthDate.substring(0, 2) == '02') {
          if (int.parse(birthDate[2]) <= 2) {
            str = '${birthDate.substring(0, 2)}-${birthDate[2]}D-YYYY';
            nextInputIndex = 4;
          } else {
            birthDate = birthDate.substring(0, 2) + '0' + birthDate[2];
            str =
                '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-YYYY';
            nextInputIndex = 6;
            dateController.value = new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: birthDate,
                        selection:
                            TextSelection(baseOffset: 4, extentOffset: 4)))
                .value;
          }
        } else {
          if (int.parse(birthDate[2]) <= 3) {
            print(birthDate);
            str = '${birthDate.substring(0, 2)}-${birthDate[2]}D-YYYY';
            nextInputIndex = 4;
          } else {
            birthDate = birthDate.substring(0, 2) + '0' + birthDate[2];
            str =
                '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-YYYY';
            nextInputIndex = 6;
            dateController.value = new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: birthDate,
                        selection:
                            TextSelection(baseOffset: 4, extentOffset: 4)))
                .value;
          }
        }

        break;
      case 4:
        if (birthDate.substring(0, 2) == '12' ||
            birthDate.substring(0, 2) == '10' ||
            birthDate.substring(0, 2) == '08' ||
            birthDate.substring(0, 2) == '07' ||
            birthDate.substring(0, 2) == '05' ||
            birthDate.substring(0, 2) == '03' ||
            birthDate.substring(0, 2) == '01') {
          if (int.parse(birthDate.substring(2, 4)) <= 31 &&
              int.parse(birthDate.substring(2, 4)) > 0) {
            str =
                '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-YYYY';
            nextInputIndex = 6;
          } else {
            errorInput = true;
            nextInputIndex = 4;
            birthDate = birthDate.substring(0, 3);
            str = '${birthDate.substring(0, 2)}-${birthDate[2]}D-YYYY';
            dateController.value = new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: birthDate,
                        selection:
                            TextSelection(baseOffset: 3, extentOffset: 3)))
                .value;
          }
        } else {
          if (int.parse(birthDate.substring(2, 4)) <= 30 &&
              int.parse(birthDate.substring(2, 4)) > 0) {
            str =
                '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-YYYY';
            nextInputIndex = 6;
          } else {
            errorInput = true;
            nextInputIndex = 4;
            birthDate = birthDate.substring(0, 3);
            str = '${birthDate.substring(0, 2)}-${birthDate[2]}D-YYYY';
            dateController.value = new TextEditingController.fromValue(
                    new TextEditingValue(
                        text: birthDate,
                        selection:
                            TextSelection(baseOffset: 3, extentOffset: 3)))
                .value;
          }
        }
        break;
      case 5:
        if (int.parse(birthDate[4]) == 1 || int.parse(birthDate[4]) == 2) {
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate[4]}YYY';
          nextInputIndex = 7;
        } else {
          errorInput = true;
          nextInputIndex = 6;
          birthDate = birthDate.substring(0, 4);
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-YYYY';
          dateController.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: birthDate,
                      selection: TextSelection(baseOffset: 4, extentOffset: 4)))
              .value;
        }
        break;
      case 6:
        if (int.parse(birthDate[4]) == 1 && int.parse(birthDate[5]) == 9 ||
            int.parse(birthDate[4]) == 2 && int.parse(birthDate[5]) == 0) {
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate.substring(4, 6)}YY';
          nextInputIndex = 8;
        } else {
          errorInput = true;
          nextInputIndex = 7;
          birthDate = birthDate.substring(0, 5);
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate[4]}YYY';
          dateController.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: birthDate,
                      selection: TextSelection(baseOffset: 5, extentOffset: 5)))
              .value;
        }
        break;

      case 7:
        if (int.parse(birthDate[4]) == 1 && int.parse(birthDate[6]) >= 2 ||
            int.parse(birthDate[4]) == 2 && int.parse(birthDate[6]) <= 2) {
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate.substring(4, 7)}Y';
          nextInputIndex = 9;
        } else {
          errorInput = true;
          nextInputIndex = 8;
          birthDate = birthDate.substring(0, 6);
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate.substring(4, 6)}YY';
          dateController.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: birthDate,
                      selection: TextSelection(baseOffset: 6, extentOffset: 6)))
              .value;
        }
        break;

      case 8:
        if (int.parse(birthDate[4]) == 1 ||
            int.parse(birthDate[4]) == 2 &&
                int.parse(birthDate.substring(6, 8)) <= 20) {
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate.substring(4, 8)}';
          nextInputIndex = -1;
        } else {
          errorInput = true;
          nextInputIndex = 9;
          birthDate = birthDate.substring(0, 7);
          str =
              '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate.substring(4, 7)}Y';
          dateController.value = new TextEditingController.fromValue(
                  new TextEditingValue(
                      text: birthDate,
                      selection: TextSelection(baseOffset: 7, extentOffset: 7)))
              .value;
        }
        break;
      default:
        str =
            '${birthDate.substring(0, 2)}-${birthDate.substring(2, 4)}-${birthDate.substring(4, 8)}';
    }
    return {
      'date': str,
      'errorInput': errorInput,
      'nextInputIndex': nextInputIndex,
    };
  }
}
