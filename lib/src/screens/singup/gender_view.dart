
import 'gender_screen.dart';
import 'signup_page.dart';
import '../../widgets/big_text.dart';

import '../../theme/theme.dart';
import '../../utils/gender_button.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';

class GenderView extends StatefulWidget {
  final Function(String) genderChanged;
  final String secondText;
  final String? firstText;
  final String gender;
  final double newValue;
  final GenderType genderType;

  GenderView(
      {required this.gender,
      required this.newValue,
      this.firstText,
      required this.secondText,
      required this.genderChanged,
      required this.genderType});

  @override
  _GenderViewState createState() => _GenderViewState();
}

class _GenderViewState extends State<GenderView> {
  late Size screenSize;
  late String gender;

  @override
  void initState() {
    gender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    value = widget.newValue;
    screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        left: screenSize.width / 15.625,
        right: screenSize.width / 15.625,
        top: screenSize.height / 8.63,
      ),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          BigTxt(
            text: widget.secondText ?? '\n',
            fontFamily: Fonts.SOMANTIC_FONT,
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: screenSize.width / 12),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       widget.secondText ?? '\n',
          //       maxLines: 1,
          //       style: TextStyle(
          //         fontSize: 30,
          //         fontWeight: FontWeight.bold,
          //         color: darkBlue,
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: screenSize.height / 33.83),
          Container(
            height: screenSize.height / 2.62,
            padding: EdgeInsets.symmetric(
                vertical: screenSize.height / 20.3,
                horizontal: screenSize.width / 18.75),
//              margin: EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Column(
              children: <Widget>[
                GenderButton(
                  option: widget.secondText != "I\'m interested in..."
                      ? genders[0]
                      : interestedGenders[0],
                  selectedOption: gender,
                  onClick: () => setState(
                    () {
                      gender = widget.secondText != "I\'m interested in..."
                          ? genders[0]
                          : interestedGenders[0];
                      if (widget.genderChanged == null)
                        Navigator.of(context).pop(
                          widget.secondText != "I\'m interested in..."
                              ? genders[0]
                              : interestedGenders[0],
                        );
                      else
                        widget.genderChanged(
                            widget.secondText != "I\'m interested in..."
                                ? genders[0]
                                : interestedGenders[0]);
                    },
                  ),
                ),
                SizedBox(
                  height: screenSize.height / 33.83,
                ),
                GenderButton(
                  option: widget.secondText != "I\'m interested in..."
                      ? genders[1]
                      : interestedGenders[1],
                  selectedOption: gender,
                  onClick: () => setState(
                    () {
                      gender = widget.secondText != "I\'m interested in..."
                          ? genders[1]
                          : interestedGenders[1];
                      if (widget.genderChanged == null)
                        Navigator.of(context).pop(
                            widget.secondText != "I\'m interested in..."
                                ? genders[1]
                                : interestedGenders[1]);
                      else
                        widget.genderChanged(
                            widget.secondText != "I\'m interested in..."
                                ? genders[1]
                                : interestedGenders[1]);
                    },
                  ),
                ),
                SizedBox(
                  height: screenSize.height / 33.83,
                ),
                GenderButton(
                  option: genders[2],
                  selectedOption: gender,
                  onClick: () => setState(
                    () {
                      gender = genders[2];
                      if (widget.genderChanged == null)
                        Navigator.of(context).pop(genders[2]);
                      else
                        widget.genderChanged(genders[2]);
                    },
                  ),
                ),
                /* gender != null &&
                        genders.indexOf(gender) != -1 &&
                        genders.indexOf(gender) != 0 &&
                        genders.indexOf(gender) != 1
                    ? Padding(
                        padding: EdgeInsets.only(top: 24.0),
                        child: SelectableButton(
                          option: genders[genders.indexOf(gender)],
                          selectedOption: gender,
                          onClick: () => setState(() {
                            if (genders.indexOf(gender) != -1) {
                              gender = genders[genders.indexOf(gender)];
                              if (widget.genderChanged == null)
                                Navigator.of(context)
                                    .pop(genders[genders.indexOf(gender)]);
                              else
                                widget.genderChanged(
                                    genders[genders.indexOf(gender)]);
                            }
                          }),
                        ),
                      )
                    : SizedBox(),*/
              ],
            ),
          ),

          /*gender == null || genders.indexOf(gender) <= 1
              ? Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new GendersScreen(
                                    genderType: widget.genderType,
                                  )));
                      gender = result ?? gender;
                      if (widget.genderChanged == null)
                        Navigator.of(context).pop(result ?? gender);
                      else
                        widget.genderChanged(result ?? gender);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text(
                        'More',
                        style: TextStyle(
                          color: accent,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              : SizedBox(),*/
        ],
      ),
    );
  }
}
