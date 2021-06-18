import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/auth_bloc/auth_event.dart';
import '../../blocs/auth_bloc/auth_state.dart';
import '../../screens/singup/signup_page.dart';
import '../../theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/theme.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final _bloc = new AuthBloc();
  late Size screenSize;
  bool loading = false;

  @override
  void initState() {
    _bloc.add(GetLocationInitialState());
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: pageBackground,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: pink,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: BlocListener(
        listener: (BuildContext context, state) {
          if (state!.locationAcquiredSuccessfully || state.errorGettingLocation)
            _navigate();
        },
        listenWhen: (_, currentState) {
          return currentState is LocationState;
        },
        bloc: _bloc,
        child: BlocBuilder(
          buildWhen: (_, currentState) {
            return currentState is LocationState;
          },
          bloc: _bloc,
          builder: (context, AuthState state) {
            if (state is LocationState) {
              return Container(
                width: screenSize.width,
                color: pageBackground,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Container(
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Image.asset("lib/Fonts/Vector.png"),
                              Icon(
                                Icons.location_on,
                                color: pink,
                                size: screenSize.height / 10.15,
                              )
                            ],
                          ),
                        ),
                        Text(
                          "Need your location",
                          style: TextStyle(
                              fontSize: screenSize.width / 15,
                              color: darkBlue,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: screenSize.height / 81.2,
                        ),
                        Container(
                          width: screenSize.width / 1.52,
                          child: Text(
                            "Protected by copyright laws clause will inform that users",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenSize.width / 26.78,
                              color: lightBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _enableLocationButton(),
                  ],
                ),
              );
            } else
              return Container();
          },
        ),
      ),
    );
  }

  _enableLocationButton() {
    return BlocBuilder(
      bloc: _bloc,
      builder: (context, AuthState state) {
        if (state is LocationState) {
          return Container(
            child: FlatButton(
              color: locationButtonColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.width / 6)),
              onPressed: () async {
                if (!state.acquiringLocation) {
                  _bloc.add(GetLocation());
                }
              },
              child: Center(
                child: state.acquiringLocation
                    ? Container(
                        width: screenSize.width * 0.04,
                        height: screenSize.width * 0.04,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      )
                    : Text(
                        "Enable location services",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.width / 26.78),
                      ),
              ),
            ),
            width: screenSize.width / 1.19,
            height: screenSize.height / 14.5,
          );

          return GestureDetector(
            child: Container(
              width: screenSize.width,
              decoration: BoxDecoration(
                gradient: appGradient,
                borderRadius: BorderRadius.all(Radius.circular(32.0)),
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0),
              margin: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: screenSize.height * 0.12,
              ),
              alignment: Alignment.center,
              child: Text(
                "Enable location services",
                style: TextStyle(
                    color: Colors.white, fontSize: screenSize.width / 26.78),
              ),
            ),
            onTap: () {
              if (!state.acquiringLocation) _bloc.add(GetLocation());
            },
          );
        } else
          return Container();
      },
    );
  }

  _navigate() {
    WidgetsBinding.instance!.addPostFrameCallback((_) => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => SignUp()),
        ));
  }
}
/*return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TopPadding(32.0),
                            Expanded(
                              child: Image.asset(
                                'lib/Fonts/location_image.png',
                                width: screenSize.width,
                                fit: BoxFit.contain,
                              ),
                            ),
                            Text(
                              "Need your location",
                              style: TextStyle(
                                fontSize: screenSize.width / 15,
                                color: darkBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height / 81.2,
                            ),
                            Container(
                              width: screenSize.width / 1.52,
                              child: Text(
                                'Protected by copyright laws clause will inform that users',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: lightBlue,
                                  fontSize: screenSize.width / 26.78,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: screenSize.height / 6.10,
                            ),
                          ],
                        ),
                      ),
                      _enableLocationButton(),
                    ],
                  ),
                  Visibility(
                    visible: state.acquiringLocation,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );*/
