import 'package:crushly/BLocs/Followers&Date_Bloc/followers_date_bloc.dart';
import 'package:crushly/BLocs/Followers&Date_Bloc/followers_date_event.dart';
import 'package:crushly/BLocs/Followers&Date_Bloc/followers_date_state.dart';
import 'package:crushly/BLocs/User_Bloc/bloc.dart';
import 'package:crushly/Common/InListsSearchDelegate.dart';
import 'package:crushly/Screens/OtherProfile.dart';
import 'package:crushly/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecretlyFollowList extends StatefulWidget {
  final String myId;

  SecretlyFollowList(this.myId);

  @override
  _SecretlyFollowListState createState() => _SecretlyFollowListState();
}

class _SecretlyFollowListState extends State<SecretlyFollowList> {
  FollowersDateBloc followersDateBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      followersDateBloc.add(GetMoreSecretlyUsers());
    }
  }

  @override
  void initState() {
    super.initState();
    followersDateBloc = FollowersDateBloc();
    followersDateBloc.add(GetSecretlyUsers());
    _scrollController.addListener(_onScroll);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[900],
        title: Text("follow List"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: InListSearchDelegate(2));
            },
          )
        ],
      ),
      body: BlocBuilder(
        bloc: followersDateBloc,
        builder: (context, state) {
          if (state is ResultsReady) {
            return state.result.isNotEmpty
                ? ListView.builder(
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
                        onTap: () async {
//                          BlocProvider.of<UserBloc>(context)
//                              .add(FetchOtherUser(state.result[index].id));
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherUserProfile(
                                otherId: state.result[index].id,
                                index: index,
                              ),
                            ),
                          );
                          if (result['index'] != null) {

                          }
                        },
                        title: Text(capitalizeNames(state.result[index].name)),
                        subtitle: Text("@username"),
                        trailing: Padding(
                          padding: EdgeInsets.only(top: height * 0.015),
                          child: Column(
                            children: <Widget>[
                              Text(state.result[index].orignallySecret
                                  ? "Orginallysecret true"
                                  : "Orginallysecret false"),
                              Text(state.result[index].presentlySecret
                                  ? "presentlySecret  true"
                                  : "presentlySecret  false"),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No Followers"),
                  );
          }
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                  MediaQuery.of(context).size.height * 0.02)),
          elevation: 2,
          title: new Text("Anonymous"),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.175,
            child: Column(
              children: <Widget>[
                Divider(
                  height: MediaQuery.of(context).size.height * 0.01,
                  color: Colors.white,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Anonymous',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: ' is followed by'),
                      TextSpan(
                          text: ' 6 people     ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.01,
                  color: Colors.white,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Anonymous',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(text: ' lives'),
                      TextSpan(
                        text: ' 3 miles away',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: ' from you'),
                    ],
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.01,
                  color: Colors.white,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Anonymous and',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' you share a class      ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Divider(
                  height: MediaQuery.of(context).size.height * 0.01,
                  color: Colors.white,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Anonymous sent',
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text:
                              ' you a text with Hint:\"I am in your CMSC132 class\"',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                // RichText(
                //   "Anonymous is followed by 6 people",
                // ),
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
