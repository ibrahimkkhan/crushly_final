import '../resources/Api.dart';
import '../blocs/Messenger_Bloc/bloc.dart';
import '../blocs/User_Bloc/bloc.dart';
import '../Common/constants.dart';
import '../Screens/Chat_Page.dart';
import '../screens/FullScreenImage.dart';
import '../screens/LandingPage.dart';
import '../models/NickName.dart';
import '../models/recommendation.dart';
import '../theme/theme.dart';
import '../utils/CustomDotsIndicator.dart';
import '../utils/animated_count.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OtherUserProfile extends StatefulWidget {
  final String otherId;
  final int index;
  final bool isFromChatPage;

  OtherUserProfile({
    Key key,
    @required this.otherId,
    @required this.index,
    this.isFromChatPage = false,
  }) : super(key: key);

  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _imagesPageController = PageController();
  String otherName;
  bool isCrush;
  bool isLoadingMain = false;
  bool isLoadingSecondary = false;
  bool isLoading = false;
  bool isSecretCrush;
  int currentIndex = 0;
  int relation = Relations.UNKNOWN;
  Size size;

  @override
  void initState() {
    _imagesPageController.addListener(() {
      setState(() {});
    });
    BlocProvider.of<UserBloc>(context).add(FetchOtherUser(widget.otherId));
    super.initState();
  }

  void onSelectChoice(String choice) async {
    switch (choice) {
      case CHOICE_REPORT:
        return;
      case CHOICE_BLOCK:
        showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(
                'Are you sure you want to block ${otherName.split(' ').first}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              content: Text(
                "You will not be able to send or receive any messages from this person",
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  onPressed: !isLoading
                      ? () async {
                          Navigator.of(context).pop();
                          setState(() {
                            isLoading = true;
                          });
                          BlocProvider.of<UserBloc>(context)
                              .add(BlockUserEvent(widget.otherId));
                        }
                      : null,
                  child: Text('Block'),
                ),
              ],
            );
          },
        );
        return;
      case CHOICE_UNBLOCK:
        return;
      case CHOICE_REVEAL:
        showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: Text(
                'Are you sure you want to reveal your identity to ${otherName.split(' ').first}',
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                CupertinoDialogAction(
                  onPressed: !isLoading
                      ? () async {
                          Navigator.of(context).pop();
                          setState(() {
                            isLoading = true;
                          });
                          BlocProvider.of<UserBloc>(context)
                              .add(RevealIdentity(widget.otherId));
                        }
                      : null,
                  child: Text('Reveal'),
                ),
              ],
            );
          },
        );
        return;
    }
  }

  ListTile _createTile(BuildContext context, String name, Function action) {
    return ListTile(
      title: Text(name),
      onTap: () {
        Navigator.pop(context);
        action();
      },
    );
  }

  Widget _scaffoldView({@required Widget body, String title}) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: pink,
            ),
            onPressed: () => Navigator.pop(context)),
        elevation: 0,
        centerTitle: true,
        title: Text(
          title ?? ' ',
          style: TextStyle(
            color: darkBlue,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          BlocBuilder<UserBloc, UserState>(
            condition: (prev, cur) => cur is FetchOtherSuccess,
            builder: (context, state) {
              if (state is FetchOtherSuccess) {
                final choices = <String>[];
                choices.add(CHOICE_BLOCK);
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) {
                    if (relation == Relations.UNKNOWN)
                      setState(() {
                        relation = state.data.relation;
                      });
                  },
                );
                if (relation == Relations.SECRET_CRUSH)
                  choices.add(CHOICE_REVEAL);
                return IconButton(
                  icon: Icon(Icons.more_horiz),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              _createTile(
                                context,
                                'Block',
                                () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: size.height / 60),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    icon: Icon(Icons.close),
                                                    color: gray,
                                                    onPressed: () =>
                                                        Navigator.pop(context),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: size.width / 20,
                                                  right: size.width / 20,
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'Are you sure you want to block ${otherName.split(' ').first}?',
                                                      textAlign:
                                                          TextAlign.center,
                                                      textScaleFactor: 1.25,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: size.height / 50,
                                                    ),
                                                    Text(
                                                      "You will not be able to send or receive any messages from this person.",
                                                      textScaleFactor: 0.85,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    FlatButton(
                                                      splashColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      child: Text(
                                                        'Block',
                                                        textScaleFactor: 1.2,
                                                        style: TextStyle(
                                                          color: red,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      onPressed: !isLoading
                                                          ? () async {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              setState(() {
                                                                isLoading =
                                                                    true;
                                                              });
                                                              BlocProvider.of<
                                                                          UserBloc>(
                                                                      context)
                                                                  .add(BlockUserEvent(
                                                                      widget
                                                                          .otherId));
                                                            }
                                                          : null,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                      // return CupertinoAlertDialog(
                                      //   title: Text(
                                      //     'Are you sure you want to block ${otherName.split(' ').first}',
                                      //     style: TextStyle(
                                      //         fontWeight: FontWeight.bold),
                                      //   ),
                                      //   content: Text(
                                      //     "You will not be able to send or receive any messages from this person",
                                      //   ),
                                      //   actions: <Widget>[
                                      //     CupertinoDialogAction(
                                      //       child: Text('Cancel'),
                                      //       onPressed: () {
                                      //         Navigator.of(context).pop();
                                      //       },
                                      //     ),
                                      //     CupertinoDialogAction(
                                      //       onPressed: !isLoading
                                      //           ? () async {
                                      //               Navigator.of(context).pop();
                                      //               setState(() {
                                      //                 isLoading = true;
                                      //               });
                                      //               BlocProvider.of<UserBloc>(
                                      //                       context)
                                      //                   .add(BlockUserEvent(
                                      //                       widget.otherId));
                                      //             }
                                      //           : null,
                                      //       child: Text('Block'),
                                      //     ),
                                      //   ],
                                      // );
                                    },
                                  );
                                },
                              ),
                              choices.length > 1
                                  ? Container(
                                      width: double.maxFinite,
                                      height: 1,
                                      color: Colors.black.withOpacity(0.2),
                                    )
                                  : Container(),
                              choices.length > 1
                                  ? _createTile(
                                      context,
                                      'Reveal Identity',
                                      () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    bottom: size.height / 60),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        IconButton(
                                                          splashColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          icon:
                                                              Icon(Icons.close),
                                                          color: gray,
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                        left: size.width / 20,
                                                        right: size.width / 20,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Are you sure you want to Reveal your identity?',
                                                            textAlign: TextAlign
                                                                .center,
                                                            textScaleFactor:
                                                                1.25,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height:
                                                                size.height /
                                                                    50,
                                                          ),
                                                          Text(
                                                            "Revealing your identity will reveal all your profile information.",
                                                            textScaleFactor:
                                                                0.85,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          FlatButton(
                                                            splashColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            child: Text(
                                                              'Reveal Identity',
                                                              textScaleFactor:
                                                                  1.2,
                                                              style: TextStyle(
                                                                color:
                                                                    curiousBlue,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                            onPressed:
                                                                !isLoading
                                                                    ? () async {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        setState(
                                                                            () {
                                                                          isLoading =
                                                                              true;
                                                                        });
                                                                        BlocProvider.of<UserBloc>(context)
                                                                            .add(RevealIdentity(widget.otherId));
                                                                      }
                                                                    : null,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                            // return CupertinoAlertDialog(
                                            //   content: Text(
                                            //     'Are you sure you want to reveal your identity to ${otherName.split(' ').first}',
                                            //   ),
                                            //   actions: <Widget>[
                                            //     CupertinoDialogAction(
                                            //       child: Text('Cancel'),
                                            //       onPressed: () {
                                            //         Navigator.of(context).pop();
                                            //       },
                                            //     ),
                                            //     CupertinoDialogAction(
                                            //       onPressed: !isLoading
                                            //           ? () async {
                                            //               Navigator.of(context)
                                            //                   .pop();
                                            //               setState(() {
                                            //                 isLoading = true;
                                            //               });
                                            //               BlocProvider.of<
                                            //                           UserBloc>(
                                            //                       context)
                                            //                   .add(RevealIdentity(
                                            //                       widget
                                            //                           .otherId));
                                            //             }
                                            //           : null,
                                            //       child: Text('Reveal'),
                                            //     ),
                                            //   ],
                                            // );
                                          },
                                        );
                                      },
                                    )
                                  : Container(),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              } else
                return Container();
            },
          ),
        ],
      ),
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return BlocListener<MassengerBloc, MassengerState>(
      listener: (context, state) {},
      child: BlocListener<UserBloc, UserState>(
        condition: (prev, cur) =>
            cur is ErrorInFollowing ||
            cur is FollowedSuccessfully ||
            cur is RevealIdentitySuccess ||
            cur is RevealIdentityError ||
            cur is BlockSuccess ||
            cur is BlockError,
        listener: (context, state) async {
          if (state is ErrorInFollowing) {
            setState(() {
              isLoadingMain = false;
              isLoadingSecondary = false;
            });
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              content: Text("Something went wrong when following , try again..",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.red,
            ));
          }

          if (state is BlockError) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: 'Error while blocking the user');
          } else if (state is UnBlockError) {
            setState(() {
              isLoading = false;
            });
            Fluttertoast.showToast(msg: 'Error while unblocking');
          } else if (state is RevealIdentitySuccess) {
            setState(() {
              relation = Relations.CRUSH;
              isLoading = false;
              isLoadingMain = false;
              isLoadingSecondary = false;
            });
          } else if (state is RevealIdentityError) {
            Fluttertoast.showToast(msg: 'Error while revealing your name');
          } else if (state is BlockSuccess) {
            setState(() {
              isLoading = false;
            });
            await showDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Text('Blocked Success'),
                  content: Text('The user has been blocked successfully'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Close'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
            Navigator.of(context).pop(
              {'index': widget.index},
            );
          }
          if (state is FollowedSuccessfully) {
            setState(() {
              isLoadingMain = false;
              isLoadingSecondary = false;
              if (state.isSecret) {
                isSecretCrush = true;
                relation = Relations.SECRET_CRUSH;
              } else {
                isCrush = true;
                relation = Relations.CRUSH;
              }
            });

            if (state.followResponse.isDate ?? false) {
              setState(() {
                relation = Relations.DATE;
              });
              // showCupertinoDialog(
              //   context: context,
              //   builder: (context) {
              //     return CupertinoAlertDialog(
              //       title: Text("Congratulations"),
              //       content: Text("You have a match"),
              //       actions: <Widget>[
              //         FlatButton(
              //           child: Text("OK"),
              //           onPressed: () {
              //             Navigator.pop(context);
              //           },
              //         )
              //       ],
              //     );
              //   },
              // );
            }
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          condition: (pre, cur) {
            if (cur is LoadingFetchOther ||
                cur is FetchOtherSuccess ||
                cur is FetchOtherFailed)
              return true;
            else
              return false;
          },
          builder: (context, state) {
            var screenSize = MediaQuery.of(context).size;
            Size size = MediaQuery.of(context).size;
            if (state is LoadingFetchOther) {
              return _scaffoldView(
                body: Center(
                  child: SpinKitThreeBounce(
                    duration: Duration(milliseconds: 1000),
                    color: Theme.of(context).primaryColor,
                    size: 50.0,
                  ),
                ),
              );
            }
            if (state is FetchOtherFailed) {
              return _scaffoldView(
                body: Center(
                  child: Text(state.error),
                ),
              );
            }
            if (state is FetchOtherSuccess) {
              isCrush = state.data.followed;
              otherName = state.data.person.name;
              isSecretCrush = isSecretCrush ??
                  isCrush && state.data.presentlySecret ??
                  true;
              return _scaffoldView(
                title: state.data.person.name,
                body: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              state.data.person.profilePhoto,
                            ),
                            radius: size.width / 11,
                          ),
                        ),
                        SizedBox(
                          height: screenSize.height / 80,
                        ),
                        state.data.person.schoolName == null
                            ? Text(
                                state.data.person.schoolName ??
                                    "Harvard University",
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                    color: lightBlue,
                                    fontSize: size.height / 65),
                              )
                            : Container(),
                        state.data.person.greekHouse != null
                            ? Text(
                                state.data.person.greekHouse,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: lightBlue,
                                  fontSize: size.height / 65,
                                ),
                              )
                            : Container(),
                        SizedBox(height: 30),
                        AnimatedCount(
                          count: state.data.person.followCount,
                          duration: Duration(milliseconds: 900),
                        ),
                        Text(
                          'Crush Count'.toUpperCase(),
                          style: TextStyle(
                              color: gray, fontSize: size.height / 70),
                        ),
                        SizedBox(height: 40),
                        _getActionButtons(relation, state.data.person.name,
                            state.data.person, size),
                        SizedBox(height: 50),
                        // Expanded(
                        //   flex: 1,
                        //   child: Container(
                        //     margin: EdgeInsets.only(top: size.height * 0.03),
                        //     width: double.maxFinite,
                        //     // height: size.height / 1.6,
                        //     decoration: BoxDecoration(
                        //       color: Colors.transparent,
                        //       borderRadius: BorderRadius.only(
                        //         topLeft: Radius.circular(size.height * 0.03),
                        //         topRight: Radius.circular(size.height * 0.03),
                        //       ),
                        //     ),
                        //     child: Stack(
                        //       children: <Widget>[
                        //         Container(
                        //           decoration: BoxDecoration(
                        //             image: DecorationImage(
                        //               fit: BoxFit.cover,
                        //               image: AssetImage(
                        //                   'assets/placeholder/landing_image.png'),
                        //             ),
                        //             borderRadius: BorderRadius.only(
                        //               topLeft:
                        //                   Radius.circular(size.height * 0.03),
                        //               topRight:
                        //                   Radius.circular(size.height * 0.03),
                        //             ),
                        //           ),
                        //         ),
                        //         Padding(
                        //           padding:
                        //               EdgeInsets.only(bottom: size.height / 40),
                        //           child: Align(
                        //             alignment: Alignment.bottomCenter,
                        //             child: DotsIndicator(
                        //               dotsCount: 3,
                        //               position: 0,
                        //               decorator: DotsDecorator(
                        //                 color: inactiveDot,
                        //                 activeColor: pink,
                        //                 spacing:
                        //                     EdgeInsets.all(size.width / 90),
                        //                 size: Size.square(size.height / 100),
                        //                 activeSize: Size(size.height / 50,
                        //                     size.height / 100),
                        //                 activeShape: RoundedRectangleBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(15.0),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        //<< PLACEHOLDER

                        state.data.person.photos.isNotEmpty
                            ? Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                width: double.infinity,
                                // height: 150,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    size.height * 0.03,
                                  ),
                                ),
                                child: Wrap(
                                  children:
                                      state.data.person.photos.map((photo) {
                                    return InkWell(
                                      onTap: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return FullScreenImage(
                                              photoUrl: photo);
                                        }));
                                      },
                                      child: Hero(
                                        tag: photo,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              5.0, 5.0, 5.0, 10.0),
                                          height: 130,
                                          width: size.width / 4,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                photo,
                                              ),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                size.height * 0.03),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(),
                  ],
                ),
              );
            }
            return _scaffoldView(
              body: Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _getActionButtons(
      int relation, String name, Recommendation user, Size size) {
    switch (relation) {
      case Relations.UNKNOWN:
        return Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CrushButton(
                text: 'Crush',
                primary: true,
                isLoading: isLoadingMain,
                onPressed: !isLoadingMain
                    ? () {
                        setState(() {
                          isLoadingMain = true;
                        });
                        BlocProvider.of<UserBloc>(context).add(
                          Follow(
                            false,
                            widget.otherId,
                            otherName,
                          ),
                        );
                      }
                    : null,
              ),
              SizedBox(width: size.width / 20),
              CrushButton(
                text: 'Secret Crush',
                primary: false,
                isLoading: isLoadingSecondary,
                onPressed: !isLoadingSecondary
                    ? () {
                        setState(() {
                          isLoadingSecondary = true;
                        });
                        BlocProvider.of<UserBloc>(context).add(
                          Follow(
                            true,
                            widget.otherId,
                            otherName,
                          ),
                        );
                      }
                    : null,
              ),
            ],
          ),
        );
      case Relations.CRUSH:
        return Container(
          width: double.maxFinite,
          child: Column(
            children: <Widget>[
              // Text(
              //   'You have a Crush on $name',
              //   style: TextStyle(color: textColor, fontSize: size.width / 28),
              // ),
              // SizedBox(
              //   height: size.height / 40.6,
              // ),
              Container(
                height: size.width / 9,
                width: size.width / 2.5,
                child: PreviewButton(
                  text: 'Message',
                  onPressed: () {
                    if (!widget.isFromChatPage)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatPage(
                            presentlySecret: relation == Relations.SECRET_CRUSH,
                            originallySecret: user.orignallySecret,
                            otherID: user.id,
                            otherName: user.name,
                            isFromFolloweePage: false,
                            otherImage: user.profilePhoto,
                          ),
                        ),
                      );
                    else
                      Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );

      case Relations.SECRET_CRUSH:
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            children: <Widget>[
              // Text(
              //   'You have a Secret Crush on $name',
              //   style: TextStyle(color: textColor),
              // ),
              SizedBox(
                height: size.height / 40.6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    height: size.height / 16,
                    width: size.width / 2.5,
                    child: PreviewButton(
                      isDate: true,
                      text: 'Message',
                      onPressed: () {
                        if (!widget.isFromChatPage)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatPage(
                                presentlySecret:
                                    relation == Relations.SECRET_CRUSH,
                                originallySecret: user.orignallySecret,
                                otherID: user.id,
                                otherName: user.name,
                                isFromFolloweePage: false,
                                otherImage: user.profilePhoto,
                              ),
                            ),
                          );
                        else
                          Navigator.of(context).pop();
                      },
                    ),
                  ),
                  CrushButton(
                    text: 'Reveal Identity',
                    primary: false,
                    isLoading: isLoadingSecondary,
                    onPressed: !isLoadingSecondary
                        ? () {
                            setState(() {
                              isLoading = true;
                            });
                            BlocProvider.of<UserBloc>(context).add(
                              RevealIdentity(
                                widget.otherId,
                              ),
                            );
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        );
      case Relations.DATE:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.maxFinite,
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: 'You and $name are ',
                  style: TextStyle(color: textColor),
                  children: [
                    TextSpan(
                      text: 'Dating!',
                      style: TextStyle(
                          color: dateText, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 40.6,
              ),
              Container(
                height: size.height / 18.3,
                width: size.width / 2.5,
                child: PreviewButton(
                  isDate: true,
                  text: 'Message',
                  onPressed: () {
                    if (!widget.isFromChatPage)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatPage(
                            presentlySecret: relation == Relations.SECRET_CRUSH,
                            originallySecret: user.orignallySecret,
                            otherID: user.id,
                            otherName: user.name,
                            isFromFolloweePage: false,
                            otherImage: user.profilePhoto,
                          ),
                        ),
                      );
                    else
                      Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      case Relations.CRUSHEE:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: double.maxFinite,
          child: Column(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  text: '$name has a ',
                  style: TextStyle(color: textColor),
                  children: [
                    TextSpan(
                      text: 'Crush on you',
                      style: TextStyle(
                        color: crusheeText,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 40.6,
              ),
              PreviewButton(
                isCrushee: true,
                text: 'Crush to Date',
                isLoading: isLoadingMain,
                onPressed: !isLoadingMain
                    ? () {
                        setState(() {
                          isLoadingMain = true;
                        });
                        BlocProvider.of<UserBloc>(context).add(
                          Follow(
                            false,
                            user.id,
                            name,
                          ),
                        );
//                                      Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (_) => ChatPage(
//                                            presentlySecret: state
//                                                .data.person.presentlySecret,
//                                            originallySecret: state
//                                                .data.person.orignallySecret,
//                                            otherID:
//                                                state.data.person.id.toString(),
//                                            otherName:
//                                                state.data.person.firstName,
//                                            isFromFolloweePage: false,
//                                          ),
//                                        ),
//                                      );
                      }
                    : null,
              ),
            ],
          ),
        );
    }

//    isCrush
//        ? isSecretCrush
//            ? Container(
//                padding: EdgeInsets.symmetric(horizontal: 20),
//                width: double.maxFinite,
//                child: PreviewButton(
//                  text: 'Secret Message',
//                  onPressed: () {
////                                      Navigator.push(
////                                        context,
////                                        MaterialPageRoute(
////                                          builder: (_) => ChatPage(
////                                            presentlySecret: true,
////                                            originallySecret: true,
////                                            otherID:
////                                                state.data.person.id.toString(),
////                                            otherName:
////                                                state.data.person.firstName,
////                                            isFromFolloweePage: false,
////                                          ),
////                                        ),
////                                      );
//                  },
//                ),
//              )
//            : Container(
//                padding: EdgeInsets.symmetric(horizontal: 20),
//                width: double.maxFinite,
//                child: PreviewButton(
//                  text: 'Message',
//                  onPressed: () {
////                                      Navigator.push(
////                                        context,
////                                        MaterialPageRoute(
////                                          builder: (_) => ChatPage(
////                                            presentlySecret: state
////                                                .data.person.presentlySecret,
////                                            originallySecret: state
////                                                .data.person.orignallySecret,
////                                            otherID:
////                                                state.data.person.id.toString(),
////                                            otherName:
////                                                state.data.person.firstName,
////                                            isFromFolloweePage: false,
////                                          ),
////                                        ),
////                                      );
//                  },
//                ),
//              )
//        : Container(
//            margin: EdgeInsets.symmetric(horizontal: 4.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                CrushButton(
//                  text: 'Crush',
//                  primary: true,
//                  onPressed: () {
//                    BlocProvider.of<UserBloc>(context).add(
//                      Follow(
//                        false,
//                        widget.otherId,
//                        otherName,
//                      ),
//                    );
//                  },
//                ),
//                CrushButton(
//                  text: 'Secret Crush',
//                  primary: false,
//                  onPressed: () {
//                    BlocProvider.of<UserBloc>(context).add(
//                      Follow(
//                        true,
//                        widget.otherId,
//                        otherName,
//                      ),
//                    );
//                  },
//                ),
//              ],
//            ),
//          );
  }
}

class NickNamePicker extends StatefulWidget {
  NickNamePicker({Key key}) : super(key: key);

  @override
  _NickNamePickerState createState() => _NickNamePickerState();
}

class _NickNamePickerState extends State<NickNamePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 300,
      child: Column(
        children: <Widget>[
          Text("select a nick name",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple)),
          Expanded(
            child: FutureBuilder<List<NickName>>(
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CupertinoPicker.builder(
                    backgroundColor: null,
                    onSelectedItemChanged: (index) {},
                    childCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Text(
                        snapshot.data[index].name +
                            " " +
                            snapshot.data[index].surname,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.deepPurple),
                      );
                    },
                    itemExtent: 45,
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
              future: Api.apiClient.getNickNames(25),
            ),
          )
        ],
      ),
    );
  }
}

const CHOICE_BLOCK = 'Block';
const CHOICE_UNBLOCK = 'Unblock';
const CHOICE_REPORT = 'Report';
const CHOICE_REVEAL = 'Reveal identity';
