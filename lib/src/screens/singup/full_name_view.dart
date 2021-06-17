import '../../widgets/big_text.dart';
import '../../widgets/error_label.dart';
import '../../widgets/tf_gradiant_parent.dart';
import '../../widgets/widget_utils.dart';
import '../../theme/theme.dart';
// import '../../utils/gradient_container_border.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';

class FullNameView extends StatelessWidget {
  final onSubmitted;

  _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  final Function(String) firstNameChanged;
  final Function(String) lastNameChanged;
  String firstName = '';
  String lastName = '';
  final focusNode;
  final focusNode2;
  final String _firstNameErrorTxt =
      'The first name must only contain alphabetical characters';
  final String _lastNameErrorTxt =
      'The last name must only contain alphabetical characters';

  RegExp regExp = new RegExp(
    "[a-zA-Z]+",
    caseSensitive: false,
    multiLine: false,
  );

  FullNameView({
    Key? key,
    this.focusNode,
    this.focusNode2,
    this.onSubmitted,
    required this.firstNameChanged,
    required this.lastNameChanged,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final kInnerDecoration = BoxDecoration(
    color: Colors.white,
    border: Border.all(color: Colors.white),
    borderRadius: BorderRadius.circular(32),
  );

  @override
  Widget build(BuildContext context) {
    firstNameController.text = firstName;
    lastNameController.text = lastName;
    firstNameController.selection = TextSelection(
      baseOffset: firstName.length,
      extentOffset: firstName.length,
    );
    lastNameController.selection = TextSelection(
      baseOffset: lastName.length,
      extentOffset: lastName.length,
    );
    bool isFirstNameEmpty = _isFirstNameEmpty();
    bool isLastNameEmpty = _islastNameEmpty();
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BigTxt(
                text: 'I am...',
                fontFamily: Fonts.SOMANTIC_FONT,
              ),
              SizedBox(height: 30),
              Container(
                decoration: WidgetUtils.getParentDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                      child: GradientBorder(
                        enabledGradient: firstName.isNotEmpty,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                          child: TextField(
                            controller: firstNameController,
                            onTap: () async {
                              // _fieldFocusChange(context, focusNode2, focusNode);
                            },
                            focusNode: focusNode,
                            maxLines: 1,
                            onChanged: firstNameChanged,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              // _fieldFocusChange(context, focusNode, focusNode2);
                              // FocusScope.of(context).requestFocus(
                              //     FocusScope.of(context).nearestScope);
                            },
                            decoration: InputDecoration(
                              hintText: 'First Name',
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
                    isFirstNameEmpty
                        ? ErrorLabel(
                            marginInsets: EdgeInsets.fromLTRB(40, 10, 30, 10),
                            text: _firstNameErrorTxt,
                          )
                        : SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                      child: GradientBorder(
                        enabledGradient: lastName.isNotEmpty,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                          child: TextField(
                            controller: lastNameController,
                            onTap: () async {
                              _fieldFocusChange(context, focusNode, focusNode2);
                            },
                            focusNode: focusNode2,
                            maxLines: 1,
                            onChanged: lastNameChanged,
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              if (_islastNameEmpty() || _isFirstNameEmpty()) {
                                return;
                              }
                              onSubmitted();
                            },
                            decoration: InputDecoration(
                              hintText: 'Last Name',
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
                    isLastNameEmpty
                        ? ErrorLabel(
                            marginInsets: EdgeInsets.fromLTRB(40, 10, 30, 0),
                            text: _lastNameErrorTxt,
                          )
                        : SizedBox(height: 0),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _isFirstNameEmpty() {
    return firstName.isNotEmpty &&
        (regExp.stringMatch(firstName) == null ||
            regExp.stringMatch(firstName)!.length != firstName.length);
  }

  _islastNameEmpty() {
    return lastName.isNotEmpty &&
        (regExp.stringMatch(lastName) == null ||
            regExp.stringMatch(lastName)!.length != lastName.length);
  }

//   @override
//   Widget build(BuildContext context) {
//     value = 1 / 7;
//     Size screenSize = MediaQuery.of(context).size;
//     firstNameController.text = firstName;
//     lastNameController.text = lastName;
//     firstNameController.selection = TextSelection(
//       baseOffset: firstName.length,
//       extentOffset: firstName.length,
//     );
//     lastNameController.selection = TextSelection(
//       baseOffset: lastName.length,
//       extentOffset: lastName.length,
//     );
//     print(firstNameController.text);
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Padding(
//           padding: EdgeInsets.only(
//               top: screenSize.height / 9.02, left: screenSize.width / 5),
//           child: Align(
//             alignment: Alignment.centerLeft,
//             child: Text(
//               "I am...",
//               style: TextStyle(
//                 fontSize: screenSize.width / 12.5,
//                 fontWeight: FontWeight.bold,
//                 color: darkBlue,
//               ),
//             ),
//           ),
//         ),
//         SizedBox(
//           height: screenSize.height / 27.06,
//         ),
//         Container(
//           //  padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
//           // margin: EdgeInsets.symmetric(horizontal: 24.0),
//           width: screenSize.width / 1.19,
//           padding: EdgeInsets.symmetric(horizontal: screenSize.width / 18.75),
//           decoration: BoxDecoration(
//               color: white,
//               borderRadius: BorderRadius.circular(screenSize.width / 18.75)),
//           child: Column(
//             children: <Widget>[
//               AnimatedOpacity(
//                 opacity: firstName.isNotEmpty &&
//                         (regExp.stringMatch(firstName) == null ||
//                             regExp.stringMatch(firstName).length !=
//                                 firstName.length)
//                     ? 1.0
//                     : 0.0,
//                 duration: Duration(milliseconds: 100),
//                 child: Container(
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: ErrorLabel(
//                       text:
//                           'The name must only contain alphabetical characters',
//                     ),
//                   ),
//                 ),
//               ),
//               GradientContainerBorder(
//                 onPressed: () {},
//                 radius: screenSize.width / 6.25,
//                 height: screenSize.width / 6.25,
//                 strokeWidth: 1.0,
//                 width: screenSize.width / 1.36,
//                 gradient: firstName.isEmpty ? greyGradient : appGradient,
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 24.0),
//                     child: TextField(
//                       controller: firstNameController,
//                       onTap: () {
//                         _fieldFocusChange(context, focusNode2, focusNode);
//                       },
//                       focusNode: focusNode,
//                       maxLines: 1,
//                       onChanged: firstNameChanged,
//                       //   controller: firstNameController,
//                       textInputAction: TextInputAction.next,
//                       onEditingComplete: () {
//                         _fieldFocusChange(context, focusNode, focusNode2);
//                         FocusScope.of(context)
//                             .requestFocus(FocusScope.of(context).nearestScope);
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'First Name',
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         focusedErrorBorder: InputBorder.none,
//                         hintStyle: TextStyle(
//                           color: textFieldHintTextColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: screenSize.height / 33.83),
//               GradientContainerBorder(
//                 onPressed: () {},
//                 radius: screenSize.width / 6.25,
//                 height: screenSize.width / 6.25,
//                 strokeWidth: 1.0,
//                 width: screenSize.width / 1.36,
//                 gradient: lastName.isEmpty ? greyGradient : appGradient,
//                 child: Center(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 24.0),
//                     child: TextField(
//                       controller: lastNameController,
//                       onTap: () {
//                         _fieldFocusChange(context, focusNode, focusNode2);
//                       },
//                       focusNode: focusNode2,
//                       maxLines: 1,
//                       onChanged: lastNameChanged,
//                       //  controller: lastNameController,
//                       textInputAction: TextInputAction.done,
//                       onEditingComplete: () {
//                         FocusScope.of(context).unfocus();
//                         if (firstNameController.text.isNotEmpty &&
//                             lastNameController.text.isNotEmpty) {
//                           onSubmitted();
//                         }
//                       },
//                       decoration: InputDecoration(
//                         hintText: 'Last Name',
//                         enabledBorder: InputBorder.none,
//                         errorBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         focusedErrorBorder: InputBorder.none,
//                         hintStyle: TextStyle(
//                           color: textFieldHintTextColor,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               AnimatedOpacity(
//                 opacity: lastName.isNotEmpty &&
//                         (regExp.stringMatch(lastName) == null ||
//                             regExp.stringMatch(lastName).length !=
//                                 lastName.length)
//                     ? 1.0
//                     : 0.0,
//                 duration: Duration(milliseconds: 100),
//                 child: Container(
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: ErrorLabel(
//                       text:
//                           'The name must only contain alphabetical characters',
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
}
