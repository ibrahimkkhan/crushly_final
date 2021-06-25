import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crushly_final/src/db/AppDB.dart';
import '../blocs/Messenger_Bloc/bloc.dart';
import '../blocs/PhotoManger_Bloc/bloc.dart';
import '../blocs/User_Bloc/bloc.dart';
import '../DB/AppDB.dart';
import '../screens/BlockList_Page.dart';
import '../screens/Chat_List.dart';
import '../screens/DateListPage.dart';
import '../screens/NewStory_Page.dart';
import '../screens/NotificationPage.dart';
import '../screens/OtherProfile.dart';
import '../screens/Rings_Holding.dart';
import '../screens/StoryViewPage.dart';
import '../screens/myFollowees_list.dart';
import '../screens/photoView.dart';
import '../Screens/search_user.dart';
import '../models/User.dart';
import '../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import '../../main.dart';

import 'OpenlyFollowList.dart';
import 'SecretlyFollowList.dart';

class MyProfile extends StatefulWidget {
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  late AppLifecycleState appLifecycleState;
  late List<User> followlist;
  final ImagePicker _picker = ImagePicker();

  late PickedFile? _image;

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      _image = response.file;
      photomanagerBloc.add(SetPhoto(_image as File));
    }
  }

  late PhotomanagerBloc photomanagerBloc;

  Future _getImage() async {
    var image = await _picker.getImage(source: ImageSource.camera);

    if (image != null) {
      _image = image;
      photomanagerBloc.add(SetPhoto(_image as File));
    }
  }

  @override
  void initState() {
    super.initState();
    photomanagerBloc = PhotomanagerBloc();
    if (Platform.isAndroid) retrieveLostData();
  }

  @override
  void dispose() {
    photomanagerBloc.close();
    super.dispose();
  }

  late String photoUrl;
  late String myId;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return BlocListener<MassengerBloc, MassengerState>(
      listener: (context, state) async {
        if (state is NotConnected) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => Center(
                    child: Container(
                      width: width / 1.2,
                      height: height / 3,
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
                      ),
                    ),
                  ));
        }
        if (state is NavigateState) {
          if (state.payload == "message") {
            Navigator.popUntil(
                context, (Route<dynamic> route) => route is PageRoute);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatList(
                          followersList: followlist ?? [],
                        )));
          }
          if (state.payload.contains("reveal")) {
            Navigator.popUntil(
                context, (Route<dynamic> route) => route is PageRoute);
            BlocProvider.of<UserBloc>(context)
                .add(FetchOtherUser(state.payload.substring(7)));
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OtherUserProfile(
                          otherId: state.payload.substring(7),
                        )));
          }
          if (state.payload == "followee") {
            Navigator.popUntil(
                context, (Route<dynamic> route) => route is PageRoute);
            BlocProvider.of<UserBloc>(context).add(GetFollowee());
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyFolloweesList()));
          }
        }
      },
      child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previousState, currentState) {
        if (currentState is fetchSuccefully ||
            currentState is fetchFailed ||
            currentState is LoadingFetch) {
          return true;
        } else {
          return false;
        }
      }, builder: (context, state) {
        if (state is fetchSuccefully) {
          followlist = state.user.followList!;
          myId = state.user.id;
          photoUrl = state.user.profilePhoto!;
          return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                SearchUser(myId, false, () {})));
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.message,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatList(
                                      followersList: state.user.followList!,
                                    )));
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  GestureDetector(
                    child: Container(
                        margin: EdgeInsets.all(12),
                        child: Text(
                          "BlockList",
                          style: TextStyle(color: Colors.black),
                        )),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlockListPage(
                                    state.user.id,
                                  )));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        margin: EdgeInsets.all(12),
                        child: Text(
                          "Rings",
                          style: TextStyle(color: Colors.black),
                        )),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RingsPage()));
                    },
                  ),
                  GestureDetector(
                    child: Container(
                        margin: EdgeInsets.all(12),
                        child: Text(
                          "logout",
                          style: TextStyle(color: Colors.black),
                        )),
                    onTap: () {
                      BlocProvider.of<MassengerBloc>(context).disconnect();
                      BlocProvider.of<UserBloc>(context).add(Logout());
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePage()));
                    },
                  ),
                ],
                elevation: 0,
                backgroundColor: Colors.white,
              ),
              body: Container(
                child: CustomScrollView(slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Center(
                        child: Container(
                          height: height * 0.24,
                          width: width * 0.4,
                          child: Stack(
                              alignment: Alignment.bottomRight,
                              fit: StackFit.expand,
                              children: <Widget>[
                                BlocBuilder(
                                    bloc: photomanagerBloc,
                                    builder: (context, state) {
                                      if (state is LoadingPhoto) {
                                        return Container(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      }
                                      if (state is SetPhotoSuccess) {
                                        photoUrl = state.photoUrl;
                                        return state.photoUrl.contains("http")
                                            ? Container(
                                                margin: const EdgeInsets.only(
                                                    top: 20),
                                                height: height * 0.24,
                                                width: width * 0.4,
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.035),
                                                  ),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.15),
                                                      offset: Offset(0.0, 12),
                                                      blurRadius: height * 0.03,
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        height * 0.035),
                                                  ),
                                                  // child: Image.network(
                                                  //   photoUrl,
                                                  //   fit: BoxFit.cover,
                                                  // ),
                                                ),
                                              )
                                            : Container(
                                                child: Center(
                                                  child: Text(
                                                      "image url is not valid"),
                                                ),
                                              );
                                      }
                                      if (photoUrl != null || photoUrl != "") {
                                        return Container(
                                            margin:
                                                const EdgeInsets.only(top: 20),
                                            height: height * 0.24,
                                            width: width * 0.4,
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.15),
                                                  offset: Offset(0.0, 12),
                                                  blurRadius: height * 0.03,
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(height * 0.05),
                                              ),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(height * 0.05),
                                              ),
                                              // child: Image.network(
                                              //    photoUrl,fit: BoxFit.cover,),
                                            ));
                                      } else {
                                        return Container();
                                      }
                                    }),
                                Positioned(
                                  right: 0.0,
                                  bottom: 0.0,
                                  child: GestureDetector(
                                    onTap: () {
                                      _getImage();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white),
                                      child: Center(
                                        child: Icon(
                                          Icons.camera,
                                          color: Colors.deepPurple,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Text(
                          capitalizeNames(state.user.name!) ?? 'NULL',
                          style: TextStyle(
                            fontFamily: "Raleway",
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.03,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                              "ΠΔΦ",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: "Raleway",
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                                fontSize: height * 0.03,
                              ),
                            ),
                          ),
                          BlocBuilder<MassengerBloc, MassengerState>(
                            buildWhen: (pre, cur) =>
                                cur is Connected || cur is NotConnected,
                            builder: (context, state) {
                              if (state is Connected) {
                                return Text(
                                  "   online",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold),
                                );
                              }
                              if (state is NotConnected) {
                                return Text("   offline",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold));
                              }
                              return Container();
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.35,
                            height: height * 0.05,
                            child: RaisedButton(
                              elevation: 2,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OpenlyFollowList(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "Openly Follow List",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: height * 0.017,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.35,
                            height: height * 0.05,
                            child: RaisedButton(
                              elevation: 2,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SecretlyFollowList(
                                      state.user.id,
                                    ),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "secretly Follow List",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: height * 0.017,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: width * 0.25,
                            height: height * 0.05,
                            child: RaisedButton(
                              elevation: 2,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                BlocProvider.of<UserBloc>(context)
                                    .add(GetFollowee());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyFolloweesList(),
                                  ),
                                );
                              },
                              child: Text(
                                "my followers",
                                style: TextStyle(
                                  fontFamily: "Raleway",
                                  fontSize: height * 0.017,
                                  color: Colors.white,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.25,
                            height: height * 0.05,
                            child: RaisedButton(
                              elevation: 2,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                BlocProvider.of<UserBloc>(context)
                                    .add(GetDates());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DateListPage(),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "date list",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: height * 0.017,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                  top: height * 0.00689655172,
                                  left: width * 0.05,
                                  right: width * 0.05,
                                  bottom: height * 0.01379310344,
                                ),
                                child: Container(
                                  child: Text(
                                    "FOLLOWERS",
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        fontSize: height * 0.025,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: height * 0.02),
                                child: Text(
                                  state.user.followCount.toString(),
                                  style: TextStyle(
                                      fontFamily: "Raleway",
                                      fontSize: height * 0.033,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.none),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: height * 0.00689655172,
                                    bottom: height * 0.01379310344),
                                child: Container(
                                  child: Text(
                                    "COMPLIMENTS",
                                    style: TextStyle(
                                        fontFamily: "Raleway",
                                        fontSize: height * 0.025,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.none),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: height * 0.02),
                                child: Text(
                                  state.user.followList != null
                                      ? state.user.followList!.length.toString()
                                      : '',
                                  style: TextStyle(
                                      fontFamily: "Raleway",
                                      fontSize: height * 0.033,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.none),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.025, left: width * 0.05),
                            child: Text(
                              "My Photos",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: height * 0.025, right: width * 0.05),
                            child: Text(
                              "See All",
                              style: TextStyle(
                                fontFamily: "Raleway",
                                fontSize: height * 0.02,
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.25,
                            height: height * 0.05,
                            child: RaisedButton(
                              elevation: 2,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                BlocProvider.of<UserBloc>(context)
                                    .add(GetNotification());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        NotificationPage(myId),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "notification",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: height * 0.017,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.16,
                            height: height * 0.05,
                            child: RaisedButton(
                              elevation: 2,
                              color: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewStoryPage(myId),
                                  ),
                                );
                              },
                              child: Center(
                                child: Text(
                                  "new story",
                                  style: TextStyle(
                                    fontFamily: "Raleway",
                                    fontSize: height * 0.017,
                                    color: Colors.white,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      StreamBuilder<List<UserWithStory>>(
                          stream: BlocProvider.of<MassengerBloc>(context)
                              .appDataBase
                              .watchUserWithStories(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isEmpty) {
                                return Text("no Stories");
                              }
                              return Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    StoryViewPage(
                                                        snapshot.data as List<dynamic>)));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          radius: 50,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  snapshot
                                                      .data![index].story.url),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          })
                    ]),
                  ),
                  SliverStaggeredGrid.countBuilder(
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    crossAxisCount: 4,
                    itemCount: 6,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return PhotoViewPage(index.toString());
                                  },
                                  transitionsBuilder: (___,
                                      Animation<double> animation,
                                      ____,
                                      Widget child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  }));
                        },
                        child: Material(
                          elevation: 20,
                          borderRadius: BorderRadius.circular(18),
                          child: InkWell(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  "lib/Fonts/ananya.png",
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                      ),
                    ),
                    staggeredTileBuilder: (i) =>
                        StaggeredTile.count(2, i.isEven ? 2 : 3),
                  ),
                ]),
              ));
        }
        if (state is fetchFailed) {
          return Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  state.error,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.03448275862,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context).add(FetchUser());
                  },
                )
              ],
            ),
          );
        }
        return Material(
          child: Center(
            child: SpinKitThreeBounce(
              duration: Duration(milliseconds: 1000),
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          ),
        );
      }),
    );
  }

// storyCollector(List<Story> stories) {
//   String handler = stories[0].author.id;
//   Map<String, List<Story>> map;
//   map.addEntries([MapEntry(handler,[])])
//   for (int i = 1; i < stories.length - 2; i++) {
//     if (handler == stories[i].author.id) {

//     }
//   }
// }
}
