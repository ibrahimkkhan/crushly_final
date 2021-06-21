import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/User_Bloc/bloc.dart';
import '../blocs/User_Bloc/user_state.dart';
import '../DB/AppDB.dart' as db;
import '../Screens/OtherProfile.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationPage extends StatefulWidget {
  final String myId;

  NotificationPage(this.myId);

  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  void initState() {
    BlocProvider.of<UserBloc>(context).add(GetNotification());
    super.initState();
  }
  /*{
        BlocProvider.of<UserBloc>(context).appDataBase.setAllNotificationSeen();
        return Future.value(true);
      }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print('see all notifications');
        BlocProvider.of<UserBloc>(context).appDataBase.setAllNotificationSeen();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 40,
              color: pink,
            ),
            onPressed: () => Navigator.maybePop(context),
          ),
          title: Text(
            "Notifications",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accent,
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: pageBackground,
        body: BlocBuilder<UserBloc, UserState>(
          condition: (prev, cur) =>
              cur is LoadingNotification || cur is NotificationReady,
          builder: (context, state) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.only(left: screenSize.width / 8),
                  //   child: Text(
                  //     "Notifications",
                  //     style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: screenSize.height / 33.83),
                  //   ),
                  // ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 8.0),
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20.0),
                          right: Radius.circular(20.0),
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          state is NotificationReady
                              ? ListView.builder(
                                  itemCount: state.notifications.length,
                                  itemBuilder: (context, counter) {
                                    return NotificationTile(
                                      myId: widget.myId,
                                      notification:
                                          state.notifications[counter],
                                    );
                                  },
                                )
                              : SizedBox(),
                          Visibility(
                            visible: state is NotificationReady &&
                                state.notifications.isEmpty,
                            child: Center(
                              child: Text("No Notifications"),
                            ),
                          ),
                          Visibility(
                            visible: state is LoadingNotification,
                            child: Center(
                              child: SpinKitThreeBounce(
                                duration: Duration(milliseconds: 1000),
                                color: lightGrey,
                                size: 50.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _navigate({Widget screen}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }
}
/* title: Padding(
            padding: EdgeInsets.only(
                top: screenSize.height / 27.06, bottom: screenSize.height / 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /* IconButton(
                    icon: ShadowIcon(
                      icon: CustomIcons.ic_profile,
                      color: Colors.white,
                      size: 24,
                    ),
                    onPressed: () {
                      widget.mainScreenDelegate
                          .iconClicked(MainScreenIcon.PROFILE);
                    },
                  ),*/
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width / 15.625),
                      icon: Container(
                        width: screenSize.width / 15.625,
                        height: screenSize.width / 15.625,
                        child: Image.asset(
                          'lib/Fonts/user3.png',
                          color: darkBlue,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerLeft,
                      icon: Container(
                        width: screenSize.width / 15.625,
                        height: screenSize.width / 15.625,
                        child: Image.asset(
                          'lib/Fonts/searchIcon.png',
                          color: darkBlue,
                        ),
                      ),
                    ),
                  ],
                  /*
                    _onSearchTap
                    */
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      padding: EdgeInsets.all(0),
                      alignment: Alignment.centerRight,
                      icon: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: screenSize.width / 15.625,
                            height: screenSize.width / 15.625,
                            child: Image.asset(
                              'lib/Fonts/notification.png',
                              color: locationButtonColor,
                            ),
                          ),
                          /* Visibility(
                            visible: state.unseenNotifications,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: screenSize.width / 46.875,
                                height: screenSize.width / 46.875,
                                margin: EdgeInsets.all(screenSize.width / 65),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      onPressed: () {
                        /*setState(() {
                            index = 2;
                          });*/
                      },
                    ),
                    IconButton(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width / 15.625),
                      icon: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: screenSize.width / 15.625,
                            height: screenSize.width / 15.625,
                            child: Image.asset(
                              'lib/Fonts/message.png',
                              color: darkBlue,
                            ),
                          ),
                          /*Visibility(
                            visible: state.unreadMessages,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                width: screenSize.width / 46.875,
                                height: screenSize.width / 46.875,
                                margin: EdgeInsets.all(screenSize.width / 65),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),*/
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            ),
          ),*/

class NotificationTile extends StatelessWidget {
  final db.Notification notification;
  final String myId;

  const NotificationTile({Key key, this.notification, this.myId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('notification type = ${notification.type}');
    print('notification type = ${notification.createdAt}');
    print('notification type = ${notification.userId}');
    return GestureDetector(
      onTap: () {
        if (notification.type == "followee" ||
            notification.type == 'reveal' ||
            notification.type == 'date') {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtherUserProfile(
                otherId: notification.userId,
              ),
            ),
          );
        } else {
//          BlocProvider.of<UserBloc>(context).add(FetchOtherUser(
//            widget.myId,
//            state.notifications[counter].userId,
//          ));
//          _navigate(
//            context: context,
//            screen: OtherUserProfile(
//              myId: myId,
//              otherId: notification.userId,
//            ),
//          );
        }
      },
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider(notification.image),
              fit: BoxFit.cover,
            ),
          ),
          width: 70,
          height: 70,
          child: notification.type == 'secretFollowee'
              ? BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.8, sigmaY: 0.8),
                  child: Container(
                    color: Colors.black.withOpacity(0),
                  ),
                )
              : Container(),
        ),
        title: notification.type == 'followee' ||
                notification.type == 'secretlyFollowee'
            ? RichText(
                text: TextSpan(
                  text: notification.userName,
                  style: TextStyle(
                    color: Color(0xFF78849E),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(
                      text: ' has a ',
                      style: TextStyle(
                        color: Color(0xFF78849E),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    notification.type == 'followee'
                        ? TextSpan(
                            text: 'Crush ',
                            style: TextStyle(
                              color: Color(0xFF78849E),
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : TextSpan(
                            text: 'secret crush ',
                            style: TextStyle(
                              color: Color(0xFF78849E),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    TextSpan(
                      text: 'on you',
                      style: TextStyle(
                        color: Color(0xFF78849E),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              )
            : notification.type == 'reveal'
                ? RichText(
                    text: TextSpan(
                      text: notification.userName,
                      style: TextStyle(
                        color: Color(0xFF78849E),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      children: [
                        TextSpan(
                          text: ' revealed his identity. ',
                          style: TextStyle(
                            color: Color(0xFF78849E),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: 'See profile',
                          style: TextStyle(
                            color: Color(0xFF78849E),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                : notification.type == 'date'
                    ? RichText(
                        text: TextSpan(
                          text: 'You and ',
                          style: TextStyle(
                            color: Color(0xFF78849E),
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                          ),
                          children: [
                            TextSpan(
                              text: notification.userName,
                              style: TextStyle(
                                color: Color(0xFF78849E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: ' have a date!',
                              style: TextStyle(
                                color: Color(0xFF78849E),
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            TextSpan(
                              text: ' See profile.',
                              style: TextStyle(
                                color: Color(0xFF78849E),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
        subtitle: Text(
          timeago.format(notification.createdAt),
          style: TextStyle(
            color: Color.fromRGBO(149, 157, 173, 0.56),
          ),
        ),
      ),
    );
  }
}
