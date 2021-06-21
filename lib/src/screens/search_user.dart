import 'package:cached_network_image/cached_network_image.dart';
import '../blocs/Search_Bloc/search_bloc.dart';
import '../blocs/Search_Bloc/search_event.dart';
import '../blocs/Search_Bloc/search_state.dart';
import '../Screens/OtherProfile.dart';
import '../theme/theme.dart';
import '../utils/linear_gradient_mask.dart';
import '../utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchUser extends StatefulWidget {
  final bool isOtherPage;
  final String myId;
  final Function onBack;

  SearchUser(this.myId, this.isOtherPage, this.onBack);

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  final SearchBloc searchBloc = SearchBloc();
  final _scrollThreshold = 200.0;
  late Size screenSize;
  double size = 0.0;

  _SearchUserState() {
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    size = screenSize.width / 1.8;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      // appBar: _getSearchBar(),
      body: _getSearchResult(),
    );
  }

/* Expanded(
                child: TextField(
                  maxLines: 1,
                  controller: _searchController,
                  textInputAction: TextInputAction.done,
//                  onSubmitted: (str) => searchBloc.add(Search(str)),
                  onChanged: (str) => searchBloc.add(Search(str)),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: screenSize.width / 35,
                        top: screenSize.height * 0.02),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),*/

  Widget _getSearchResult() {
    return SafeArea(
      child: Container(
        color: appBarBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: screenSize.height / 45, bottom: screenSize.height / 60),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: screenSize.width / 25,
                      ),
                      // height: screenSize.height / 5,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Colors.black12,
                            offset: Offset(0, 2),
                          )
                        ],
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(40),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15.0,
                              right: 15.0,
                            ),
                            child: LinearGradientMask(
                              child: Container(
                                width: 25,
                                height: 25,
                                child: Image.asset(
                                  'lib/Fonts/searchIcon.png',
                                  color: Colors.white,
                                ),
                              ),
                              active: true,
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: TextField(
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: darkBlue,
                                ),
                                controller: _searchController,
                                textInputAction: TextInputAction.done,
                                //          onSubmitted: (str) => searchBloc.add(Search(str)),
                                onChanged: (str) => searchBloc.add(Search(str)),
                                maxLines: 1,
                                decoration: InputDecoration(
                                    border: new OutlineInputBorder(
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(50.0),
                                      ),
                                    ),
                                    hintText: "Search for your crush",
                                    enabledBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: textGrey,
                                      fontSize: 14.0,
                                    )
                                    /* active: emailController.text.isNotEmpty,
                    error: !state.emailValidation,*/
                                    ),
                              ),
                            ),
                          ),
                          /*Expanded(
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: screenSize.width / 15),
                                child: TextField(
                                  controller: _searchController,
                                  textInputAction: TextInputAction.done,
                                  //          onSubmitted: (str) => searchBloc.add(Search(str)),
                                  onChanged: (str) =>
                                      searchBloc.add(Search(str)),
                                  maxLines: 1,
                                  decoration: InputDecoration.collapsed(
                                      hintText: "Search for your crush",
                                      hintStyle: TextStyle(
                                          color: textGrey,
                                          fontSize: screenSize.height / 65)),
                                ),
                              ),
                            ),
                          )*/
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: screenSize.width / 25),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: resendColor,
                            fontSize: screenSize.height / 60),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder(
                bloc: searchBloc,
                builder: (context, state) {
                  print('STATE = ' + state.toString());
//        if (_searchController.text.isNotEmpty && state.result.isNotEmpty) {
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
                            itemCount: searchBloc.hasReachedMax
                                ? state.result.length
                                : state.result.length + 1,
                            itemBuilder: (context, index) {
                              if (index + 1 > state.result.length) {
                                return Center(
                                  child: LinearProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            accent),
                                  ),
                                );
                              }
                              return GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 16.0,
                                            left: 8.0,
                                            top: 8.0,
                                            bottom: 8.0),
                                        child: CircleAvatar(
                                          backgroundImage:
                                              CachedNetworkImageProvider(state
                                                  .result[index].thumbnail),
                                          radius: screenSize.width * 0.08,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${capitalizeNames(state.result[index].name)}',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.height / 50,
                                                fontWeight: FontWeight.w500,
                                                color: darkBlue),
                                          ),
                                          Text(
                                            'Crush',
                                            style: TextStyle(
                                              fontSize: screenSize.height / 55,
                                              color: lightBlue,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  print('myId = ${widget.myId}');
                                  print('other id = ${state.result[index].id}');
//                        BlocProvider.of<UserBloc>(context)
//                            .add(FetchOtherUser(state.result[index].id));
//                        if (widget.isOtherPage)
                                  Navigator.of(context).pop();
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
                      ],
                    );
                  }
                  if (state is SearchError) {
                    return Center(
                      child: Text(state.error),
                    );
                  }
                  if (state is LoadingSearch) {
                    return Center(
                      child: SpinKitThreeBounce(
                        duration: Duration(milliseconds: 1000),
                        color: lightGrey,
                        size: 50.0,
                      ),
                    );
                  }
                  if (_searchController.text.isEmpty) {
                    return Center(
                      child: Text("Type somthing to search"),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getSearchBar() {
    return AppBar(
      backgroundColor: appBarBackgroundColor,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 0,
      /*  leading: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyProfile()));
        },
        child: Padding(
          padding: EdgeInsets.only(
              left: screenSize.width / 14.625, top: screenSize.width / 20.625),
          child: Container(
            decoration: BoxDecoration(),
            width: screenSize.width / 25.625,
            height: screenSize.width / 27.625,
            child: Image.asset(
              'lib/Fonts/user3.png',
              color: Colors.black,
            ),
          ),
        ),
      ),*/
      title: Padding(
        padding: EdgeInsets.only(
            top: screenSize.height / 27.06, bottom: screenSize.height / 60),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenSize.width / 25),
                height: screenSize.height / 20,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(0, 4),
                      )
                    ],
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(screenSize.height / 40.6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                          left: screenSize.width / 25,
                          right: screenSize.width / 25,
                        ),
                        child: LinearGradientMask(
                          child: Container(
                            width: screenSize.width / 15.625,
                            height: screenSize.width / 15.625,
                            child: Image.asset(
                              'lib/Fonts/searchIcon.png',
                              color: Colors.white,
                            ),
                          ),
                          active: true,
                        )),
                    Expanded(
                      child: Center(
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.done,
                          //          onSubmitted: (str) => searchBloc.add(Search(str)),
                          onChanged: (str) => searchBloc.add(Search(str)),
                          maxLines: 1,
                          decoration: InputDecoration.collapsed(
                              hintText: "Search for your crush",
                              hintStyle: TextStyle(
                                  color: textGrey,
                                  fontSize: screenSize.height / 70)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.only(right: screenSize.width / 25),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      color: resendColor, fontSize: screenSize.height / 60),
                ),
              ),
            )
          ],
        ),
      ),

      /*Padding(
        padding: EdgeInsets.only(
            top: screenSize.height / 27.06, bottom: screenSize.height / 60),
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
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width / 15.625),
                    child: Container(
                      width: screenSize.width / 15.625,
                      height: screenSize.width / 15.625,
                      child: Image.asset(
                        'lib/Fonts/user3.png',
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        width: screenSize.width / 15.625,
                        height: screenSize.width / 15.625,
                        child: Image.asset(
                          'lib/Fonts/searchIcon.png',
                          color: pink,
                        ),
                      ),
                      onTap: () {
                        setState(() {});
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return SearchUser(myId, false, _onSearchClosed);
                              },
                            ),
                          );*/
                      },
                    ),
                    Container(
                      width: screenSize.width / 2.4,
                      child: TextField(
                        maxLines: 1,
                        controller: _searchController,
                        textInputAction: TextInputAction.done,
                        //          onSubmitted: (str) => searchBloc.add(Search(str)),
                        onChanged: (str) => searchBloc.add(Search(str)),
                        decoration: InputDecoration.collapsed(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
              /*
                    _onSearchTap
                    */
            ),
            Row(
              children: <Widget>[
                IconButton(
                  iconSize: 0,
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
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
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
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),*/

      /*bottom: PreferredSize(
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: screenSize.width / 5),
            child: Container(
              color: pink,
              height: 1,
              width: screenSize.width / 2,
            ),
          ),
          preferredSize: Size(10, 1)),*/

      /*   actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              top: screenSize.width / 20.625,
              //left: screenSize.width / 25,
              right: screenSize.width / 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationPage(widget.myId)));
                },
                child: Container(
                  decoration: BoxDecoration(),
                  width: screenSize.width / 15.625,
                  height: screenSize.width / 15.625,
                  child: Image.asset(
                    'lib/Fonts/notification.png',
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(
                width: screenSize.width / 25,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(),
                  width: screenSize.width / 15.625,
                  height: screenSize.width / 15.625,
                  child: Image.asset(
                    'lib/Fonts/message.png',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        )
      ],*/
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      searchBloc.add(MoreSearch(_searchController.text));
    }
  }
}
