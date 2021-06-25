import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'src/blocs/Messenger_Bloc/bloc.dart';
import 'src/blocs/User_Bloc/bloc.dart';
import 'src/db/AppDB.dart';
import 'src/screens/SplashScreen.dart';
import 'src/screens/singup/signup_page.dart';
import 'src/SharedPref/SharedPref.dart';
import 'src/utils/scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:oktoast/oktoast.dart';

import 'src/blocs/auth_bloc/auth_bloc.dart';
import 'src/blocs/auth_bloc/auth_event.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() async {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final AppDataBase appDataBase = AppDataBase();

  AppLifecycleState appLifecycleState;

  MassengerBloc massengerBloc;
  UserBloc userBloc;

  // final _bloc = new AuthBloc();

  bool _isConnected = false;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return;
    }

    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      setState(() {
        print('Connection established');
        SharedPref.pref.getIsImagesUploaded().then((value) {
          if (value != null && value) {
            massengerBloc.add(Connect());
          } else {
            // _bloc.add(UploadImages());
          }
        });
        // _isConnected = true;
      });
    } else {
      print('Connection lost');
      SharedPref.pref.getIsImagesUploaded().then((value) {
        if (value != null && value) {
          massengerBloc.add(SuspendAppEvent());
        }
      });
    }
  }

  @override
  void initState() {
    massengerBloc = MassengerBloc(appDataBase);
    userBloc = UserBloc(appDataBase);

    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('The state is $state');
    appLifecycleState = state;

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      SharedPref.pref.getIsImagesUploaded().then((value) {
        if (value != null && value) {
          massengerBloc.add(SuspendAppEvent());
        }
      });
    }
    if (state == AppLifecycleState.resumed) {
      SharedPref.pref.getIsImagesUploaded().then((value) {
        if (value != null && value) {
          massengerBloc.add(Connect());
        }
      });
    }
  }

  changeStatusColor(Color color) async {
    try {
      await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
      FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // changeStatusColor(Colors.white);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // For hiding Status Bar
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    //  appDataBase.clearDB();
    return GestureDetector(
      onTap: () {
        print('clicked');
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          print('inside');
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create: (BuildContext context) => userBloc,
          ),
          BlocProvider<MassengerBloc>(
            create: (BuildContext context) => massengerBloc,
          ),
        ],
        child: OKToast(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              //splashFactory: NoSplashFactory(),
              primaryColor: Colors.white,
              fontFamily: 'Poppins',
            ),
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark.copyWith(
                    statusBarColor: Colors.white, // Color for Android
                    statusBarBrightness:
                    Brightness.dark // Dark == white status bar -- for IOS.
                ),
                child: Container(
                  color: Colors.white,
                  child: SafeArea(
                    bottom: false,
                    top: false,
                    child: ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child,
                    ),
                  ),
                ),
              );
            },
            home: SplashScreen(),
//        home: OtherUserProfile(myId: '5e1a0d7f1e0dd868dd225152', otherId: '5e1bab181e0dd868dd2251c8',),
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;

  bool pressed = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
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
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
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
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => SignUp()));
              },
              child: Text(
                "Create New Account",
                style: TextStyle(
                    fontSize: height * 0.02758620689, color: Colors.black87),
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
              onHighlightChanged: (valueChanged) {
                _timer = new Timer(
                  const Duration(milliseconds: 150),
                      () {
                    setState(() {
                      pressed = !pressed;
                    });
                  },
                );
              },
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: width * 0.00694444444,
                      color: Theme.of(context).primaryColor),
                  borderRadius: BorderRadius.circular(40)),
              child: Text("Login",
                  style: pressed
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

      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
/*
// {"myfollowees":[],"person":{"myfeed":[],"dateList":[],"ringsOffered":[],"ringsHolding":[],"_id":"5d5e6e7a7c4e5e7d4db25d69","name":"jh","followCount":0,"followList":[],"profilePhoto":"https://followlyprofilepictures.s3.us-east-2.amazonaws.com/placeholder/default.jpg","__v":0}}
// */

// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// /// IMPORTANT: running the following code on its own won't work as there is setup required for each platform head project.
// /// Please download the complete example app from the GitHub repository where all the setup has been done
// void main() async {
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   // NOTE: if you want to find out if the app was launched via notification then you could use the following call and then do something like
//   // change the default route of the app
//   // var notificationAppLaunchDetails =
//   //     await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//   runApp(
//     MaterialApp(
//       home: HomePage(),
//     ),
//   );
// }

// class PaddedRaisedButton extends StatelessWidget {
//   final String buttonText;
//   final VoidCallback onPressed;
//   const PaddedRaisedButton(
//       {@required this.buttonText, @required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
//       child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   var platform = MethodChannel('crossingthestreams.io/resourceResolver');

//   @override
//   initState() {
//     super.initState();
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     var initializationSettingsIOS = IOSInitializationSettings(
//         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     var initializationSettings = InitializationSettings(
//         initializationSettingsAndroid, initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Plugin example app'),
//         ),
//         body: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Center(
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
//                     child: Text(
//                         'Tap on a notification when it appears to trigger navigation'),
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show plain notification with payload',
//                     onPressed: () async {
//                       await _showNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Show plain notification that has no body with payload',
//                     onPressed: () async {
//                       await _showNotificationWithNoBody();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Show plain notification with payload and update channel description [Android]',
//                     onPressed: () async {
//                       await _showNotificationWithUpdatedChannelDescription();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Cancel notification',
//                     onPressed: () async {
//                       await _cancelNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Schedule notification to appear in 5 seconds, custom sound, red colour, large icon, red LED',
//                     onPressed: () async {
//                       await _scheduleNotification();
//                     },
//                   ),
//                   Text(
//                       'NOTE: red colour, large icon and red LED are Android-specific'),
//                   PaddedRaisedButton(
//                     buttonText: 'Repeat notification every minute',
//                     onPressed: () async {
//                       await _repeatNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Repeat notification every day at approximately 10:00:00 am',
//                     onPressed: () async {
//                       await _showDailyAtTime();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Repeat notification weekly on Monday at approximately 10:00:00 am',
//                     onPressed: () async {
//                       await _showWeeklyAtDayAndTime();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show notification with no sound',
//                     onPressed: () async {
//                       await _showNotificationWithNoSound();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show big picture notification [Android]',
//                     onPressed: () async {
//                       await _showBigPictureNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Show big picture notification, hide large icon on expand [Android]',
//                     onPressed: () async {
//                       await _showBigPictureNotificationHideExpandedLargeIcon();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show big text notification [Android]',
//                     onPressed: () async {
//                       await _showBigTextNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show inbox notification [Android]',
//                     onPressed: () async {
//                       await _showInboxNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show messaging notification [Android]',
//                     onPressed: () async {
//                       await _showMessagingNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show grouped notifications [Android]',
//                     onPressed: () async {
//                       await _showGroupedNotifications();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Show ongoing notification [Android]',
//                     onPressed: () async {
//                       await _showOngoingNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Show notification with no badge, alert only once [Android]',
//                     onPressed: () async {
//                       await _showNotificationWithNoBadge();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Show progress notification - updates every second [Android]',
//                     onPressed: () async {
//                       await _showProgressNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText:
//                         'Show indeterminate progress notification [Android]',
//                     onPressed: () async {
//                       await _showIndeterminateProgressNotification();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Check pending notifications',
//                     onPressed: () async {
//                       await _checkPendingNotificationRequests();
//                     },
//                   ),
//                   PaddedRaisedButton(
//                     buttonText: 'Cancel all notifications',
//                     onPressed: () async {
//                       await _cancelAllNotifications();
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _showNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', 'plain body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> _showNotificationWithNoBody() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'plain title', null, platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> _cancelNotification() async {
//     await flutterLocalNotificationsPlugin.cancel(0);
//   }

//   /// Schedules a notification that specifies a different icon, sound and vibration pattern
//   Future<void> _scheduleNotification() async {
//     var scheduledNotificationDateTime =
//         DateTime.now().add(Duration(seconds: 5));
//     var vibrationPattern = Int64List(4);
//     vibrationPattern[0] = 0;
//     vibrationPattern[1] = 1000;
//     vibrationPattern[2] = 5000;
//     vibrationPattern[3] = 2000;

//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your other channel id',
//         'your other channel name',
//         'your other channel description',
//         icon: 'secondary_icon',
//         sound: 'slow_spring_board',
//         largeIcon: 'sample_large_icon',
//         largeIconBitmapSource: BitmapSource.Drawable,
//         vibrationPattern: vibrationPattern,
//         enableLights: true,
//         color: const Color.fromARGB(255, 255, 0, 0),
//         ledColor: const Color.fromARGB(255, 255, 0, 0),
//         ledOnMs: 1000,
//         ledOffMs: 500);
//     var iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(sound: "slow_spring_board.aiff");
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.schedule(
//         0,
//         'scheduled title',
//         'scheduled body',
//         scheduledNotificationDateTime,
//         platformChannelSpecifics);
//   }

//   Future<void> _showNotificationWithNoSound() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'silent channel id',
//         'silent channel name',
//         'silent channel description',
//         playSound: false,
//         styleInformation: DefaultStyleInformation(true, true));
//     var iOSPlatformChannelSpecifics =
//         IOSNotificationDetails(presentSound: false);
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0, '<b>silent</b> title',
//         '<b>silent</b> body', platformChannelSpecifics);
//   }

//   Future<String> _downloadAndSaveImage(String url, String fileName) async {
//     var directory = await getApplicationDocumentsDirectory();
//     var filePath = '${directory.path}/$fileName';
//     var response = await http.get(url);
//     var file = File(filePath);
//     await file.writeAsBytes(response.bodyBytes);
//     return filePath;
//   }

//   Future<void> _showBigPictureNotification() async {
//     var largeIconPath = await _downloadAndSaveImage(
//         'http://via.placeholder.com/48x48', 'largeIcon');
//     var bigPicturePath = await _downloadAndSaveImage(
//         'http://via.placeholder.com/400x800', 'bigPicture');
//     var bigPictureStyleInformation = BigPictureStyleInformation(
//         bigPicturePath, BitmapSource.FilePath,
//         largeIcon: largeIconPath,
//         largeIconBitmapSource: BitmapSource.FilePath,
//         contentTitle: 'overridden <b>big</b> content title',
//         htmlFormatContentTitle: true,
//         summaryText: 'summary <i>text</i>',
//         htmlFormatSummaryText: true);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'big text channel id',
//         'big text channel name',
//         'big text channel description',
//         style: AndroidNotificationStyle.BigPicture,
//         styleInformation: bigPictureStyleInformation);
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'big text title', 'silent body', platformChannelSpecifics);
//   }

//   Future<void> _showBigPictureNotificationHideExpandedLargeIcon() async {
//     var largeIconPath = await _downloadAndSaveImage(
//         'http://via.placeholder.com/48x48', 'largeIcon');
//     var bigPicturePath = await _downloadAndSaveImage(
//         'http://via.placeholder.com/400x800', 'bigPicture');
//     var bigPictureStyleInformation = BigPictureStyleInformation(
//         bigPicturePath, BitmapSource.FilePath,
//         hideExpandedLargeIcon: true,
//         contentTitle: 'overridden <b>big</b> content title',
//         htmlFormatContentTitle: true,
//         summaryText: 'summary <i>text</i>',
//         htmlFormatSummaryText: true);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'big text channel id',
//         'big text channel name',
//         'big text channel description',
//         largeIcon: largeIconPath,
//         largeIconBitmapSource: BitmapSource.FilePath,
//         style: AndroidNotificationStyle.BigPicture,
//         styleInformation: bigPictureStyleInformation);
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'big text title', 'silent body', platformChannelSpecifics);
//   }

//   Future<void> _showBigTextNotification() async {
//     var bigTextStyleInformation = BigTextStyleInformation(
//         'Lorem <i>ipsum dolor sit</i> amet, consectetur <b>adipiscing elit</b>, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
//         htmlFormatBigText: true,
//         contentTitle: 'overridden <b>big</b> content title',
//         htmlFormatContentTitle: true,
//         summaryText: 'summary <i>text</i>',
//         htmlFormatSummaryText: true);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'big text channel id',
//         'big text channel name',
//         'big text channel description',
//         style: AndroidNotificationStyle.BigText,
//         styleInformation: bigTextStyleInformation);
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'big text title', 'silent body', platformChannelSpecifics);
//   }

//   Future<void> _showInboxNotification() async {
//     var lines = List<String>();
//     lines.add('line <b>1</b>');
//     lines.add('line <i>2</i>');
//     var inboxStyleInformation = InboxStyleInformation(lines,
//         htmlFormatLines: true,
//         contentTitle: 'overridden <b>inbox</b> context title',
//         htmlFormatContentTitle: true,
//         summaryText: 'summary <i>text</i>',
//         htmlFormatSummaryText: true);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'inbox channel id', 'inboxchannel name', 'inbox channel description',
//         style: AndroidNotificationStyle.Inbox,
//         styleInformation: inboxStyleInformation);
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'inbox title', 'inbox body', platformChannelSpecifics);
//   }

//   Future<void> _showMessagingNotification() async {
//     // use a platform channel to resolve an Android drawable resource to a URI.
//     // This is NOT part of the notifications plugin. Calls made over this channel is handled by the app
//     String imageUri = await platform.invokeMethod('drawableToUri', 'food');
//     var messages = List<Message>();
//     // First two person objects will use icons that part of the Android app's drawable resources
//     var me = Person(
//         name: 'Me',
//         key: '1',
//         uri: 'tel:1234567890',
//         icon: 'me',
//         iconSource: IconSource.Drawable);
//     var coworker = Person(
//         name: 'Coworker',
//         key: '2',
//         uri: 'tel:9876543210',
//         icon: 'coworker',
//         iconSource: IconSource.Drawable);
//     // download the icon that would be use for the lunch bot person
//     var largeIconPath = await _downloadAndSaveImage(
//         'http://via.placeholder.com/48x48', 'largeIcon');
//     // this person object will use an icon that was downloaded
//     var lunchBot = Person(
//         name: 'Lunch bot',
//         key: 'bot',
//         bot: true,
//         icon: largeIconPath,
//         iconSource: IconSource.FilePath);
//     messages.add(Message('Hi', DateTime.now(), null));
//     messages.add(Message(
//         'What\'s up?', DateTime.now().add(Duration(minutes: 5)), coworker));
//     messages.add(Message(
//         'Lunch?', DateTime.now().add(Duration(minutes: 10)), null,
//         dataMimeType: 'image/png', dataUri: imageUri));
//     messages.add(Message('What kind of food would you prefer?',
//         DateTime.now().add(Duration(minutes: 10)), lunchBot));
//     var messagingStyle = MessagingStyleInformation(me,
//         groupConversation: true,
//         conversationTitle: 'Team lunch',
//         htmlFormatContent: true,
//         htmlFormatTitle: true,
//         messages: messages);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'message channel id',
//         'message channel name',
//         'message channel description',
//         style: AndroidNotificationStyle.Messaging,
//         styleInformation: messagingStyle);
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'message title', 'message body', platformChannelSpecifics);

//     // wait 10 seconds and add another message to simulate another response
//     await Future.delayed(Duration(seconds: 10), () async {
//       messages.add(
//           Message('Thai', DateTime.now().add(Duration(minutes: 11)), null));
//       await flutterLocalNotificationsPlugin.show(
//           0, 'message title', 'message body', platformChannelSpecifics);
//     });
//   }

//   Future<void> _showGroupedNotifications() async {
//     var groupKey = 'com.android.example.WORK_EMAIL';
//     var groupChannelId = 'grouped channel id';
//     var groupChannelName = 'grouped channel name';
//     var groupChannelDescription = 'grouped channel description';
//     // example based on https://developer.android.com/training/notify-user/group.html
//     var firstNotificationAndroidSpecifics = AndroidNotificationDetails(
//         groupChannelId, groupChannelName, groupChannelDescription,
//         importance: Importance.Max,
//         priority: Priority.High,
//         groupKey: groupKey);
//     var firstNotificationPlatformSpecifics =
//         NotificationDetails(firstNotificationAndroidSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(1, 'Alex Faarborg',
//         'You will not believe...', firstNotificationPlatformSpecifics);
//     var secondNotificationAndroidSpecifics = AndroidNotificationDetails(
//         groupChannelId, groupChannelName, groupChannelDescription,
//         importance: Importance.Max,
//         priority: Priority.High,
//         groupKey: groupKey);
//     var secondNotificationPlatformSpecifics =
//         NotificationDetails(secondNotificationAndroidSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         2,
//         'Jeff Chang',
//         'Please join us to celebrate the...',
//         secondNotificationPlatformSpecifics);

//     // create the summary notification to support older devices that pre-date Android 7.0 (API level 24).
//     // this is required is regardless of which versions of Android your application is going to support
//     var lines = List<String>();
//     lines.add('Alex Faarborg  Check this out');
//     lines.add('Jeff Chang    Launch Party');
//     var inboxStyleInformation = InboxStyleInformation(lines,
//         contentTitle: '2 messages', summaryText: 'janedoe@example.com');
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         groupChannelId, groupChannelName, groupChannelDescription,
//         style: AndroidNotificationStyle.Inbox,
//         styleInformation: inboxStyleInformation,
//         groupKey: groupKey,
//         setAsGroupSummary: true);
//     var platformChannelSpecifics =
//         NotificationDetails(androidPlatformChannelSpecifics, null);
//     await flutterLocalNotificationsPlugin.show(
//         3, 'Attention', 'Two messages', platformChannelSpecifics);
//   }

//   Future<void> _checkPendingNotificationRequests() async {
//     var pendingNotificationRequests =
//         await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//     for (var pendingNotificationRequest in pendingNotificationRequests) {
//       debugPrint(
//           'pending notification: [id: ${pendingNotificationRequest.id}, title: ${pendingNotificationRequest.title}, body: ${pendingNotificationRequest.body}, payload: ${pendingNotificationRequest.payload}]');
//     }
//     return showDialog<void>(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           content: Text(
//               '${pendingNotificationRequests.length} pending notification requests'),
//           actions: [
//             FlatButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   Future<void> _cancelAllNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   Future<void> onSelectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: ' + payload);
//     }

//     await Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => SecondScreen(payload)),
//     );
//   }

//   Future<void> _showOngoingNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id', 'your channel name', 'your channel description',
//         importance: Importance.Max,
//         priority: Priority.High,
//         ongoing: true,
//         autoCancel: false);
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(0, 'ongoing notification title',
//         'ongoing notification body', platformChannelSpecifics);
//   }

//   Future<void> _repeatNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'repeating channel id',
//         'repeating channel name',
//         'repeating description');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
//         'repeating body', RepeatInterval.EveryMinute, platformChannelSpecifics);
//   }

//   Future<void> _showDailyAtTime() async {
//     var time = Time(10, 0, 0);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'repeatDailyAtTime channel id',
//         'repeatDailyAtTime channel name',
//         'repeatDailyAtTime description');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showDailyAtTime(
//         0,
//         'show daily title',
//         'Daily notification shown at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//         time,
//         platformChannelSpecifics);
//   }

//   Future<void> _showWeeklyAtDayAndTime() async {
//     var time = Time(10, 0, 0);
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'show weekly channel id',
//         'show weekly channel name',
//         'show weekly description');
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//         0,
//         'show weekly title',
//         'Weekly notification shown on Monday at approximately ${_toTwoDigitString(time.hour)}:${_toTwoDigitString(time.minute)}:${_toTwoDigitString(time.second)}',
//         Day.Monday,
//         time,
//         platformChannelSpecifics);
//   }

//   Future<void> _showNotificationWithNoBadge() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'no badge channel', 'no badge name', 'no badge description',
//         channelShowBadge: false,
//         importance: Importance.Max,
//         priority: Priority.High,
//         onlyAlertOnce: true);
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0, 'no badge title', 'no badge body', platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> _showProgressNotification() async {
//     var maxProgress = 5;
//     for (var i = 0; i <= maxProgress; i++) {
//       await Future.delayed(Duration(seconds: 1), () async {
//         var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//             'progress channel',
//             'progress channel',
//             'progress channel description',
//             channelShowBadge: false,
//             importance: Importance.Max,
//             priority: Priority.High,
//             onlyAlertOnce: true,
//             showProgress: true,
//             maxProgress: maxProgress,
//             progress: i);
//         var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//         var platformChannelSpecifics = NotificationDetails(
//             androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//         await flutterLocalNotificationsPlugin.show(
//             0,
//             'progress notification title',
//             'progress notification body',
//             platformChannelSpecifics,
//             payload: 'item x');
//       });
//     }
//   }

//   Future<void> _showIndeterminateProgressNotification() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'indeterminate progress channel',
//         'indeterminate progress channel',
//         'indeterminate progress channel description',
//         channelShowBadge: false,
//         importance: Importance.Max,
//         priority: Priority.High,
//         onlyAlertOnce: true,
//         showProgress: true,
//         indeterminate: true);
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'indeterminate progress notification title',
//         'indeterminate progress notification body',
//         platformChannelSpecifics,
//         payload: 'item x');
//   }

//   Future<void> _showNotificationWithUpdatedChannelDescription() async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//         'your channel id',
//         'your channel name',
//         'your updated channel description',
//         importance: Importance.Max,
//         priority: Priority.High,
//         channelAction: AndroidNotificationChannelAction.Update);
//     var iOSPlatformChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics = NotificationDetails(
//         androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//         0,
//         'updated notification channel',
//         'check settings to see updated channel description',
//         platformChannelSpecifics,
//         payload: 'item x');
//   }

//   String _toTwoDigitString(int value) {
//     return value.toString().padLeft(2, '0');
//   }

//   Future<void> onDidReceiveLocalNotification(
//       int id, String title, String body, String payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//     await showDialog(
//       context: context,
//       builder: (BuildContext context) => CupertinoAlertDialog(
//         title: title != null ? Text(title) : null,
//         content: body != null ? Text(body) : null,
//         actions: [
//           CupertinoDialogAction(
//             isDefaultAction: true,
//             child: Text('Ok'),
//             onPressed: () async {
//               Navigator.of(context, rootNavigator: true).pop();
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => SecondScreen(payload),
//                 ),
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }

// class SecondScreen extends StatefulWidget {
//   SecondScreen(this.payload);

//   final String payload;

//   @override
//   State<StatefulWidget> createState() => SecondScreenState();
// }

// class SecondScreenState extends State<SecondScreen> {
//   String _payload;
//   @override
//   void initState() {
//     super.initState();
//     _payload = widget.payload;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Second Screen with payload: ${(_payload ?? '')}'),
//       ),
//       body: Center(
//         child: RaisedButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text('Go back!'),
//         ),
//       ),
//     );
//   }
// }
