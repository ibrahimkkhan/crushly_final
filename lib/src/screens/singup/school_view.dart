import '../../theme/theme.dart';
import '../../utils/gradient_container_border.dart';
import '../..//utils/utils.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class SchoolView extends StatelessWidget {
  final Function(String) schoolNameChanged;
  final String schoolName;
  final bool isCollege;

  const SchoolView(
      {Key? key, required this.schoolNameChanged, required this.isCollege, required this.schoolName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = TextEditingController();
    controller.value = TextEditingController.fromValue(new TextEditingValue(
      text: schoolName,
      selection: TextSelection(
        baseOffset: schoolName.length,
        extentOffset: schoolName.length,
      ),
    )).value;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                left: size.width / 12.5,
                right: size.width / 12.5,
                bottom: size.height / 27.06),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "\nI study at...",
                style: TextStyle(
                  fontSize: size.width / 12.5,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                  fontFamily: Fonts.SOMANTIC_FONT,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: size.height / 20.3, horizontal: size.width / 18.75),
            margin: EdgeInsets.symmetric(horizontal: size.width / 12.5),
            decoration: BoxDecoration(
                color: white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width / 18.75))),
            child: GradientContainerBorder(
              onPressed: () {},
              radius: size.height / 13.38,
              height: size.height / 13.38,
              strokeWidth: 1.0,
              width: MediaQuery.of(context).size.width,
              gradient: schoolName.isEmpty ? greyGradient : appGradient,
              child: Center(
                child: TextField(
                  controller: controller,
                  onChanged: (str) {
                    schoolNameChanged(str);
                  },
                  /* onTap: () => showSearch(
                      context: context, delegate: UserSearchDelegate()),*/
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: size.width / 18.75),
                    hintText:
                        isCollege ? 'University Name' : 'High School Name',
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
        ],
      ),
    );
  }
}
