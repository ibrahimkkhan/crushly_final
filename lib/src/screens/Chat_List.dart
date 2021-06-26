import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import '../blocs/Followers&Date_Bloc/bloc.dart';
import '../Screens/OtherProfile.dart';
import '../screens/new_chat_screen.dart';
import '../theme/theme.dart';
import '../utils/custom_icons.dart';
import '../utils/main_screen_delegate.dart';
import '../utils/our_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/Messenger_Bloc/bloc.dart';
import '../Screens/Chat_Page.dart';
import '../db/AppDB.dart';
import '../models/User.dart';
import 'package:oktoast/oktoast.dart';

class ChatList extends StatefulWidget {
  final List<User> followersList;

  final MainScreenDelegate? mainScreenDelegate;

  ChatList({Key? key, required this.followersList,this.mainScreenDelegate});

  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList>
    with AutomaticKeepAliveClientMixin<ChatList> {
  late FollowersDateBloc followersDateBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final sizeAware = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
//        bottom: PreferredSize(
//          preferredSize: const Size.fromHeight(48.0),
//          child: Theme(
//            data: Theme.of(context).copyWith(accentColor: Colors.white),
//            child: Container(
//                height: 48.0, alignment: Alignment.center, color: Colors.white
//                // child: ,
//                ),
//          ),
//        ),
        leading: IconButton(
          onPressed: () =>
              widget.mainScreenDelegate!.iconClicked(MainScreenIcon.HOME),
          icon: Icon(
            Icons.arrow_back_ios,
            color: pink,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: accent,
          size: 16,
        ),
        centerTitle: true,
        title: Text(
          "Conversations",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: accent,
            fontSize: 16,
          ),

          // TextStyle(
          //   color: accent,
          //   fontSize: 16,
          //   fontWeight: FontWeight.w500,
          // ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: BlocListener<MassengerBloc, MassengerState>(
        listener: (context, state) async {
          if (state is NavigateState) {
            print(state.payload);
            print(
                "user will navigate to chat page here, after user click the notification");
          }
          /*if (state is Connected) {
            /* showToastWidget(
                toast(MediaQuery.of(context).size, "", "Connected!", false,
                    () {}),
                handleTouch: false,
                position: ToastPosition.top,
                duration: Duration(seconds: 2),
                dismissOtherToast: true);*/
          }*/
          if (state is NotConnected) {
            showToastWidget(
                toast(MediaQuery.of(context).size, "lib/Fonts/retry.svg",
                    "Connection Problem, try again", true, () {
                  BlocProvider.of<MassengerBloc>(context).add(Connect());
                  showToastWidget(Text(""), dismissOtherToast: true);
                }),
                handleTouch: true,
                position: ToastPosition.top,
                dismissOtherToast: false, onDismiss: () {
              Connectivity().checkConnectivity().then((event) {
                if (event != ConnectivityResult.none)
                  showToastWidget(
                      toast(MediaQuery.of(context).size, "", "Connected!",
                          false, () {}),
                      handleTouch: false,
                      position: ToastPosition.top,
                      duration: Duration(seconds: 2),
                      dismissOtherToast: true);
              });
            }, duration: Duration(days: 1));
          }
        },
        child: Material(
          child: Container(
            height: sizeAware.height,
            width: sizeAware.width,
            child: Stack(
              children: <Widget>[
                BlocBuilder(
                    buildWhen: (_, curr) => curr is ResultsReady,
                    bloc: followersDateBloc,
                    builder: (context, state) {
                      if (state is ResultsReady)
                        return state.result.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                    color: white,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.0),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30.0,
                                              right: 20.0,
                                              bottom: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                'Recent Crushees',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: darkBlue,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                'View All',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: lightBlue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: sizeAware.height / 12.5,
                                          child: ListView.builder(
                                            controller: _scrollController,
                                            itemCount: state.result.length,
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    sizeAware.width / 18.75),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatPage(
                                                        presentlySecret: state
                                                            .result[index]
                                                            .presentlySecret,
                                                        otherID: state
                                                            .result[index].id,
                                                        otherName: state
                                                            .result[index].name,
                                                        otherImage: state
                                                            .result[index]
                                                            .thumbnail,
                                                        isFromFolloweePage:
                                                            false,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          sizeAware.width / 30),
                                                  child: CircleAvatar(
                                                    minRadius:
                                                        sizeAware.height / 25,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                      state.result[index]
                                                          .thumbnail,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: StreamBuilder<List<UserWithMessage>>(
                                      stream: BlocProvider.of<MassengerBloc>(
                                              context)
                                          .appDataBase
                                          .watchUserWithMessages(),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.isEmpty) {
                                            return Center(
                                              child: Text("No Conversations"),
                                            );
                                          }
                                          return ListView.builder(
                                            itemCount: snapshot.data!.length,
//                              itemCount: 8,
                                            itemBuilder: (context, index) {
                                              return ChatCard(
//                                  null,
                                                snapshot.data![index],
                                              );
                                            },
                                          );
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                            : Container();
                      else
                        return Container();
                    }),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: sizeAware.height / 25,
                        bottom: sizeAware.height / 25),
                    child: Container(
                      width: sizeAware.height / 10.53,
                      height: sizeAware.height / 10.53,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[300]!,
                            spreadRadius: 3.0,
                            blurRadius: 6.0,
                            offset: Offset(0.0, 4.0),
                          ),
                        ],
                        //gradient: appGradient,
                        color: pink,
                        shape: BoxShape.circle,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        shadowColor: Colors.black54,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewChat(
                                          openChat: true,
                                        )));
                          },
                          child: Icon(
                            CustomIcons.ic_new_chat,
                            color: white,
                            size: sizeAware.height / 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      followersDateBloc.add(GetMoreSecretlyUsers());
    }
  }

  @override
  void initState() {
    followersDateBloc = FollowersDateBloc();
    followersDateBloc.add(GetSecretlyUsers());
    _scrollController.addListener(_onScroll);
    super.initState();
  }
}

class ChatCard extends StatelessWidget {
  const ChatCard(this.data);

  final UserWithMessage data;

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    print('num of unread ${data.user.numOfUnRead}');
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: () {
          print("is user presently secret :" +
              data.user.presentlySecret.toString());
          Navigator.push(
            context,
            CupertinoPageRoute(
              maintainState: true,
              builder: (context) => ChatPage(
                presentlySecret: data.user.presentlySecret,
                originallySecret: data.user.orginalySecret,
                otherID: data.user.id,
                otherImage: data.user.image,
                otherName: data.user.name,
                isFromFolloweePage: false,
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Stack(
                    alignment: Alignment.topRight,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                        child: CircleAvatar(
                          radius: 28,
                          backgroundImage: CachedNetworkImageProvider(
                            data.user.image ?? "",
                          ),
                        ),
                      ),
//                    data.user.numOfUnRead != 0
//                          ? Container(
//                              width: 23,
//                              height: 25,
//                              decoration: BoxDecoration(
//                                shape: BoxShape.circle,
//                                color: Colors.redAccent,
//                              ),
//                              child: Center(
//                                child: Text(
//                                  data.user.numOfUnRead.toString(),
//                                  style: TextStyle(
//                                    color: Colors.white,
//                                    fontWeight: FontWeight.w500,
//                                  ),
//                                ),
//                              ),
//                            )
//                          : Container()
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data.user.name!,
//                        'Beverly Jones',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: accent,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          data.message.message,
//                          'You know you’re in love when..',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: textGrey,
                            fontWeight: data.user.numOfUnRead != 0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      )
                    ],
                  ),
//                  Text(
//                    "pty secret:" + data.user.presentlySecret.toString(),
//                    style: TextStyle(fontSize: 8),
//                  )
                ],
              ),
//              Text(DateTime.fromMillisecondsSinceEpoch(
//                          int.parse(data.message.createdAt))
//                      .hour
//                      .toString() +
//                  ":" +
//                  DateTime.fromMillisecondsSinceEpoch(
//                          int.parse(data.message.createdAt))
//                      .minute
//                      .toString()),
            ],
          ),
        ),
      ),
    );
  }
}
