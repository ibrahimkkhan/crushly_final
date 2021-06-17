import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Divider(
            height: height * 0.2,
            color: Colors.white,
          ),
          Text(
            'LOGO',
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: height * 0.06896551724,
                fontWeight: FontWeight.bold),
          ),
          Divider(
            height: height * 0.0275,
            color: Colors.white,
          ),
          Text(
            'Welcome to the App',
            style: TextStyle(
                color: Colors.black,
                fontSize: height * 0.04137931034,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: width * 0.14,
                left: width * 0.14,
                top: height * 0.027,
                bottom: height * 0.08),
            child: Text(
              'Welcome to Crushly',
              style: TextStyle(
                color: Colors.black,
                fontSize: height * 0.02758620689,
              ),
            ),
          ),
          SizedBox(
            width: width * 0.8888,
            height: height * 0.08,
            child: RaisedButton(
              elevation: 2,
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Text("Sign Up Form")));
                // Add signup nav here
              },
              child: Text(
                "Create New Account",
                style: TextStyle(
                    fontSize: height * 0.02758620689, color: Colors.white),
              ),
            ),
          ),
          Divider(
            height: height * 0.04,
            color: Colors.white,
          ),
          SizedBox(
            width: width * 0.8888,
            height: height * 0.08,
            child: RaisedButton(
              highlightElevation: 0,
              highlightColor: Theme.of(context).primaryColor,
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: width * 0.00694444444,
                      color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(40)),
              child: Text("Login",
                  style: true
                      ? TextStyle(
                      fontSize: height * 0.02758620689,
                      color: Theme.of(context).primaryColor)
                      : TextStyle(
                      fontSize: height * 0.02758620689,
                      color: Colors.white)),
              onPressed: () {
                Navigator.of(context).pushNamed("/display");
              },
            ),
          ),
        ],
      ),
    );
  }
}
