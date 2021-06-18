import '../../widgets/big_text.dart';
import '../../widgets/error_label.dart';
import '../../widgets/tf_gradiant_parent.dart';
import '../../widgets/widget_utils.dart';
import '../../theme/theme.dart';
import '../../utils/utils.dart';
import 'package:flutter/material.dart';

class EnterUniversity extends StatefulWidget {
  //
  final Function onSchoolChanged;

  EnterUniversity({
    Key? key,
    required this.onSchoolChanged,
    required this.schoolName,
  }) : super(key: key);

  final String schoolName;

  @override
  EnterUniversityState createState() => EnterUniversityState();
}

class EnterUniversityState extends State<EnterUniversity> {
  //
  final TextEditingController _universityNameController =
      TextEditingController();
  FocusNode _focusNode = FocusNode();
  late bool _isError;

  @override
  void initState() {
    super.initState();
    _universityNameController.text = widget.schoolName;
    _isError = false;
  }

  @override
  Widget build(BuildContext context) {
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
                text: 'I study at...',
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
                    SizedBox(height: 25),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 10, 20, 0),
                      child: GradientBorder(
                        enabledGradient:
                            null != _universityNameController.text &&
                                    _universityNameController.text.isEmpty
                                ? false
                                : true,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
                          child: TextField(
                            focusNode: _focusNode,
                            controller: _universityNameController,
                            textInputAction: TextInputAction.next,
                            onChanged: (text) async {
                              setState(() {
                                _isError = isError();
                              });
                            },
                            onEditingComplete: () {
                              _focusNode.unfocus();
                              widget.onSchoolChanged(
                                  _universityNameController.text);
                            },
                            textDirection: TextDirection.ltr,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              hintText: 'University/College',
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              hintStyle: TextStyle(
                                color: grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    _isError
                        ? ErrorLabel(
                            marginInsets: EdgeInsets.fromLTRB(40, 10, 30, 0),
                            text: 'Please enter you university name',
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

  bool isError() {
    return _universityNameController.text.isEmpty;
  }
}
