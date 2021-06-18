import 'package:flutter/material.dart';

class SignupName extends StatelessWidget {
  const SignupName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
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
                text == " " || text.isEmpty
                    ? "please insert your first name "
                    : null,
                onSaved: (t) => fname = t,
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
        Column(
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

      ],
    );
  }
}
