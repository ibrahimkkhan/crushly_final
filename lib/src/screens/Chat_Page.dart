import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import '../blocs/Messenger_Bloc/bloc.dart';
import '../blocs/User_Bloc/bloc.dart';
import '../common/constants.dart';
import 'OtherProfile.dart';
import '../models/Message.dart';
import '../theme/theme.dart';
// import '../utils/linear_gradient_mask.dart';
import '../utils/main_screen_delegate.dart';
import '../utils/our_toast.dart';
import '../utils/utils.dart';

// import 'package:emoji_picker/emoji_picker.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utils/extensions/capitalize.dart';
import 'package:oktoast/oktoast.dart';

class ChatPage extends StatefulWidget {
  ChatPage({
    Key? key,
    this.presentlySecret,
    this.originallySecret,
    this.otherID,
    this.otherName,
    this.otherImage,
    this.isFromFolloweePage,
    this.mainScreenDelegate,
  });

  final MainScreenDelegate? mainScreenDelegate;

  bool? originallySecret;
  String? otherName;
  String? otherImage;
  final String? otherID;
  final bool? isFromFolloweePage;
  bool? presentlySecret;

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with
        TickerProviderStateMixin,
        WidgetsBindingObserver,
        AutomaticKeepAliveClientMixin<ChatPage> {
  final TextEditingController _textController = new TextEditingController();
  late AppLifecycleState appLifecycleState;

  //to check if first messsage of chat is from other user
  late bool firstMessageFromMe;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState = state;
//    if (state == AppLifecycleState.resumed) {
//      BlocProvider.of<MassengerBloc>(context).add(RefreashChat());
//    }
    print(state);
  }

  int relation = Relations.UNKNOWN;
  String? otherName;
  late AnimationController scaleController;
  late AnimationController fadeController;
  late AnimationController emojiController;
  Animation? scaleAnimation;
  Animation? fadeAnimation;
  Animation? emojiAnimation;
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  List<String>? followListIds;
  bool islimit = false;
  bool isFollowingOtherSecretly = false;
  bool isBlocked = false;
  bool isLoading = false;
  Size? sizeAware;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<MassengerBloc>(context).cachMessages.first.authorName ==
            otherName
        ? firstMessageFromMe = false
        : firstMessageFromMe = true;
    print('widget. ${widget.presentlySecret}');
    if (widget.presentlySecret!) relation = Relations.SECRET_CRUSH;
    otherName = widget.otherName;
    BlocProvider.of<MassengerBloc>(context)
        .add(EnterConversation(widget.otherID!, widget.otherName!, this));
    BlocProvider.of<UserBloc>(context).add(AddLocalUser(widget.otherID!));
    BlocProvider.of<UserBloc>(context).add(GetIfUserBlocked(widget.otherID!));
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    //fading animation of chat widgets.
    fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1),
    );
    emojiController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    emojiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(curve: Curves.easeIn, parent: emojiController));
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(scaleController);
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(fadeController);
    scaleController.addListener(() {
      setState(() {});
    });
    fadeController.addListener(() {
      setState(() {});
    });
    scaleController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        fadeController.forward();
      }
    });
    scaleController.forward();
    WidgetsBinding.instance!.addObserver(this);
    focusNode.addListener(() {
      if (focusNode.hasFocus || !showEmoji) {
        setState(() {
          showEmoji = false;
        });
      }
    });

//    BlocProvider
//        .of<UserBloc>(context)
//        .followList
//        .forEach((f) {
//      if (f.id == widget.otherID) {
//        if (f.presentlySecret) {
//          isFollowingOtherSecretly = true;
//        }
//        return;
//      }
//    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    text = text.trim();
    if (text.isNotEmpty) {
      print('other user ID ${widget.otherID}');
      BlocProvider.of<MassengerBloc>(context).add(
        SendEvent(
          Message(text, DateTime.now().millisecondsSinceEpoch, true, "",
              widget.otherID!),
        ),
      );
    }
  }

  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    emojiController.dispose();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    sizeAware = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        if (showEmoji) {
          setState(() {
            showEmoji = false;

            emojiController.reset();
          });
          return Future.value(false);
        } else {
          BlocProvider.of<MassengerBloc>(context).currentOtherId = "";
          BlocProvider.of<MassengerBloc>(context).cachMessages.clear();
          BlocProvider.of<MassengerBloc>(context).inConversation = false;
          BlocProvider.of<MassengerBloc>(context).currentOtherId = "";
          if (widget.isFromFolloweePage!) {
            BlocProvider.of<UserBloc>(context).add(GetFollowee());
          }
//          return Future.value(true);

          widget.mainScreenDelegate!.iconClicked(MainScreenIcon.HOME);
          return Future.value(false);
        }
      },
      child: Container(
        color: Colors.grey[200],
        child: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80),
              child: _tabBar(),
            ),
//        appBar: AppBar(
//          leading: IconButton(
//            icon: LinearGradientMask(
//              child: Icon(
//                Icons.arrow_back_ios,
//                color: white,
//              ),
//            ),
//            onPressed: () {
//              BlocProvider.of<MassengerBloc>(context).currentOtherId = "";
//              BlocProvider.of<MassengerBloc>(context).cachMessages.clear();
//              BlocProvider.of<MassengerBloc>(context).inConversation = false;
//              BlocProvider.of<MassengerBloc>(context).currentOtherId = null;
//              if (widget.isFromFolloweePage) {
//                BlocProvider.of<UserBloc>(context).add(GetFollowee());
//              }
//              widget.mainScreenDelegate.iconClicked(MainScreenIcon.HOME);
//            },
//          ),
//          actions: <Widget>[
//            PopupMenuButton<String>(
//              itemBuilder: (context) {
//                return [
//                  PopupMenuItem<String>(
//                    value: 'Reveal identity',
//                    child: Text('Reveal identity'),
//                  )
//                ];
//              },
//            ),
//          ],
//          title: FlatButton(
//            onPressed: () async {
//              if (widget.presentlySecret != null) {
//                if (!widget.presentlySecret) {
//                  final user = await SharedPref.pref.getUser();
//
//                  BlocProvider.of<UserBloc>(context).add(FetchOtherUser(
//                    user.id,
//                    widget.otherID,
//                  ));
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          maintainState: false,
//                          builder: (context) => OtherUserProfile(
//                                myId: user.id,
//                                otherId: widget.otherID,
//                              )));
//                }
//              } else {
//                final user = await SharedPref.pref.getUser();
//
//                BlocProvider.of<UserBloc>(context).add(FetchOtherUser(
//                  user.id,
//                  widget.otherID,
//                ));
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                        maintainState: false,
//                        builder: (context) => OtherUserProfile(
//                              myId: user.id,
//                              otherId: widget.otherID,
//                            )));
//              }
//            },
//            // },
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  otherName,
//                  style: TextStyle(color: Colors.blueGrey, fontSize: 16),
//                ),
//                otherType.isNotEmpty
//                    ? Text(
//                        otherType,
//                        style: TextStyle(
//                          color: Colors.grey[900],
//                        ),
//                      )
//                    : Container(),
//              ],
//            ),
//          ),
//          centerTitle: true,
//        ),
            body: Stack(
              children: <Widget>[
                BlocListener<MassengerBloc, MassengerState>(
                  listenWhen: (prev, cur) {
                    return cur is NotConnected ||
                        cur is RevealCurrentChatUser ||
                        cur is BlockedUserEvent;
                  },
                  listener: (context, state) async {
                    if (state is BlockedUserEvent) {
                      setState(() {
                        isBlocked = true;
                      });
                    }
                    if (state is NotConnected) {
                      showToastWidget(
                          toast(
                              MediaQuery.of(context).size,
                              "lib/Fonts/retry.svg",
                              "Connection Problem, try again",
                              true, () {
                            BlocProvider.of<MassengerBloc>(context)
                                .add(Connect());
                            showToastWidget(Text(""), dismissOtherToast: true);
                          }),
                          handleTouch: true,
                          position: ToastPosition.top,
                          dismissOtherToast: false, onDismiss: () {
                        Connectivity().checkConnectivity().then((event) {
                          if (event != ConnectivityResult.none)
                            showToastWidget(
                                toast(MediaQuery.of(context).size, "",
                                    "Connected!", false, () {}),
                                handleTouch: false,
                                position: ToastPosition.top,
                                duration: Duration(seconds: 2),
                                dismissOtherToast: true);
                        });
                      }, duration: Duration(days: 1));
                    }
                    /*if (state is Connected) {
                      /* showToastWidget(
                          toast(MediaQuery.of(context).size, "", "Connected!",
                              false, () {}),
                          handleTouch: false,
                          position: ToastPosition.top,
                          duration: Duration(seconds: 2),
                          dismissOtherToast: true);*/
                    }*/
                    if (state is RevealCurrentChatUser) {
                      setState(() {
                        otherName = state.newName;
                        widget.presentlySecret = false;
                      });
                      showDialog(
                          barrierDismissible: true,
                          context: context,
                          builder: (context) => Center(
                              child: Container(
                                  width: sizeAware!.width / 1.2,
                                  height: sizeAware!.height / 3,
                                  child: Material(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            "this user has revealed his idetity to you."),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("ok"),
                                        )
                                      ],
                                    ),
                                  ))));
                    }
                  },
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: Opacity(
                            opacity: fadeAnimation!.value,
                            child: BlocBuilder<MassengerBloc, MassengerState>(
                              buildWhen: (prev, cur) {
                                if (cur is NotConnected ||
                                    cur is Connected ||
                                    cur is LoadingConnect ||
                                    cur is RevealCurrentChatUser) {
                                  return false;
                                } else {
                                  return true;
                                }
                              },
                              builder: (context, state) {
                                if (state is MessagesBox) {
                                  return ListView.builder(
                                      itemCount: state.messages.length,
                                      reverse: true,
                                      itemBuilder: (context, index) =>
                                          state.messages[index]);
                                }
                                if (state is LocalMessagesReady) {
                                  print('messages is ${state.relation}');
                                  if (state.relation != null)
                                    relation = state.relation;
                                  else if (widget!.presentlySecret!) {
                                    relation = Relations.SECRET_CRUSH;
                                  }
                                  return ListView.builder(
                                      itemCount: state.messages.length,
                                      reverse: true,
                                      itemBuilder: (context, index) =>
                                          state.messages[index]);
                                }
                                if (state is LoadingLocalMessages) {
                                  return Center(
                                    child: SpinKitThreeBounce(
                                      duration: Duration(milliseconds: 1000),
                                      color: Theme.of(context).primaryColor,
                                      size: 50.0,
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ),
                        ),
                        Relations.DATE == relation
                            ? Container()
                            : Relations.SECRET_CRUSH == relation
                                ? firstMessageFromMe
                                    ? Text(
                                        "You can send message after you receive a reply",
                                        style: TextStyle(color: grayish),
                                      )
                                    : Text(
                                        "$otherName can only send a message if you reply",
                                        style: TextStyle(color: grayish),
                                      )
                                : Relations.CRUSH == relation
                                    ? firstMessageFromMe
                                        ? Text(
                                            "You and $otherName will connect after you receive a reply",
                                            style: TextStyle(color: grayish),
                                          )
                                        : Text(
                                            "Reply to connect to your crush",
                                            style: TextStyle(color: grayish),
                                          )
                                    : Container(),
                        Container(
                          margin: EdgeInsets.all(sizeAware!.height / 80),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(sizeAware!.height / 16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(30),
                                blurRadius: 20,
                                offset: Offset(0, 8),
                              ),
                            ],
                            color: Colors.white,
                          ),
                          child: Slidable(
                            enabled: relation == Relations.SECRET_CRUSH &&
                                !isBlocked,
                            actionPane: SlidableStrechActionPane(),
                            actionExtentRatio: 1,
                            actions: <Widget>[
                              RevealIdentityButton(
                                otherId: widget.otherID!,
                              ),
                            ],
                            child: !isBlocked
                                ? Row(
                                    children: <Widget>[
                                      SizedBox(width: sizeAware!.width / 15),
                                      Expanded(
                                        child: TextField(
                                          maxLines: 7,
                                          minLines: 1,
                                          focusNode: focusNode,
                                          controller: _textController,
                                          // onSubmitted: _handleSubmitted,
                                          decoration: InputDecoration(
                                              hintText: "Type message",
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                color: grey,
                                              )),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      BlocBuilder<MassengerBloc,
                                          MassengerState>(
                                        buildWhen: (prev, cur) {
                                          if (cur is RevealCurrentChatUser) {
                                            return false;
                                          } else {
                                            return true;
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is NotConnected ||
                                              state is LoadingConnect) {
                                            return IconButton(
                                              icon: SvgPicture.asset(
                                                'assets/icons/message_button.svg',
                                                color: Colors.grey,
                                              ),
                                              onPressed: null,
                                            );
                                          }
                                          if (state is LocalMessagesReady) {
                                            if (state.messages.isNotEmpty) {
                                              if (state.messages.first
                                                          .authorName !=
                                                      widget.otherName &&
                                                  relation ==
                                                      Relations.SECRET_CRUSH) {
                                                islimit = true;
                                              } else {
                                                islimit = false;
                                              }
                                            } else {
                                              islimit = false;
                                            }

                                            return IconButton(
                                              icon: SvgPicture.asset(
                                                'assets/icons/message_button.svg',
                                                color: !_isSecretCrush(
                                                        state.messages)
                                                    ? Color(0xFFFA709A)
                                                    : Colors.grey,
                                              ),
                                              onPressed:
                                                  _isSecretCrush(state.messages)
                                                      ? null
                                                      : () => _handleSubmitted(
                                                          _textController.text),
                                            );
                                          }
                                          if (state is MessagesBox) {
                                            if (state.messages.isNotEmpty) {
                                              if (state.messages.first
                                                          .authorName !=
                                                      widget.otherName &&
                                                  isFollowingOtherSecretly) {
                                                islimit = true;
                                              } else
                                                islimit = false;
                                            } else {
                                              islimit = false;
                                            }
                                            print(
                                                'message box ${_isSecretCrush(state.messages)}');
                                            return IconButton(
                                              icon: SvgPicture.asset(
                                                'assets/icons/message_button.svg',
                                                color: _isSecretCrush(
                                                        state.messages)
                                                    ? Colors.grey
                                                    : Color(0xFFFA709A),
                                              ),
                                              onPressed:
                                                  _isSecretCrush(state.messages)
                                                      ? null
                                                      : () => _handleSubmitted(
                                                          _textController.text),
                                            );
                                          }
                                          return IconButton(
                                              icon: SvgPicture.asset(
                                                'assets/icons/message_button.svg',
                                                color: Colors.grey,
                                              ),
                                              onPressed: null);
                                        },
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Center(
                                          child: Text(
                                            "You can't communicate with ${widget.otherName}",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                        BlocListener(
                          listener: (context, UserState state) {
                            if (state is BlockError) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Error while blocking ${widget.otherName}');
                            } else if (state is UnBlockError) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Error while unblocking ${widget.otherName}');
                            } else if (state is RevealIdentitySuccess) {
                              setState(() {
                                relation = Relations.CRUSH;
                                widget.presentlySecret = false;
                              });
                            } else if (state is RevealIdentityError) {
                              Fluttertoast.showToast(
                                  msg:
                                      'Error while revealing your name to ${widget.otherName}');
                            } else if (state is BlockSuccess) {
                              setState(() {
                                isBlocked = true;
                              });
                            } else if (state is UnBlockSuccess) {
                              setState(() {
                                isBlocked = false;
                              });
                            }
                            return;
                          },
                          child: Container(),
                          bloc: BlocProvider.of<UserBloc>(context),
                        ),
                        showEmoji
                            ? SizeTransition(
                                sizeFactor: emojiAnimation as Animation<double>,
                                child: EmojiPicker(
                                  config: const Config(
                                    columns: 5,
                                    buttonMode: ButtonMode.MATERIAL,
                                  ),
                                  onEmojiSelected: (category, emoji) {
                                    _textController.text += emoji.emoji;
                                  },
                                ))
                            : Container(),
                      ],
                    ),
                  ),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _isSecretCrush(List<MessageWidget> messages) {
    return relation == Relations.SECRET_CRUSH &&
        messages.isNotEmpty &&
        messages.first.authorName!.trim().toLowerCase() !=
            otherName!.trim().toLowerCase();
  }

  _tabBar() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: pink,
                  ),
                  onPressed: () {
                    BlocProvider.of<MassengerBloc>(context).currentOtherId = "";
                    BlocProvider.of<MassengerBloc>(context)
                        .cachMessages
                        .clear();
                    BlocProvider.of<MassengerBloc>(context).inConversation =
                        false;
                    BlocProvider.of<MassengerBloc>(context).currentOtherId =
                        "";
                    if (widget!.isFromFolloweePage!) {
                      BlocProvider.of<UserBloc>(context).add(GetFollowee());
                    }
                    if (widget.mainScreenDelegate != null)
                      widget.mainScreenDelegate!
                          .iconClicked(MainScreenIcon.HOME);
                    else
                      Navigator.of(context).pop();
                  },
                ),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                      color: grey,
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(widget.otherImage ?? ''),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(24.0))),
                ),
                FlatButton(
                  onPressed: () async {
                    if (widget.presentlySecret != null) {
                      if (!widget.presentlySecret!) {
//                    BlocProvider.of<UserBloc>(context).add(FetchOtherUser(
//                      widget.otherID,
//                    ));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            maintainState: false,
                            builder: (context) => OtherUserProfile(
                              otherId: widget.otherID!,
                              isFromChatPage: true,
                            ),
                          ),
                        );
                      }
                    } else {
//                  BlocProvider.of<UserBloc>(context).add(FetchOtherUser(
//                    widget.otherID,
//                  ));
//                  Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          maintainState: false,
//                          builder: (context) => OtherUserProfile(
//                                otherId: widget.otherID,
//                              )));
                    }
                  },
                  // },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        otherName!.capitalize() ?? '',
                        style: TextStyle(
                          color: darkBlue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      relation == Relations.SECRET_CRUSH
                          ? Text(
                              'Secret Crush',
                              style: TextStyle(
                                color: darkBlue,
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            !isBlocked
                ? relation == Relations.SECRET_CRUSH
                    ? IconButton(
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
                                                    bottom:
                                                        sizeAware!.height / 60),
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
                                                        left: sizeAware!.width /
                                                            20,
                                                        right: sizeAware!.width /
                                                            20,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Are you sure you want to block ${otherName!.split(' ').first}?',
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
                                                            height: sizeAware!
                                                                    .height /
                                                                50,
                                                          ),
                                                          Text(
                                                            "You will not be able to send or receive any messages from this person.",
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
                                                              'Block',
                                                              textScaleFactor:
                                                                  1.2,
                                                              style: TextStyle(
                                                                color: red,
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
                                                                            .add(BlockUserEvent(widget.otherID!));
                                                                      }
                                                                    : null,
                                                          )
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
                                            //               Navigator.of(context)
                                            //                   .pop();
                                            //               setState(() {
                                            //                 isLoading = true;
                                            //               });
                                            //               BlocProvider.of<UserBloc>(
                                            //                       context)
                                            //                   .add(BlockUserEvent(
                                            //                       widget.otherID));
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
                                    Container(
                                      width: double.maxFinite,
                                      height: 1,
                                      color: Colors.black.withOpacity(0.2),
                                    ),
                                    _createTile(
                                      context,
                                      'Reveal Identity',
                                      () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoAlertDialog(
                                              content: Text(
                                                'Are you sure you want to reveal your identity to ${otherName!.split(' ').first}',
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
                                                          Navigator.of(context)
                                                              .pop();
                                                          setState(() {
                                                            isLoading = true;
                                                          });
                                                          BlocProvider.of<
                                                                      UserBloc>(
                                                                  context)
                                                              .add(RevealIdentity(
                                                                  widget
                                                                      .otherID!));
                                                        }
                                                      : null,
                                                  child: Text('Reveal'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    : IconButton(
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
                                                    bottom:
                                                        sizeAware!.height / 60),
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
                                                        left: sizeAware!.width /
                                                            20,
                                                        right: sizeAware!.width /
                                                            20,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            'Are you sure you want to block ${otherName!.split(' ').first}?',
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
                                                            height: sizeAware!
                                                                    .height /
                                                                50,
                                                          ),
                                                          Text(
                                                            "You will not be able to send or receive any messages from this person.",
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
                                                              'Block',
                                                              textScaleFactor:
                                                                  1.2,
                                                              style: TextStyle(
                                                                color: red,
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
                                                                            .add(BlockUserEvent(widget.otherID!));
                                                                      }
                                                                    : null,
                                                          )
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
                                            //               Navigator.of(context)
                                            //                   .pop();
                                            //               setState(() {
                                            //                 isLoading = true;
                                            //               });
                                            //               BlocProvider.of<UserBloc>(
                                            //                       context)
                                            //                   .add(BlockUserEvent(
                                            //                       widget.otherID));
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
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                : Container(),
          ],
        ),
      ),
    );
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

  _showUnBlockDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text('Do you want to unblock ${capitalizeNames(otherName!)}'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Ignore'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Unblock'),
              isDefaultAction: true,
              onPressed: () {
                BlocProvider.of<UserBloc>(context)
                    .add(UnBlockUserEvent(widget.otherID!));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _showBlockDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text('Do you want to block ${capitalizeNames(otherName!)}'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Ignore'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Block'),
              isDefaultAction: true,
              onPressed: () {
                BlocProvider.of<UserBloc>(context)
                    .add(BlockUserEvent(widget.otherID!));
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _getBlockOrUnblockUser() {
    return PopupMenuItem<String>(
      value: isBlocked ? 'Unblock' : 'Block',
      child: Text(isBlocked ? 'Unblock' : 'Block'),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {this.animationController,
      this.isRecieved,
      this.authorName,
      this.text,
      this.time});

  final bool? isRecieved;
  final String? text;
  final AnimationController? animationController;
  final String? authorName;
  final String? time;

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return animationController != null
        ? isRecieved!
            ? recievedMessage(sizeAware)
            : sentMessage(sizeAware)
        : isRecieved!
            ? recievedMessage(sizeAware)
            : sentMessage(sizeAware);
  }

  Widget recievedMessage(Size sizeAware) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ]),
            margin: EdgeInsets.only(
                top: 8,
                left: sizeAware.width * 0.07,
                right: sizeAware.width * 0.3),
            // width: sizeAware.width / 1.5,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                    child: Text(text!,
                        style: TextStyle(color: Colors.black, fontSize: 14))),
                SizedBox(
                  width: 8,
                ),
// TODO: time of the msg
//                Column(
//                  mainAxisSize: MainAxisSize.min,
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    Text(time,
//                        style: TextStyle(color: Colors.black, fontSize: 10)),
//                  ],
//                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sentMessage(Size sizeAware) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFF2D9CDB),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(250, 112, 154, 0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4))
                ]),
            margin: EdgeInsets.only(
                top: 8,
                left: sizeAware.width * 0.3,
                right: sizeAware.width * 0.07),
            // width: sizeAware.width / 1.5,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                    child: Text(
                  text!,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                )),
//                SizedBox(
//                  width: 8,
//                ),
//                Column(
//                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    Text(time,
//                        style: TextStyle(color: Colors.white, fontSize: 10)),
//                  ],
//                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class RevealIdentityButton extends StatelessWidget {
  final String? myId;
  final String otherId;

  const RevealIdentityButton({Key? key,this.myId,required this.otherId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        BlocProvider.of<UserBloc>(context).add(RevealIdentity(otherId));
//        final currentUserId = myId ?? (await SharedPref.pref.getUser()).id;
//        await Api.apiClient.reveal(otherId).then((onValue) {
//          if (!onValue) {
//            Scaffold.of(context).showSnackBar(SnackBar(
//              content: Text("error"),
//              backgroundColor: Colors.red,
//            ));
//          } else {
//            Scaffold.of(context).showSnackBar(SnackBar(
//              content: Text("reveal Success"),
//              backgroundColor: Colors.green,
//            ));
//          }
//          BlocProvider.of<UserBloc>(context)
//              .add(UpdateOtherProfile(currentUserId, otherId));
//        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: appGradient,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(15),
                blurRadius: 20,
                offset: Offset(0, 8))
          ],
        ),
        child: Center(
          child: Text(
            'Reveal identity',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
