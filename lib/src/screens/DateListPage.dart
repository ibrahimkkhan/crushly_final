import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/Followers&Date_Bloc/followers_date_bloc.dart';
import '../blocs/Followers&Date_Bloc/followers_date_event.dart';
import '../blocs/Followers&Date_Bloc/followers_date_state.dart';
import '../common/InListsSearchDelegate.dart';
import '../Screens/Chat_Page.dart';
import '../Screens/OpenlyFollowList.dart';
import '../theme/theme.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Screens/OtherProfile.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DateListPage extends StatefulWidget {
  final bool openChat;

  const DateListPage({Key? key, required this.openChat}) : super(key: key);



  @override
  _DateListPageState createState() => _DateListPageState();
}

class _DateListPageState extends State<DateListPage> {
  late FollowersDateBloc followersDateBloc;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      followersDateBloc.add(GetMoreDateUsers());
    }
  }

  @override
  void initState() {
    super.initState();
    followersDateBloc = FollowersDateBloc();
    followersDateBloc.add(GetDateUsers());
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
    return Column(
      children: <Widget>[
        SearchBar(
          text: 'Search for matches',
          onTap: () => showSearch(
            context: context,
            delegate: InListSearchDelegate(
              3,
            ),
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
                                if (state.result[index].orignallySecret ==
                                        null ||
                                    !state.result[index].orignallySecret) {
                                  Navigator.of(context).pop();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => widget.openChat
                                          ? ChatPage(
                                        presentlySecret: false,
                                        otherID: state.result[index].partnerId,
                                        otherName:
                                        state.result[index].name,
                                        otherImage:
                                        state.result[index].thumbnail,
                                        isFromFolloweePage: false,
                                      )
                                          : OtherUserProfile(
                                          otherId: state.result[index].partnerId),
                                    ),
                                  );
                                }
                              },
                              leading: CircleAvatar(
                                radius: height / 30,
                                backgroundImage: CachedNetworkImageProvider(
                                    state.result[index].thumbnail),
                              ),
                              title: Text(
                                capitalizeNames(state.result[index].name),
                                style: TextStyle(),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text("No Dates"),
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
