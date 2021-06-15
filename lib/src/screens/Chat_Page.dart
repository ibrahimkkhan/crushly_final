import '../blocs/User_Bloc/bloc.dart';
import '../Screens/OtherProfile.dart';
import '../SharedPref/SharedPref.dart';

import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../blocs/Messenger_Bloc/bloc.dart';
import '../models/Message.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this.isOtherUnKnown,
      {this.otherID, this.otherName, this.h, this.w, this.isFromFolloweePage});
  final double w;
  final double h;
  String otherName;
  final String otherID;
  final bool isFromFolloweePage;
  bool isOtherUnKnown;

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  final TextEditingController _textController = new TextEditingController();
  AppLifecycleState appLifecycleState;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    appLifecycleState = state;
    // if (state == AppLifecycleState.paused ||
    //     state == AppLifecycleState.inactive ||
    //     state == AppLifecycleState.suspending) {
    //   BlocProvider.of<MassengerBloc>(context).add(SuspendAppEvent());
    // }
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<MassengerBloc>(context).add(RefreashChat());
    }
    print(state);
  }

  String otherName;
  AnimationController scaleController;
  AnimationController fadeController;
  AnimationController emojiController;
  Animation scaleAnimation;
  Animation fadeAnimation;
  Animation emojiAnimation;
  double h;
  double w;
  bool showEmoji = false;
  FocusNode focusNode = FocusNode();
  List<String> followListIds;
  bool islimit = false;
  bool isFollowingOtherSecretly = false;
  @override
  void initState() {
    super.initState();
    otherName = widget.otherName;
    h = widget.h;
    w = widget.w;
    BlocProvider.of<MassengerBloc>(context)
        .add(EnterConversation(widget.otherID, widget.otherName, this));
    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    fadeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
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
    WidgetsBinding.instance.addObserver(this);
    focusNode.addListener(() {
      if (focusNode.hasFocus || !showEmoji) {
        setState(() {
          showEmoji = false;
        });
      }
    });

    BlocProvider.of<UserBloc>(context).followList.forEach((f) {
      if (f.id == widget.otherID) {
        if (f.presentlySecret) {
          isFollowingOtherSecretly = true;
        }

        return;
      }
    });
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    text = text.trim();
    if (text.isNotEmpty) {
      BlocProvider.of<MassengerBloc>(context).add(SendEvent(
          Message(text, DateTime.now().millisecondsSinceEpoch, true, "", ""),
          widget.otherID));
    }
  }

  @override
  void dispose() {
    fadeController.dispose();
    scaleController.dispose();
    emojiController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
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
          BlocProvider.of<MassengerBloc>(context).currentOtherId = null;
          if (widget.isFromFolloweePage) {
            BlocProvider.of<UserBloc>(context).add(GetFollowee());
          }
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.black87,
          title: FlatButton(
            onPressed: () async {
              if (widget.isOtherUnKnown != null) {
                if (!widget.isOtherUnKnown) {
                  final user = await SharedPref.pref.getUser();

                  BlocProvider.of<UserBloc>(context).add(FetchOtherUser(
                    user.id,
                    widget.otherID,
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          maintainState: false,
                          builder: (context) => OtherUserProfile(
                                myId: user.id,
                                otherId: widget.otherID,
                              )));
                }
              }else{
                 final user = await SharedPref.pref.getUser();

                  BlocProvider.of<UserBloc>(context).add(FetchOtherUser(
                    user.id,
                    widget.otherID,
                  ));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          maintainState: false,
                          builder: (context) => OtherUserProfile(
                                myId: user.id,
                                otherId: widget.otherID,
                              )));
              }
            },
            // },
            child: Text(
              otherName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
            ),
          ),
          centerTitle: true,
        ),
        body: BlocListener<MassengerBloc, MassengerState>(
          condition: (prev, cur) {
            return cur is NotConnected || cur is RevealCurrentChatUser;
          },
          listener: (context, state) async {
            if (state is NotConnected) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Center(
                      child: Container(
                          width: sizeAware.width / 1.2,
                          height: sizeAware.height / 3,
                          child: Material(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Connection Problem, try again"),
                                FlatButton(
                                  onPressed: () {
                                    BlocProvider.of<MassengerBloc>(context)
                                        .add(Connect());
                                    Navigator.pop(context);
                                  },
                                  child: Icon(Icons.refresh),
                                )
                              ],
                            ),
                          ))));
            }
            if (state is RevealCurrentChatUser) {
              setState(() {
                otherName = state.newName;
                widget.isOtherUnKnown = false;
              });
              showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (context) => Center(
                      child: Container(
                          width: sizeAware.width / 1.2,
                          height: sizeAware.height / 3,
                          child: Material(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
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
            height: sizeAware.height,
            width: sizeAware.width,
            color: Colors.black87,
            child: Padding(
              padding: EdgeInsets.only(
                  top: h * scaleAnimation.value,
                  left: w * scaleAnimation.value),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: Opacity(
                          opacity: fadeAnimation.value,
                          child: BlocBuilder<MassengerBloc, MassengerState>(
                            condition: (prev, cur) {
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
                      Container(
                          width: sizeAware.width / 1.08,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.only(left: 13, right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey.withOpacity(0.3)),
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.face),
                                color: Colors.black54,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    showEmoji = !showEmoji;

                                    emojiController.reset();
                                    if (showEmoji) {
                                      emojiController.forward();
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: TextField(
                                  focusNode: focusNode,
                                  controller: _textController,
                                  // onSubmitted: _handleSubmitted,
                                  decoration: InputDecoration(
                                      hintText: "Type message here",
                                      border: InputBorder.none),
                                ),
                              ),
                              BlocBuilder<MassengerBloc, MassengerState>(
                                  condition: (prev, cur) {
                                if (cur is RevealCurrentChatUser) {
                                  return false;
                                } else {
                                  return true;
                                }
                              }, builder: (context, state) {
                                if (state is NotConnected ||
                                    state is LoadingConnect) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: null,
                                    ),
                                  );
                                }
                                if (state is LocalMessagesReady) {
                                  if (state.messages.isNotEmpty) {
                                    if (state.messages.first.authorName !=
                                            widget.otherName &&
                                        isFollowingOtherSecretly) {
                                      islimit = true;
                                    } else {
                                      islimit = false;
                                    }
                                  } else {
                                    islimit = false;
                                  }

                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: islimit
                                          ? null
                                          : () => _handleSubmitted(
                                              _textController.text),
                                    ),
                                  );
                                }
                                if (state is MessagesBox) {
                                  if (state.messages.isNotEmpty) {
                                    if (state.messages.first.authorName !=
                                            widget.otherName &&
                                        isFollowingOtherSecretly) {
                                      islimit = true;
                                    } else
                                      islimit = false;
                                  } else {
                                    islimit = false;
                                  }
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    child: IconButton(
                                      icon: Icon(Icons.send),
                                      onPressed: islimit
                                          ? null
                                          : () => _handleSubmitted(
                                              _textController.text),
                                    ),
                                  );
                                }
                                return Container();
                              }),
                            ],
                          )),
                      showEmoji
                          ? SizeTransition(
                              sizeFactor: emojiAnimation,
                              child: EmojiPicker(
                                rows: 3,
                                columns: 5,
                                buttonMode: ButtonMode.MATERIAL,
                                numRecommended: 10,
                                onEmojiSelected: (emoji, category) {
                                  _textController.text += emoji.emoji;
                                },
                              ))
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {this.animationController,
      this.isRecieved,
      this.authorName,
      this.text,
      this.time});
  final bool isRecieved;
  final String text;
  final AnimationController animationController;
  final String authorName;
  final String time;
  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return animationController != null
        ? SizeTransition(
            sizeFactor: CurvedAnimation(
                parent: animationController, curve: Curves.easeOut),
            axisAlignment: 0.0,
            child: isRecieved
                ? recievedMessage(sizeAware)
                : sentMessage(sizeAware))
        : isRecieved ? recievedMessage(sizeAware) : sentMessage(sizeAware);
  }

  Widget recievedMessage(Size sizeAware) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.zero)),
            margin: EdgeInsets.only(
                top: 15,
                left: sizeAware.width * 0.07,
                right: sizeAware.width * 0.3),
            // width: sizeAware.width / 1.5,
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Flexible(
                    child: Text(text,
                        style: TextStyle(color: Colors.black, fontSize: 20))),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(color: Colors.black, fontSize: 12)),
                  ],
                )
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
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.zero,
                    bottomLeft: Radius.circular(10))),
            margin: EdgeInsets.only(
                top: 15,
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
                  text,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
                SizedBox(
                  width: 8,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
