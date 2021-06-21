import 'package:auto_size_text/auto_size_text.dart';
import 'package:connectivity/connectivity.dart';
import '../blocs/Messenger_Bloc/bloc.dart';
import '../blocs/User_Bloc/bloc.dart';
import '../blocs/landingBloc/bloc.dart';
import '../blocs/landingBloc/landingNavigationBloc/landing_navigation_bloc.dart';
import '../blocs/landingBloc/landingNavigationBloc/landing_navigation_state.dart';
import '../blocs/landingBloc/landing_bloc.dart';
import '../blocs/landingBloc/landing_state.dart';
import '../screens/NotificationPage.dart';
import '../screens/search_user.dart';
import '../SharedPref/SharedPref.dart';
import '../Widgets/paddings.dart';
import '../models/country.dart';
import '../models/country_names.dart';
import '../models/recommendation.dart';
import '../theme/theme.dart';
import '../utils/CustomDotsIndicator.dart';
import '../utils/Dialogs.dart';
import '../utils/Instant_transition.dart';
import '../utils/animated_button.dart';
import '../utils/animated_count.dart';
import '../utils/circular_animation.dart';
import '../utils/constants.dart';
import '../utils/custom_expansion_tile.dart';
import '../utils/main_screen_delegate.dart';
import '../utils/gradient_container_border.dart';
import '../utils/our_toast.dart';
import '../utils/shadow_text.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:oktoast/oktoast.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:rubber/rubber.dart';
import 'package:showcaseview/showcase.dart';
import 'package:showcaseview/showcase_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:transparent_image/transparent_image.dart';

import 'Chat_Page.dart';
import 'lastrecommendatio_page.dart';
import 'my_profile/my_profile_page.dart';
import '../utils/extensions/capitalize.dart';

class MyPainter extends CustomPainter {
  final Offset center;
  final double radius, containerHeight;
  final BuildContext context;

  Color color;
  double statusBarHeight, screenWidth;

  MyPainter({this.context, this.containerHeight, this.center, this.radius}) {
    ThemeData theme = Theme.of(context);

    color = theme.primaryColor;
    statusBarHeight = MediaQuery.of(context).padding.top;
    screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint circlePainter = Paint();

    circlePainter.color = color;
    canvas.clipRect(
        Rect.fromLTWH(0, 0, screenWidth, containerHeight + statusBarHeight));
    canvas.drawCircle(center, radius, circlePainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

GlobalKey _crushKey = new GlobalKey();
GlobalKey _secretCrushKey = new GlobalKey();
GlobalKey _searchCrushKey = new GlobalKey();
GlobalKey _viewProfileKey = new GlobalKey();

class LandingPage extends StatefulWidget {
  final MainScreenDelegate mainScreenDelegate;

  LandingPage({Key key, this.mainScreenDelegate}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<LandingPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  PreloadPageController pageController;
  bool disableTopGestures = false;
  LandingNavigationBloc navigationBloc = LandingNavigationBloc();
  PanelController panelController = PanelController();
  RubberAnimationController _controller;
  ScrollController _profileScrollController;
  ScrollController _secretCrushScrollController;
  AnimationControllerValue upperBoundValue;
  AnimationControllerValue halfBoundValue;
  AnimationControllerValue secretHalfBoundValue;
  AnimationControllerValue secretUpperBoundValue;
  LandingBloc bloc;
  Size screenSize;

  int currentProfilesIndex = 0;

  bool isProfile = true;
  String myId = '';

  double rippleStartX, rippleStartY;
  AnimationController _searchAnimController;
  CurvedAnimation _searchAnimation;
  bool isInSearchMode = false;
  int index = 1;

  @override
  bool get wantKeepAlive {
    return true;
  }

  _initShowCase() async {
    if (isFromLogin) {
      return; // Not Intro for Login
    }
    SharedPref.pref.getIntroShown().then((isShown) {
      print('isShown $isShown');
      if (!isShown) {
        WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase(
              [_crushKey, _secretCrushKey, _searchCrushKey, _viewProfileKey]),
        );
      }
    });
  }

  _showHasCrushDialog(BuildContext context, UserState userState) async {
    Dialogs.showCrushDialog(
      context: context,
      msgBtnCallback: () {
        _sendMessageToCrushCallback(userState);
      },
      userState: userState,
    );
  }

  _sendMessageToCrushCallback(userState) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ChatPage(
          presentlySecret: true,
          originallySecret: false,
          otherID: userState.otherId,
          otherName: 'Test', // Update here...
          isFromFolloweePage: false,
          otherImage: userState.followResponse.profilePhoto,
        ),
      ),
    );
  }

  @override
  void initState() {
    _searchAnimController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _searchAnimation = CurvedAnimation(
      parent: _searchAnimController,
      curve: Curves.easeInOut,
    );
    pageController = PreloadPageController();
//    BlocProvider.of<UserBloc>(context).add(FetchUser());
    bloc = LandingBloc(
        appDataBase: BlocProvider.of<UserBloc>(context).appDataBase);
    bloc.add(GetRecommendations());
    bloc.add(GetProfileStatus());
//    bloc.add(GetQueueResult());
    upperBoundValue = AnimationControllerValue(percentage: 1);
    secretUpperBoundValue = AnimationControllerValue(percentage: 0.7);
    secretHalfBoundValue = AnimationControllerValue(percentage: 0.6);
    halfBoundValue = AnimationControllerValue(percentage: 0.9);
    _controller = RubberAnimationController(
      lowerBoundValue: AnimationControllerValue(percentage: 0.0),
      upperBoundValue: upperBoundValue,
      halfBoundValue: halfBoundValue,
      initialValue: 0,
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _profileScrollController = ScrollController();
    _secretCrushScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _searchAnimController.dispose();
    pageController.dispose();
    navigationBloc.close();
    bloc.close();
    super.dispose();
  }

  _selectPictures() async {
//    final images = await FilePicker.getMultiFile(type: FileType.image);
//    if (images != null) {}

    final images = await MultiImagePicker.pickImages(
      maxImages: 4,
      // maxImages: 6 - state.user.photos.length,
      materialOptions: MaterialOptions(
        actionBarColor: '#454f63',
        statusBarColor: '#454f63',
        lightStatusBar: true,
        startInAllView: true,
        useDetailsView: true,
      ),
    );
    // if (images != null && images.isNotEmpty) {
    //   bloc.add(ChangeImages(images));
    // }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screenSize = MediaQuery.of(context).size;
    rippleStartX = rippleStartX ?? screenSize.width - 70;
    rippleStartY = rippleStartY ?? screenSize.width - 52;
    appBar(String myId, LandingState state) => Container(
          height: screenSize.height / 6,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
            title: Padding(
              padding: EdgeInsets.only(
                  top: screenSize.height / 27.06,
                  bottom: screenSize.height / 35),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () {
                          widget.mainScreenDelegate
                              .iconClicked(MainScreenIcon.PROFILE);
                        },
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width / 15.625),
                        icon: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          width: screenSize.width / 15.625,
                          height: screenSize.width / 15.625,
                          child: Image.asset(
                            'lib/Fonts/user3.png',
                          ),
                        ),
                      ),
                      Showcase.withWidget(
                        shapeBorder: CircleBorder(),
                        key: _searchCrushKey,
                        height: screenSize.height * 0.5,
                        width: screenSize.width,
                        // overlayOpacity: 0,
                        container: Stack(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenSize.height / 50),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: pink,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(screenSize.width / 40),
                                      ),
                                    ),
                                    width: screenSize.width / 2.3,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: screenSize.height * 0.016,
                                        bottom: screenSize.height * 0.016,
                                        left: screenSize.width / 40,
                                        right: screenSize.width / 40,
                                      ),
                                      child: Text(
                                        'Search for your Crush',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: screenSize.width / 29,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.001,
                                    // child: SvgPicture.asset('assets/icons/intro_arrow_down.svg'),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 1, left: screenSize.width / 5),
                              child: SizedBox(
                                height: screenSize.height / 40,
                                child: SvgPicture.asset(
                                    'assets/icons/intro_arrow_up.svg'),
                              ),
                            ),
                          ],
                        ),
                        // animationDuration: Duration(milliseconds: 500),
                        textColor: Colors.white,
                        showcaseBackgroundColor: curiousBlue,
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              InstantTransition(
                                page: SearchUser(myId, false, _onSearchClosed),
                              ),
                            );
                            // _showHasCrushDialog(context, null);
                          },
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.centerLeft,
                          icon: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              width: screenSize.width / 15.625,
                              height: screenSize.width / 15.625,
                              child: Image.asset(
                                'lib/Fonts/searchIcon.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                    /*
                    _onSearchTap
                    */
                  ),
                  Row(
                    children: <Widget>[
                      StreamBuilder<bool>(
                          stream: BlocProvider.of<MassengerBloc>(context)
                              .appDataBase
                              .isThereAnyUnseenNotifications(),
                          builder: (context, snapshot) {
                            return IconButton(
                              padding: EdgeInsets.all(0),
                              alignment: Alignment.centerRight,
                              icon: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(50),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.3),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      width: screenSize.width / 15.625,
                                      height: screenSize.width / 15.625,
                                      child: SvgPicture.asset(
                                        'assets/icons/notification.svg',
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: snapshot.hasData && snapshot.data,
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        width: screenSize.width / 46.875,
                                        height: screenSize.width / 46.875,
                                        margin: EdgeInsets.all(
                                            screenSize.width / 65),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(InstantTransition(
                                    page: NotificationPage(myId)));
                              },
                            );
                          }),
                      StreamBuilder<bool>(
                        stream: BlocProvider.of<MassengerBloc>(context)
                            .appDataBase
                            .isThereAnyUnreadMessages(),
                        builder: (context, snapshot) {
                          print(
                              'unread messages ${snapshot.hasData.toString()} and ${snapshot.data.toString()}');
                          return IconButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenSize.width / 15.625),
                            icon: Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  width: screenSize.width / 18,
                                  height: screenSize.width / 18,
                                  child: SvgPicture.asset(
                                    'assets/icons/message.svg',
                                    color: Colors.white,
                                  ),
                                ),
                                Visibility(
                                  visible: snapshot.hasData && snapshot.data,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Container(
                                      width: screenSize.width / 46.875,
                                      height: screenSize.width / 46.875,
                                      margin:
                                          EdgeInsets.all(screenSize.width / 65),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              widget.mainScreenDelegate
                                  .iconClicked(MainScreenIcon.MESSAGES);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

    //its make the same transition as Akshat asked
    List<Widget> pages = [
      SearchUser(myId, false, _onSearchClosed),
      body(appBar),
      NotificationPage(myId)
    ];
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: Stack(
        children: <Widget>[
          BlocListener(
            bloc: navigationBloc,
            listener: (context, state) {
              if (state is UpdatePreview) {
                pageController.nextPage(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: BlocListener<UserBloc, UserState>(
              condition: (prev, cur) =>
                  cur is ErrorInFollowing ||
                  cur is FollowedSuccessfully ||
                  cur is fetchSuccefully,
              listener: (context, userState) {
                if (userState is fetchSuccefully) myId = userState.user.id;

                if (userState is ErrorInFollowing) {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                          "something went wrong when following , try again..",
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (userState is FollowedSuccessfully) {
                  setState(() {
                    userState.isSecret
                        ? bloc.add(SecretCrushUser(
                            userState.otherId, userState.followResponse))
                        : bloc.add(CrushUser(
                            userState.otherId, userState.followResponse));
                  });
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    // if (userState.followResponse.isDate ?? false) {
                    // showCupertinoDialog(
                    //   context: context,
                    //   builder: (context) {
                    //     return CupertinoAlertDialog(
                    //       title: Text("Congratulations"),
                    //       content: Text("you have a match"),
                    //       actions: <Widget>[
                    //         FlatButton(
                    //           child: Text("ok"),
                    //           onPressed: () {
                    //             Navigator.pop(context);
                    //           },
                    //         )
                    //       ],
                    //     );
                    //   },
                    // );
                    _showHasCrushDialog(context, userState);
                    // }
                  });
                }
              },
              child:
                  false // TODO: this condition need should replaced with the commented condition below
//              myId.isEmpty
                      ? Container()
                      : BlocProvider(
                          builder: (_) => bloc,
                          child: BlocListener(
                            bloc: bloc,
                            listener: (context, LandingState state) {
                              if (state.profileStatus != null) {
                                bool profilePhotoRequired =
                                    state.profileStatus.profilePhotoRequired;
                                bool morePhotosRequired =
                                    state.profileStatus.morePhotosRequired;
                                print(
                                  'Profile Photo Required: $profilePhotoRequired',
                                );
                                print(
                                  'More Photos Required: $morePhotosRequired',
                                );

                                if (profilePhotoRequired ||
                                    morePhotosRequired) {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) {
                                        return MyProfilePage(
                                          () {
                                            _initShowCase();
                                          },
                                          forPhotoUpload: true,
                                        );
                                      },
                                    ),
                                    // (_) => false,
                                  );
                                } else {
                                  _initShowCase();
                                }
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
                                      showToastWidget(Text(""),
                                          dismissOtherToast: true);
                                    }),
                                    handleTouch: true,
                                    position: ToastPosition.top,
                                    dismissOtherToast: false, onDismiss: () {
                                  Connectivity()
                                      .checkConnectivity()
                                      .then((event) {
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
                              if (state is Connected) {
                                /* showToastWidget(
                                    toast(MediaQuery.of(context).size, "",
                                        "Connected!", false, () {}),
                                    handleTouch: false,
                                    position: ToastPosition.top,
                                    duration: Duration(seconds: 2),
                                    dismissOtherToast: true);*/
                              }
                            },
                            child: BlocBuilder(
                              bloc: bloc,
                              builder: (context, LandingState state) {
                                return Scaffold(
                                  key: _scaffoldKey,
                                  body: RubberBottomSheet(
                                    onTap: () {
                                      //
                                    },
                                    headerHeight: 0,
                                    scrollController: isProfile
                                        ? _profileScrollController
                                        : _secretCrushScrollController,
                                    animationController: _controller,
                                    lowerLayer: Stack(
                                      children: <Widget>[
                                        PreloadPageView.builder(
                                          preloadPagesCount: 10,
                                          controller: pageController,
                                          scrollDirection: Axis.vertical,
                                          itemCount: !state.isLoading
                                              ? state.recommendationList
                                                      .length +
                                                  1
                                              : 1,
                                          onPageChanged: (index) {
                                            setState(() {
                                              currentProfilesIndex = index;
                                            });
                                          },
                                          physics: state.isLoading
                                              ? NeverScrollableScrollPhysics()
                                              : null,
                                          itemBuilder: (context, index) {
                                            if (state.isLoading) {
                                              return getRecommendationShimmer();
                                            } else {
                                              if (index <
                                                  state.recommendationList
                                                      .length) {
                                                return GestureDetector(
                                                  onDoubleTap: () {
                                                    setState(() {
                                                      isProfile = true;
                                                      _controller
                                                              .upperBoundValue =
                                                          upperBoundValue;
                                                      _controller
                                                              .halfBoundValue =
                                                          halfBoundValue;
                                                    });
                                                    _controller.halfExpand();
                                                  },
                                                  child: _Preview(
                                                    key1: index == 0
                                                        ? _crushKey
                                                        : null,
                                                    key2: index == 0
                                                        ? _secretCrushKey
                                                        : null,
                                                    key3: index == 0
                                                        ? _viewProfileKey
                                                        : null,
                                                    openOtherProfileTap:
                                                        _openOtherrProfileTap,
                                                    mainScreenDelegate: widget
                                                        .mainScreenDelegate,
                                                    recommendation: state
                                                            .recommendationList[
                                                        index],
                                                    onMainPressed: () {
                                                      pageController.nextPage(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  500),
                                                          curve: Curves.ease);
                                                      final recommendation =
                                                          state
                                                              .recommendationList
                                                              .elementAt(index);
                                                      BlocProvider.of<UserBloc>(
                                                              context)
                                                          .add(
                                                        Follow(
                                                          false,
                                                          recommendation.id,
                                                          recommendation.name,
                                                        ),
                                                      );
                                                    },
                                                    onSecondaryPressed: () {
                                                      setState(() {
                                                        isProfile = false;
                                                        _controller
                                                                .upperBoundValue =
                                                            secretUpperBoundValue;
                                                        _controller
                                                                .halfBoundValue =
                                                            secretHalfBoundValue;
                                                      });
                                                      _controller.animateTo(
                                                          to: _controller
                                                              .halfBound);
                                                    },
                                                  ),
                                                );
                                              } else {
                                                return LastRecommendationPage();
                                              }
                                            }
                                          },
                                        ),
                                        appBar(myId, state),
                                      ],
                                    ),
                                    upperLayer: currentProfilesIndex <
                                            state.recommendationList.length
                                        ? Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topRight:
                                                      Radius.circular(24.0),
                                                  topLeft:
                                                      Radius.circular(24.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 20.0,
                                                  color: Colors.black12,
                                                ),
                                              ],
                                            ),
                                            child: state.recommendationList
                                                    .isNotEmpty
                                                ? isProfile
                                                    ? OtherProfile(
                                                        hideMe: () async {
                                                          _controller
                                                              .collapse();
                                                        },
                                                        recommendation: state
                                                                .recommendationList[
                                                            currentProfilesIndex],
                                                        scrollController:
                                                            _profileScrollController,
                                                        mainScreenDelegate: widget
                                                            .mainScreenDelegate,
                                                        onCrushBtnPressed: () {
                                                          final recommendation = state
                                                              .recommendationList
                                                              .elementAt(
                                                                  currentProfilesIndex);
                                                          BlocProvider.of<
                                                                      UserBloc>(
                                                                  context)
                                                              .add(
                                                            Follow(
                                                              false,
                                                              recommendation.id,
                                                              recommendation
                                                                  .name,
                                                            ),
                                                          );
                                                        },
                                                        onSecreteBtnCrushPressed:
                                                            () {
                                                          setState(() {
                                                            isProfile = false;
                                                            _controller
                                                                    .upperBoundValue =
                                                                secretUpperBoundValue;
                                                            _controller
                                                                    .halfBoundValue =
                                                                secretHalfBoundValue;
                                                          });
                                                          _controller.animateTo(
                                                              to: _controller
                                                                  .halfBound);
                                                        },
                                                      )
                                                    : SecretCrushPage(
                                                        scrollController:
                                                            _secretCrushScrollController,
                                                        expanded:
                                                            _controller.expand,
                                                        onButtonPressed: () {
                                                          print('collapsed');
                                                          _controller
                                                              .collapse();
                                                          pageController.nextPage(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      400),
                                                              curve:
                                                                  Curves.ease);
                                                          final recommendation = state
                                                              .recommendationList
                                                              .elementAt(
                                                                  currentProfilesIndex);
                                                          BlocProvider.of<
                                                                      UserBloc>(
                                                                  context)
                                                              .add(Follow(
                                                            true,
                                                            recommendation.id,
                                                            recommendation.name,
                                                          ));
                                                        },
                                                        collapsed: () =>
                                                            _controller
                                                                .animateTo(
                                                          to: _controller
                                                              .halfBound,
                                                        ),
                                                      )
                                                : Container(),
                                          )
                                        : Container(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
            ),
          ),
          CircularAnimation(
            offset: Offset(rippleStartX, rippleStartY),
            animation: _searchAnimation,
            child: SearchUser(myId, false, _onSearchClosed),
          ),
        ],
      ),
    );
  }

  _openOtherrProfileTap() async {
    setState(() {
      isProfile = true;
      _controller.upperBoundValue = upperBoundValue;
      _controller.halfBoundValue = halfBoundValue;
    });
    _controller.halfExpand();
  }

  Widget body(appBar) {
    print('Body');
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: Stack(
        children: <Widget>[
          BlocListener(
            bloc: navigationBloc,
            listener: (context, state) {
              if (state is UpdatePreview) {
                pageController.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.easeInOut);
              }
            },
            child: BlocListener<UserBloc, UserState>(
              condition: (prev, cur) =>
                  cur is ErrorInFollowing ||
                  cur is FollowedSuccessfully ||
                  cur is fetchSuccefully,
              listener: (context, userState) {
                print('User Loading... $userState');
                if (userState is fetchSuccefully) myId = userState.user.id;

                if (userState is ErrorInFollowing) {
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                          "Something went wrong when following , try again..",
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red,
                    ),
                  );
                }

                if (userState is FollowedSuccessfully) {
                  print('here');
                  setState(() {
                    userState.isSecret
                        ? bloc.add(SecretCrushUser(
                            userState.otherId, userState.followResponse))
                        : bloc.add(CrushUser(
                            userState.otherId, userState.followResponse));
                  });

                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (userState.followResponse.isDate ?? false) {
                      _showHasCrushDialog(context, userState);
                    }
                  });
                }
              },
              child:
                  false // TODO: this condition need should replaced with the commented condition below
//              myId.isEmpty
                      ? Container()
                      : BlocProvider(
                          builder: (_) => bloc,
                          child: BlocBuilder(
                            bloc: bloc,
                            builder: (context, LandingState state) {
                              if (state.errorGettingRecommendations ==
                                  NO_ERROR) {
                                return errorLoadingRecommendationsView();
                              }
                              return Scaffold(
                                key: _scaffoldKey,
                                body: RubberBottomSheet(
                                  headerHeight: 0,
                                  scrollController: isProfile
                                      ? _profileScrollController
                                      : _secretCrushScrollController,
                                  animationController: _controller,
                                  lowerLayer: Stack(
                                    children: <Widget>[
                                      PreloadPageView.builder(
                                        preloadPagesCount: 10,
                                        controller: pageController,
                                        scrollDirection: Axis.vertical,
                                        itemCount: !state.isLoading
                                            ? state.recommendationList.length
                                            : 1,
                                        onPageChanged: (index) {
                                          setState(() {
                                            currentProfilesIndex = index;
                                          });
                                        },
                                        physics: state.isLoading
                                            ? NeverScrollableScrollPhysics()
                                            : null,
                                        itemBuilder: (context, index) {
                                          return state.isLoading
                                              ? getRecommendationShimmer()
                                              : GestureDetector(
                                                  onDoubleTap: () {
                                                    _openOtherrProfileTap();
                                                  },
                                                  child: _Preview(
                                                    key1: null,
                                                    key2: null,
                                                    key3: null,
                                                    openOtherProfileTap:
                                                        _openOtherrProfileTap,
                                                    mainScreenDelegate: widget
                                                        .mainScreenDelegate,
                                                    recommendation: state
                                                            .recommendationList[
                                                        index],
                                                    onMainPressed: () {
                                                      pageController.nextPage(
                                                          duration: Duration(
                                                              milliseconds:
                                                                  400),
                                                          curve: Curves.ease);
                                                      final recommendation =
                                                          state
                                                              .recommendationList
                                                              .elementAt(index);
                                                      BlocProvider.of<UserBloc>(
                                                              context)
                                                          .add(
                                                        Follow(
                                                          false,
                                                          recommendation.id,
                                                          recommendation.name,
                                                        ),
                                                      );
                                                    },
                                                    onSecondaryPressed: () {
                                                      setState(() {
                                                        isProfile = false;
                                                        _controller
                                                                .upperBoundValue =
                                                            secretUpperBoundValue;
                                                        _controller
                                                                .halfBoundValue =
                                                            secretHalfBoundValue;
                                                      });
                                                      _controller.animateTo(
                                                          to: _controller
                                                              .halfBound);
                                                    },
                                                  ),
                                                );
                                        },
                                      ),
                                      appBar(myId, state),
                                    ],
                                  ),
                                  upperLayer: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(24.0),
                                          topLeft: Radius.circular(24.0)),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 20.0,
                                          color: Colors.black12,
                                        ),
                                      ],
                                    ),
                                    child: state.recommendationList.isNotEmpty
                                        ? isProfile
                                            ? OtherProfile(
                                                hideMe: () async {
                                                  _controller.collapse();
                                                },
                                                recommendation:
                                                    state.recommendationList[
                                                        currentProfilesIndex],
                                                scrollController:
                                                    _profileScrollController,
                                                mainScreenDelegate:
                                                    widget.mainScreenDelegate,
                                                onCrushBtnPressed: () {
                                                  final recommendation = state
                                                      .recommendationList
                                                      .elementAt(
                                                          currentProfilesIndex);
                                                  BlocProvider.of<UserBloc>(
                                                          context)
                                                      .add(
                                                    Follow(
                                                      false,
                                                      recommendation.id,
                                                      recommendation.name,
                                                    ),
                                                  );
                                                },
                                                onSecreteBtnCrushPressed: () {
                                                  setState(() {
                                                    isProfile = false;
                                                    _controller
                                                            .upperBoundValue =
                                                        secretUpperBoundValue;
                                                    _controller.halfBoundValue =
                                                        secretHalfBoundValue;
                                                  });
                                                  _controller.animateTo(
                                                      to: _controller
                                                          .halfBound);
                                                },
                                              )
                                            : SecretCrushPage(
                                                scrollController:
                                                    _secretCrushScrollController,
                                                expanded: _controller.expand,
                                                onButtonPressed: () {
                                                  _controller.collapse();

                                                  final recommendation = state
                                                      .recommendationList
                                                      .elementAt(
                                                          currentProfilesIndex);
                                                  BlocProvider.of<UserBloc>(
                                                          context)
                                                      .add(Follow(
                                                    true,
                                                    recommendation.id,
                                                    recommendation.name,
                                                  ));
                                                },
                                                collapsed: () =>
                                                    _controller.animateTo(
                                                  to: _controller.halfBound,
                                                ),
                                              )
                                        : Container(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
            ),
          ),
          CircularAnimation(
            offset: Offset(rippleStartX, rippleStartY),
            animation: _searchAnimation,
            child: SearchUser(myId, false, _onSearchClosed),
          ),
        ],
      ),
    );
  }

  Widget errorLoadingRecommendationsView() {
    return GestureDetector(
      onTap: () {
        bloc.add(GetRecommendations());
      },
      child: Container(
        color: white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Couldn\'t load recommendations',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: darkBlue,
                fontSize: 26,
              ),
            ),
            TopPadding(24.0),
            Text(
              'Tap to refresh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: lightGrey,
                fontSize: 21,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSearchTap(TapUpDetails details) {
    setState(() {
      rippleStartX = details.globalPosition.dx;
      rippleStartY = details.globalPosition.dy;
      _searchAnimController.forward();
      isInSearchMode = true;
    });
  }

  void _onSearchClosed() {
    setState(() {
      _searchAnimController.reverse();
      isInSearchMode = false;
    });
  }

  Widget getRecommendationShimmer() {
    final height = screenSize.height / 11.2;
    final width = screenSize.width / 2.5;

    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(screenSize.height / 33.83),
            child: Column(
              children: <Widget>[
                Container(
                  width: width * 2,
                  height: height,
                  child: FlareActor(
                    "lib/Fonts/Name.flr",
                    fit: BoxFit.fitWidth,
                    animation: 'Name',
                  ),
                ),
                Container(
                  width: width,
                  height: height / 2,
                  child: FlareActor(
                    "lib/Fonts/Name.flr",
                    fit: BoxFit.fitWidth,
                    animation: 'Name',
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: width,
                height: height,
                child: FlareActor(
                  "lib/Fonts/Crush.flr",
                  fit: BoxFit.fitWidth,
                  animation: 'Untitled',
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Container(
                width: width,
                height: height * 1,
                child: FlareActor(
                  "lib/Fonts/SecretCrush.flr",
                  fit: BoxFit.fitWidth,
                  animation: 'SecretCrush',
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height / 11.85,
          )
        ],
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown,
    );
  }
}

class _Preview extends StatelessWidget {
  final Function onMainPressed;
  final Function onSecondaryPressed;
  final Function openOtherProfileTap;
  final Recommendation recommendation;
  final MainScreenDelegate mainScreenDelegate;
  final GlobalKey key1;
  final GlobalKey key2;
  final GlobalKey key3;

  const _Preview({
    Key key,
    this.onMainPressed,
    this.onSecondaryPressed,
    this.openOtherProfileTap,
    @required this.recommendation,
    this.mainScreenDelegate,
    this.key1,
    this.key2,
    this.key3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: height,
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/placeholder/landing_image.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    placeholder: kTransparentImage,
                    image: recommendation.profilePhoto),
              ),
              Center(
                child: Showcase.withWidget(
                  height: height,
                  width: width * 0.5,
                  disableAnimation: true,
                  container: Text(
                    'Double Tap to View Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  key: key3 ?? GlobalKey(),
                  shapeBorder: CircleBorder(),
                  child: CircleAvatar(
                    radius: width * 0.1,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(size.height / 33.83),
            child: PreviewInformation(
              recommendation: recommendation,
              openOtherProfileTap: openOtherProfileTap,
            ),
          ),
          recommendation.isCrush ?? false
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: width,
                  child: PreviewButton(
                    text: 'Message',
                    onPressed: () {
                      mainScreenDelegate.openChatPage(
                        recommendation.orignallySecret,
                        recommendation.name,
                        recommendation.id,
                        false,
                        recommendation.presentlySecret,
                        recommendation.profilePhoto,
                      );
                    },
                  ),
                )
              : recommendation.isSecretCrush ?? false
                  ? Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.maxFinite,
                      child: PreviewButton(
                        text: 'Secret Message',
                        onPressed: () {
                          mainScreenDelegate.openChatPage(
                            recommendation.presentlySecret,
                            recommendation.name,
                            recommendation.id.toString(),
                            false,
                            recommendation.presentlySecret,
                            recommendation.profilePhoto,
                          );
                        },
                      ),
                    )
                  : PreviewButtons(
                      onMainPressed: onMainPressed,
                      onSecondaryPressed: onSecondaryPressed,
                      key1: key1 ?? GlobalKey(),
                      key2: key2 ?? GlobalKey(),
                    ),
          SizedBox(
            height: size.height / 50,
            // height: size.height / 13.53,
          ),
          Column(
            children: [
              SizedBox(
                height: size.height / 40,
                child: FlareActor(
                  'lib/Fonts/scroll_icon.flr',
                  fit: BoxFit.contain,
                  animation: 'Untitled',
                ),
              ),
              Text(
                'Scroll to see next profile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width / 30,
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class PreviewInformation extends StatelessWidget {
  final Recommendation recommendation;
  final Function openOtherProfileTap;
  const PreviewInformation({
    Key key,
    this.recommendation,
    this.openOtherProfileTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('recommendation name ${recommendation.name}');
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: size.width * 0.75, minWidth: 0),
              child: GestureDetector(
                onDoubleTap: openOtherProfileTap,
                child: ShadowText(
                  recommendation.name == null
                      ? ''
                      : recommendation.name.capitalize(),
                  maxLines: 1,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            ShadowText(
              ", " + recommendation.age.toString(),
              style: TextStyle(
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        Divider(
          height: 4.0,
          color: Colors.transparent,
        ),
        ShadowText(
          recommendation.university != null
              ? recommendation.university.capitalize()
              : '',
          style: TextStyle(
            fontSize: size.height / 43.11,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class PreviewButtons extends StatelessWidget {
  final Function onMainPressed;
  final Function onSecondaryPressed;
  final GlobalKey key1;
  final GlobalKey key2;

  PreviewButtons({
    Key key,
    this.onMainPressed,
    this.onSecondaryPressed,
    this.key1,
    this.key2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Showcase.withWidget(
              shapeBorder: CircleBorder(),
              key: key1,
              height: size.height,
              width: size.width,
              container: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: curiousBlue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width / 40),
                          ),
                        ),
                        width: size.width / 2.1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.003,
                            bottom: size.height * 0.003,
                            left: size.width / 20,
                            right: size.width / 20,
                          ),
                          child: Text(
                            'Confess openly to your Crush',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width / 31,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.001,
                        // child: SvgPicture.asset('assets/icons/intro_arrow_down.svg'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height / 19, left: size.width / 4.5),
                    child: SizedBox(
                      height: size.height / 40,
                      child:
                          SvgPicture.asset('assets/icons/intro_arrow_down.svg'),
                    ),
                  ),
                ],
              ),
              // animationDuration: Duration(milliseconds: 500),
              textColor: Colors.white,
              showcaseBackgroundColor: curiousBlue,
              child: PreviewButton(
                text: 'Crush',
                onPressed: onMainPressed,
              ),
            ),
            Showcase.withWidget(
              shapeBorder: CircleBorder(),
              key: key2,
              height: size.height,
              width: size.width * 0.45,
              container: Stack(
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: curiousBlue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(size.width / 40),
                          ),
                        ),
                        width: size.width / 2.3,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: size.height * 0.003,
                            bottom: size.height * 0.003,
                            left: size.width / 35,
                            right: size.width / 35,
                          ),
                          child: Text(
                            'Keep your Crush a secret',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.width / 29,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.00001,
                        // child: SvgPicture.asset('assets/icons/intro_arrow_down.svg'),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.height / 19, left: size.width / 5),
                    child: SizedBox(
                      height: size.height / 40,
                      child:
                          SvgPicture.asset('assets/icons/intro_arrow_down.svg'),
                    ),
                  ),
                ],
              ),
              // animationDuration: Duration(milliseconds: 500),
              textColor: Colors.white,
              showcaseBackgroundColor: curiousBlue,
              child: PreviewButton(
                text: 'Secret Crush',
                secondary: true,
                onPressed: onSecondaryPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PreviewButton extends StatelessWidget {
  final String text;
  final bool secondary;
  final Function onPressed;
  final bool isDate;
  final bool isCrushee;
  final bool isLoading;

  const PreviewButton({
    Key key,
    this.text,
    this.secondary = false,
    this.onPressed,
    this.isDate = false,
    this.isCrushee = false,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final height = size.height / 12;
    final width = size.width / 2.5;
    return BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
      //locationButtonColor
      /* strokeWidth: 2,
          radius: width,
          width: width,
          height: height,

          gradient:
              isDate ? dateGradient : isCrushee ? crusheeGradient : appGradient,*/
      if (secondary)
        return GradientContainerBorder(
          height: height,
          width: width,
          strokeWidth: 2,
          radius: width,
          onPressed: () {},
          gradient: sCrushGradient,
          child: FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width),
            ),
            onPressed: onPressed,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ShadowText(
                    text,
                    style: TextStyle(
                      fontSize: size.height / 50.75,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Visibility(
                    visible: isLoading,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(white)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      else
        return Container(
          width: text == "Crush" ? width : size.width,
          height: height,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  color: Colors.black26,
                  offset: Offset(0, 2),
                )
              ],
              gradient: text == "Crush" ? null : messageGradient,
              borderRadius: BorderRadius.circular(width)),
          child: FlatButton(
            onPressed: () {
              onPressed();
            },
            color: text == "Crush" ? pink : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: size.width / 25,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Visibility(
                    visible: isLoading,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.0,
                          valueColor: new AlwaysStoppedAnimation<Color>(white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
    });
  }
}

class SecretCrushPage extends StatefulWidget {
  final ScrollController scrollController;
  final Function expanded;
  final Function collapsed;
  final Function onButtonPressed;

  const SecretCrushPage(
      {Key key,
      this.scrollController,
      this.expanded,
      this.collapsed,
      this.onButtonPressed})
      : super(key: key);

  @override
  _SecretCrushPageState createState() => _SecretCrushPageState();
}

class _SecretCrushPageState extends State<SecretCrushPage> {
  GlobalKey<CustomExpansionTileState> key = GlobalKey();
  bool isExpanded = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => BlocProvider.of<LandingBloc>(context).add(GetCountries()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return BlocBuilder(
      bloc: BlocProvider.of<LandingBloc>(context),
      builder: (BuildContext context, LandingState state) {
//        print('the landing state is $state');
        List<RelatedNames> names = [];
        for (Country country in state.countries) {
          if (country.isSelected)
            for (RelatedNames name in country.relatedNames) {
              if (name == state.selectedName) {
                names.add(RelatedNames(name: name.name, isSelected: true));
              } else
                names.add(name);
            }
        }
        if (state.openListOfSecretCrushNames) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => key.currentState.expand());
          BlocProvider.of<LandingBloc>(context).add(ResetOpenAfterFilter());
        }
//        print('isExpanded is $isExpanded');
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: ListView(
            controller: widget.scrollController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(height: 32.0),
              Text(
                'Select your Anonymous \nname',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F2F5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Theme(
                  data: ThemeData(
                    dividerColor: Colors.transparent,
                  ),
                  child: CustomExpansionTile(
                    key: key,
                    headerBackgroundColor: Colors.transparent,
                    iconColor: !isExpanded ? accent : Colors.transparent,
                    children: List.generate(
                      names.length,
                      (index) {
                        return Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<LandingBloc>(context).add(
                                  ChangeSelectedAnonymousName(names[index]));
                              key.currentState.collapse();
                              widget.collapsed();
                              setState(() {
                                isExpanded = false;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    names[index].name,
                                    style: TextStyle(
                                      color: accent,
                                      fontSize: 16,
                                    ),
                                  ),
                                  names[index].isSelected
                                      ? Icon(
                                          Icons.check,
                                          color: accent,
                                          size: 20,
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    onExpansionChanged: (isExpanded) {
                      setState(() {
                        this.isExpanded = isExpanded;
                      });
                      if (isExpanded) {
                        widget.expanded();
                      } else {
                        widget.collapsed();
                      }
                    },
                    title: !isExpanded
                        ? Text(
                            state.selectedName != null
                                ? state.selectedName.name
                                : '',
                            style: TextStyle(
                              color: accent,
                              fontSize: 18,
                            ),
                          )
                        : SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: 80,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GradientContainerBorder(
                      radius: 300,
                      height: 60,
                      strokeWidth: state.countries[index].isSelected ? 1.0 : 0,
                      width: 60,
                      gradient: appGradient,
                      child: Image.asset(
                        state.countries[index].image,
                      ),
                      onPressed: () {
                        BlocProvider.of<LandingBloc>(context).add(
                            GetFilteredCountries([state.countries[index].id]));
                      },
                    );
                  },
                  itemCount: state.countries.length,
                ),
              ),
              GestureDetector(
                onTap: widget.onButtonPressed,
                child: Container(
                  //margin: EdgeInsets.symmetric(vertical: 10),
                  width: screenSize.width,
                  height: screenSize.height / 14.5,
                  decoration: BoxDecoration(
                    // gradient: appGradient,
                    color: pink,
                    borderRadius:
                        BorderRadius.circular(screenSize.width / 12.5),
                  ),
                  child: Center(
                      child: AutoSizeText(
                    "Secret Crush",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class OtherProfile extends StatefulWidget {
  final ScrollController scrollController;
  final Recommendation recommendation;
  final Function onSecreteBtnCrushPressed;
  final Function onCrushBtnPressed;
  final MainScreenDelegate mainScreenDelegate;
  final Function hideMe;

  const OtherProfile({
    Key key,
    @required this.recommendation,
    this.scrollController,
    this.onCrushBtnPressed,
    this.onSecreteBtnCrushPressed,
    this.mainScreenDelegate,
    this.hideMe,
  }) : super(key: key);

  @override
  _OtherProfileState createState() => _OtherProfileState();
}

class _OtherProfileState extends State<OtherProfile> {
  final LandingBloc _bloc = LandingBloc();
  int currentIndex = 0;
  Size screenSize;
  final _imagesPageController = PageController();

  @override
  void initState() {
//    _bloc.add(GetOtherPreview(widget.recommendation.id));
    _imagesPageController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
//    return Container();
//    return BlocBuilder(
//      bloc: _bloc,
//      builder: (context, LandingState state) {
//         todo: check error
    return
//          !state.isLoadingOtherPreview ?
        WillPopScope(
      onWillPop: () async {
        widget.hideMe();
        return false;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenSize.width / 12.5),
        child: ListView(
          padding: EdgeInsets.all(0),
          physics: NeverScrollableScrollPhysics(),
          controller: widget.scrollController,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      widget.hideMe();
                    },
                    child: Container(height: 40, color: Colors.transparent),
                  ),
                  Text(
                    widget.recommendation.name +
                        ", " +
                        widget.recommendation.age.toString(),
                    style: TextStyle(
                      color: darkBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 21.0,
                    ),
                  ),
                  SizedBox(
                    height: screenSize.height / 40,
                  ),
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.recommendation.profilePhoto),
                    radius: screenSize.width / 10,
                  ),
                  SizedBox(
                    height: screenSize.height / 40,
                  ),
                  widget.recommendation.university != null &&
                          widget.recommendation.university != 'N/A'
                      ? Text(
                          widget.recommendation.university.capitalize(),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.grey,
                          ),
                        )
                      : Container(),
                  widget.recommendation.greekHouse != null &&
                          widget.recommendation.greekHouse != 'N/A'
                      ? Text(
                          widget.recommendation.greekHouse,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(color: Colors.grey),
                        )
                      : Container(),
                  SizedBox(
                    height: screenSize.height / 40,
                  ),
                  AnimatedCount(
                    count: widget.recommendation.followCount,
                    duration: Duration(milliseconds: 900),
                  ),
                  Text(
                    'Crush Count'.toUpperCase(),
                    style: TextStyle(color: gray, fontSize: 12.0),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenSize.height / 27,
            ),
            widget.recommendation.photos != null &&
                    widget.recommendation.photos.isNotEmpty
                ? ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: screenSize.height * 0.5,
                        maxHeight: screenSize.height * 0.7),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 30),
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius:
                            BorderRadius.circular(screenSize.width / 12.5),
                      ),
                      child: Stack(
                        children: <Widget>[
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: _imagesPageController,
                            itemCount: widget.recommendation.photos.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        widget.recommendation.photos[index]),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      screenSize.width / 12.5),
                                ),
                              );
                            },
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: DotsIndicator(
                              dotsCount: widget.recommendation.photos.length,
                              position: _imagesPageController.hasClients
                                  ? _imagesPageController.page
                                  : 0,
                              decorator: DotsDecorator(
                                color: inactiveDot,
                                activeColor: pink,
                                spacing:
                                    EdgeInsets.all(screenSize.width / 85.5),
                                size: Size.square(screenSize.height / 66.7),
                                activeSize: Size(screenSize.width / 12.5,
                                    screenSize.height / 66.7),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 32.0),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

class CrushButton extends StatelessWidget {
  final bool primary;
  final bool isLoading;
  final String text;
  final Function onPressed;

  const CrushButton(
      {Key key,
      this.text,
      this.primary,
      this.onPressed,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = size.height / 16;
    final width = size.width / 2.5;

    return AnimatedButton(
        child: primary
            ? Container(
                width: width,
                height: height,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(width)),
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    onPressed();
                  },
                  color: pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width)),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                              fontSize: size.height / 50.75,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Visibility(
                          visible: isLoading,
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Container(
                              width: 12.0,
                              height: 12.0,
                              child: CircularProgressIndicator(
                                  strokeWidth: 1.0,
                                  valueColor:
                                      new AlwaysStoppedAnimation<Color>(white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : GradientContainerBorder(
                height: height,
                width: width,
                strokeWidth: 1,
                radius: width,
                onPressed: () {},
                gradient: sCrushGradient,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width)),
                  onPressed: onPressed,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AutoSizeText(
                          text,
                          style: TextStyle(
                              fontSize: size.width / 25,
                              color: darkBlue,
                              fontWeight: FontWeight.w600),
                        )
                        /* Visibility(
                    visible: userState is LoadingFollow && userState.isSecret,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Container(
                        width: 12.0,
                        height: 12.0,
                        child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: new AlwaysStoppedAnimation<Color>(white)),
                      ),
                    ),
                  )*/
                      ],
                    ),
                  ),
                ),
              ));
  }

  /*GradientContainerBorder(
              strokeWidth: 2,
              radius: width,
              width: width,
              height: height,
              gradient: appGradient,
              child: Center(child: _getText),
              onPressed: onPressed,
            ),*/

  Text get _getText => Text(
        text,
        style: TextStyle(
          color: primary ? white : darkGrey,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      );
}

class MultiLineText extends StatelessWidget {
  final Text text;
  final double height;

  const MultiLineText({Key key, this.text, this.height = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        width: MediaQuery.of(context).size.width / 2,
        child: Center(child: text));
  }
}
