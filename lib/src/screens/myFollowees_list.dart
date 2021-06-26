import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/Followers&Date_Bloc/bloc.dart';
import '../blocs/Followers&Date_Bloc/followers_date_bloc.dart';
import '../blocs/Followers&Date_Bloc/followers_date_event.dart';
import '../blocs/InListSearch_Bloc/inlistsearch_bloc.dart';
import '../common/InListsSearchDelegate.dart';
import '../DB/AppDB.dart';
import '../Screens/OpenlyFollowList.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../BLocs/User_Bloc/bloc.dart';
import '../Screens/Chat_Page.dart';
import '../Screens/OtherProfile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyFolloweesList extends StatefulWidget {
  final bool? openChat;

  const MyFolloweesList({Key? key, this.openChat}) : super(key: key);

  @override
  _MyFolloweesListState createState() => _MyFolloweesListState();
}

class _MyFolloweesListState extends State<MyFolloweesList> {
  late FollowersDateBloc followersDateBloc;
  late InlistsearchBloc inlistsearchBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      followersDateBloc.add(GetMoreOpenlyUsers());
    }
  }

  @override
  void initState() {
    super.initState();
    followersDateBloc = FollowersDateBloc();
    followersDateBloc.add(GetOpenlyUsers());
    _scrollController.addListener(_onScroll);
    inlistsearchBloc = InlistsearchBloc();
  }

  @override
  void dispose() {
    followersDateBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SearchBar(
          text: 'Search for people you have a crush on',
          onTap: () => showSearch(
            context: context,
            delegate: InListSearchDelegate(1),
          ),
        ),
        Expanded(
          child: Scaffold(
            backgroundColor: pageBackground,
            body: BlocBuilder(
              bloc: followersDateBloc,
              builder: (context, state) {
                if (state is ResultsReady) {
                  return state.result.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: state.hasReachedMax
                              ? state.result.length
                              : state.result.length + 1,
                          itemBuilder: (context, index) {
                            if (index + 1 > state.result.length) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => widget.openChat!
                                        ? ChatPage(
                                      presentlySecret: state.result[index].presentlySecret,
                                      otherID: state.result[index].id,
                                      otherName:
                                      state.result[index].name,
                                      otherImage:
                                      state.result[index].thumbnail,
                                      isFromFolloweePage: false,
                                    )
                                        : OtherUserProfile(
                                        otherId: state.result[index].id),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: height / 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    state.result[index].thumbnail),
                              ),
                              subtitle: Text(state.result[index].presentlySecret
                                  ? 'My Secret Crush'
                                  : 'My Crush'),
                              title: Text(
                                  capitalizeNames(state.result[index].name)),
                            );
                          },
                        )
                      : Center(
                          child: Text("No Crushes"),
                        );
                }
                if (state is Loading) {
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
        )
      ],
    );
  }
}

class FolloweeCard extends StatelessWidget {
  const FolloweeCard(this.user, this.myId);

  final String myId;
  final FolloweeUser user;

  @override
  Widget build(BuildContext context) {
    final sizeAware = MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: user.presentlySecret
            ? null
            : () {
                BlocProvider.of<UserBloc>(context).add(FetchOtherUser(user.id));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtherUserProfile(otherId: user.id),
                  ),
                );
              },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: [
                Container(
                  height: sizeAware.height * 0.11,
                  width: sizeAware.width * 0.23,
                  padding: EdgeInsets.all(2.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(sizeAware.height * 0.035),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0.0, 12),
                        blurRadius: 20,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(sizeAware.height * 0.035),
                    ),
                    child: Image.asset(
                      "lib/Fonts/a.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),

                  // child: Image.network(
                  //     state.user.profilePhoto),
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user.name!,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Text(
                        "@userName",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    )
                  ],
                ),
              ]),
              Row(
                children: <Widget>[
                  user.presentlySecret
                      ? IconButton(
                          icon: Icon(
                            Icons.message,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            print("is user secret : " +
                                user.presentlySecret.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatPage(
                                          presentlySecret: user.presentlySecret,
                                          otherID: user.id,
                                          otherName: user.name,
                                          isFromFolloweePage: true,
                                          otherImage: user.thumbnail,
                                        )));
                          },
                        )
                      : Container(),
                  Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          user.orginalySecret
                              ? "Orginally secret true"
                              : "Orginally secret false",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                      Container(
                        child: Text(
                          user.presentlySecret
                              ? "presentlySecret true"
                              : "presentlySecret false",
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
