import 'dart:async';

import '../blocs/Messenger_Bloc/bloc.dart';
import '../../MainScreen.dart';
import 'auth/sign_in.dart';
import '../SharedPref/SharedPref.dart';
import '../models/User.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUser(context);
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    print(sizeAware.height * 0.06896551724);
    print((47 / sizeAware.height) * sizeAware.height);
    return BlocListener(
      bloc: BlocProvider.of<MassengerBloc>(context),
      listenWhen: (_, curr) => curr is Connected,
      listener: (context, MassengerState state) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainScreen()));
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          height: sizeAware.height,
          width: sizeAware.width,
          color: Color(0xFF454F63),
          child: Text(
            "Crushly",
            style: TextStyle(
              color: Colors.white,
              fontFamily: Fonts.SOMANTIC_FONT,
              fontSize: sizeAware.height / 16.91,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  checkUser(BuildContext context) async {
    User? user = (await SharedPref.pref.checkLogin());
//    if (user != null) BlocProvider.of<UserBloc>(context).add(FetchUser());
    if (user != null) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black12,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ));
      BlocProvider.of<MassengerBloc>(context).add(Connect());
    }
    Timer(Duration(seconds: 2), () {
      if (user == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignIn()));
      }
    });
  }
}
