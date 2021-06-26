import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/InListSearch_Bloc/bloc.dart';
import '../blocs/User_Bloc/bloc.dart';
import '../Screens/OtherProfile.dart';
import '../models/User.dart';
import '../utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class InListSearchDelegate extends SearchDelegate<User?> {
  final int listNum;
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      inListSearchBloc.add(MoreSearch(query, listNum));
    }
  }

  InListSearchDelegate(this.listNum) : super() {
    _scrollController.addListener(_onScroll);
  }
  final InlistsearchBloc inListSearchBloc = InlistsearchBloc();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [Container()];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      inListSearchBloc.add(Search(query, listNum));
      return BlocBuilder(
        bloc: inListSearchBloc,
        builder: (context, state) {
          if (state is SearchResult) {
            if (state.result.isEmpty) {
              return Center(
                child: Text("No Result"),
              );
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
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
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.person),
                            title: Text(
                              capitalizeNames(state.result[index].name),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        onTap: () {
//                          BlocProvider.of<UserBloc>(context).add(
//                              FetchOtherUser(state.result[index].id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherUserProfile(
                                otherId: state.result[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // state.hasReachedMax
                //     ? Container()
                //     : Center(
                //         child: CircularProgressIndicator(),
                //       )
              ],
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text("error"),
            );
          }
          if (query == '') {
            return Center(
              child: Text("type somthing to search"),
            );
          }
          return Center(
            child: SpinKitThreeBounce(
              duration: Duration(milliseconds: 1000),
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          );
        },
      );
    }
    return Center(
      child: Text("enter a search"),
    );
    //   inListSearchBloc.add(Search(query));

    //   return SearchWidget(query,inListSearchBloc);
    // }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      inListSearchBloc.add(Search(query, listNum));
      return BlocBuilder(
        bloc: inListSearchBloc,
        builder: (context, state) {
          if (state is SearchResult) {
            if (state.result.isEmpty) {
              return Center(
                child: Text("No Result"),
              );
            }
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
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
                      return GestureDetector(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(state.result[index].thumbnail),
                            ),
                            title: Text(
                              capitalizeNames(state.result[index].name),
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                        onTap: () {
                          BlocProvider.of<UserBloc>(context).add(
                              FetchOtherUser( state.result[index].id));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherUserProfile(
                                otherId: state.result[index].id,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                // state.hasReachedMax
                //     ? Container()
                //     : Center(
                //         child: CircularProgressIndicator(),
                //       )
              ],
            );
          }
          if (state is ErrorState) {
            return Center(
              child: Text("error"),
            );
          }
          if (query == '') {
            return Center(
              child: Text("type somthing to search"),
            );
          }
          return Center(
            child: SpinKitThreeBounce(
              duration: Duration(milliseconds: 1000),
              color: Theme.of(context).primaryColor,
              size: 50.0,
            ),
          );
        },
      );
    }
    return Center(
      child: Text("enter a search"),
    );
  }
}
