import 'package:cached_network_image/cached_network_image.dart';
import '../../blocs/User_Bloc/bloc.dart';
import '../../blocs/landingBloc/bloc.dart';
import '../../blocs/landingBloc/landing_bloc.dart';
import '../../blocs/landingBloc/landing_state.dart';
import '../../screens/my_profile/Myprofile_details.dart';
import '../../screens/my_profile/my_profile_bloc.dart';
import '../../screens/my_profile/my_profile_event.dart';
import '../../screens/my_profile/my_profile_state.dart';
import '../../screens/new_chat_screen.dart';
import '../../Widgets/paddings.dart';
import '../../theme/theme.dart';
import '../../utils/custom_icons.dart';
import '../../utils/gradient_container_border.dart';
import '../../utils/linear_gradient_mask.dart';
import '../../utils/utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

class MyProfilePage extends StatefulWidget {
  final bool forPhotoUpload;
  final Function() onForwardButtonPressed;

  MyProfilePage(
    this.onForwardButtonPressed, {
    Key? key,
    this.forPhotoUpload = false,
  }) : assert(forPhotoUpload != null);

  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with AutomaticKeepAliveClientMixin<MyProfilePage> {
  final MyProfileBloc myProfileBloc = MyProfileBloc(MyProfileState.initial());
  late ScrollController _controller;
  late Size screenSize;
  late LandingBloc _landingBloc;

  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  void dispose() {
    if (mounted && _controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    myProfileBloc.add(GetMyProfile());
    _landingBloc = LandingBloc(
        appDataBase: BlocProvider.of<UserBloc>(context).appDataBase);
    _landingBloc.add(GetProfileStatus());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    screenSize = MediaQuery.of(context).size;
    return BlocListener(
      bloc: myProfileBloc,
      listener: (context, MyProfileState state) {
        if (state.errorLoading) {
          print('Error Loading Profile State');
        }
      },
      child: BlocBuilder(
        bloc: myProfileBloc,
        builder: (context, MyProfileState state) {
          return WillPopScope(
            onWillPop: () {
              widget.onForwardButtonPressed();
              return Future.value(false);
            },
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                leading: Visibility(
                  visible: !state.isEditing,
                  child: widget.forPhotoUpload
                      ? state.user != null
                          ? state.user.photos!.length >= 3
                              ? IconButton(
                                  onPressed: () {
                                    widget.onForwardButtonPressed();
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: pink,
                                  ),
                                )
                              : Container()
                          : Container()
                      : IconButton(
                          icon: Icon(
                            Icons.settings,
                            color: darkBlue,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => MyProfileDetails(
                                  user: state.user,
                                ),
                              ),
                            );
                          },
                        ),
                ),
                centerTitle: true,
                title: Text(
                  state.user != null
                      ? capitalizeNames(state.user.name!) ?? ' '
                      : ' ',
                  maxLines: 1,
                  // overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkBlue,
                    fontSize: 16,
                  ),
                ),
                actions: <Widget>[
                  widget.forPhotoUpload
                      ? state.isEditing
                          ? FlatButton(
                              onPressed: () {
                                myProfileBloc.add(EditProfile());
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: curiousBlue,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : Padding(
                              padding:
                                  EdgeInsets.only(right: screenSize.width / 20),
                              child: IconButton(
                                icon: Icon(
                                  Icons.settings,
                                  color: darkBlue,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => MyProfileDetails(
                                        user: state.user,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                      : state.isEditing
                          ? FlatButton(
                              onPressed: () {
                                myProfileBloc.add(EditProfile());
                              },
                              child: Text(
                                'Done',
                                style: TextStyle(
                                    color: curiousBlue,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : IconButton(
                              onPressed: widget.onForwardButtonPressed,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: pink,
                              ),
                            ),
                ],
              ),
              backgroundColor: pageBackground,
              body: SafeArea(
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // appBarView(state),
                        state.user != null
                            ? Expanded(
                                child: CustomScrollView(
                                  slivers: <Widget>[
                                    userInfoView(state),
                                    userPhotosView(state),
                                  ],
                                ),
                              )
                            : Container(),
                      ],
                    ),
                    state.isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget userInfoView(MyProfileState state) {
    return SliverToBoxAdapter(
      child: Container(
        width: screenSize.width,
        padding: EdgeInsets.only(bottom: screenSize.height / 27.06),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(screenSize.width / 18.75),
            bottomRight: Radius.circular(screenSize.width / 18.75),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: screenSize.height / 30),
            GestureDetector(
              onTap: state.isEditing
                  ? () async {
                      final image = await MultiImagePicker.pickImages(
                        maxImages: 1,
                        materialOptions: MaterialOptions(
                          actionBarColor: '#454f63',
                          statusBarColor: '#454f63',
                          lightStatusBar: true,
                          startInAllView: true,
                          useDetailsView: true,
                        ),
                      );
                      if (image.isNotEmpty)
                        myProfileBloc.add(ChangeProfilePhoto(image[0]));
                    }
                  : null,
              child: Center(
                child: Container(
                  height: screenSize.height / 8,
                  width: screenSize.height / 8,
                  child: Stack(
                    children: <Widget>[
                      ClipRRect(
                        child: CachedNetworkImage(
                          imageUrl: state.user.profilePhoto!,
                          imageBuilder: (context, imageProvider) => Container(
                            height: screenSize.width / 4,
                            width: screenSize.width / 4,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ), /*
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),*/
                        ),
                      ),
                      /*CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(state.user.profilePhoto),
                        radius: screenSize.width / 8,
                      ),*/
                      // AnimatedOpacity(
                      //   opacity: state.isEditing ? 1.0 : 0.0,
                      //   duration: Duration(milliseconds: 100),
                      //   child: Align(
                      //     alignment: Alignment.topRight,
                      //     child: LinearGradientMask(
                      //       child: Icon(
                      //         Icons.mode_edit,
                      //         color: white,
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              height: state.isEditing
                  ? screenSize.height / 30
                  : screenSize.height / 70,
              duration: Duration(milliseconds: 200),
              child: state.isEditing
                  ? GestureDetector(
                      onTap: () async {
                        final image = await MultiImagePicker.pickImages(
                          maxImages: 1,
                          materialOptions: MaterialOptions(
                            actionBarColor: '#454f63',
                            statusBarColor: '#454f63',
                            lightStatusBar: true,
                            startInAllView: true,
                            useDetailsView: true,
                          ),
                        );
                        if (image.isNotEmpty)
                          myProfileBloc.add(ChangeProfilePhoto(image[0]));
                      },
                      child: Column(
                        children: <Widget>[
                          TopPadding(8.0),
                          Flexible(
                            child: Text(
                              'Change Profile Photo',
                              style: TextStyle(
                                color: curiousBlue,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ),
            TopPadding(20.0),
            state.user.university != null
                ? Container(
                    margin: EdgeInsets.only(top: screenSize.height / 80.3),
                    child: Text(
                      state.user.university!,
                      style: TextStyle(
                        color: lightBlue,
                        fontSize: screenSize.width / 26.78,
                      ),
                    ),
                  )
                : Container(),
            Visibility(
              visible: state.user.greekHouse != null &&
                  state.user.greekHouse!.isNotEmpty,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: screenSize.height / 500),
                child: Text(
                  state.user.greekHouse ?? "",
                  style: TextStyle(
                    color: lightBlue,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height / 27.06),
            Padding(
              padding: EdgeInsets.only(
                  left: screenSize.width / 6, right: screenSize.width / 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  // Dates
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NewChat(
                              initialIndex: 1,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            state.user.dateList != null
                                ? state.user.dateList!.length.toString()
                                : "0",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: darkBlue,
                              fontSize: 24.0,
                            ),
                          ),
                          TopPadding(4.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Dates'.toUpperCase(),
                                style: TextStyle(
                                  color: lightBlue,
                                  fontSize: screenSize.width / 32,
                                ),
                              ),
                              Icon(
                                Icons.lock,
                                color: lightBlue,
                                size: screenSize.width / 32,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: screenSize.width / 12.5,
                    ),
                    width: 1,
                    color: boxColor,
                    height: screenSize.height / 12,
                  ),
                  // Crush Count
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => NewChat(
                              initialIndex: 0,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            state.user.followCount != null
                                ? state.user.followCount.toString()
                                : "0",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: darkBlue,
                              fontSize: screenSize.width / 16.5,
                            ),
                          ),
                          TopPadding(4.0),
                          Text(
                            'Crush Count'.toUpperCase(),
                            style: TextStyle(
                              color: lightBlue,
                              fontSize: screenSize.width / 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            BlocBuilder(
              bloc: _landingBloc,
              builder: (context, LandingState landingState) {
                if (null == landingState ||
                    null == landingState.profileStatus) {
                  print("Null Status");
                  return Container();
                }
                int reqPhotos =
                    landingState.profileStatus.moreNumberOfRegPhotosReq;
                print('moreNumberOfRegPhotosReq $reqPhotos');
                return widget.forPhotoUpload
                    ? state.user != null
                        ? state.user.photos!.length >= reqPhotos
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(
                                    top: screenSize.height / 40),
                                child: Text(
                                  'Please upload ${reqPhotos - state.user.photos!.length} more ${reqPhotos - state.user.photos!.length == 1 ? 'photo' : 'photos'} to continue.',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: screenSize.width / 30),
                                ),
                              )
                        : Container()
                    : Container();
              },
            ),
            AnimatedContainer(
              height: state.isEditing
                  ? screenSize.height / 30
                  : screenSize.height / 9,
              duration: Duration(milliseconds: 200),
              child: Column(
                children: <Widget>[
                  TopPadding(screenSize.height / 30),
                  Visibility(
                    visible: !state.isEditing,
                    child: Flexible(
                      child: RaisedButton(
                        padding: EdgeInsets.only(
                          top: screenSize.width / 28,
                          left: screenSize.width / 10,
                          right: screenSize.width / 10,
                          bottom: screenSize.width / 28,
                        ),
                        color: curiousBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          myProfileBloc.add(EditProfile());
                        },
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenSize.height / 60,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _selectPictures(MyProfileState state) async {
//    final images = await FilePicker.getMultiFile(type: FileType.image);
//    if (images != null) {}

    final images = await MultiImagePicker.pickImages(
      maxImages: (6 - state.user.photos!.length) as int,
      materialOptions: MaterialOptions(
        actionBarColor: '#454f63',
        statusBarColor: '#454f63',
        lightStatusBar: true,
        startInAllView: true,
        useDetailsView: true,
      ),
    );
    if (images != null && images.isNotEmpty) {
      myProfileBloc.add(ChangeImages(images));
      _landingBloc.add(GetProfileStatus());
    }
  }

  Widget userPhotosView(MyProfileState state) {
    print('Photos: ${state.user.photos!.length}');
    return state.user.photos != null
        ? SliverPadding(
            padding: EdgeInsets.symmetric(
                horizontal: screenSize.width / 15.625,
                vertical: screenSize.height / 33.83),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 4 / 5,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  print('photo index: $index');
                  return Stack(
                    children: <Widget>[
                      /*Container(
                            margin: EdgeInsets.all(
                              index >= state.user.photos.length &&
                                      !state.isEditing
                                  ? 1.0
                                  : 0.0,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  state.isEditing ? white : Colors.transparent,
                              image: index < state.user.photos.length
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                        state.user.photos[index].url,
                                      ),
                                      onError: (exception, stackTrace) {
                                        print(
                                            'Error Downloading Image from this url; ${state.user.photos[index].url} this exception; $exception');
                                      },
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(
                                  screenSize.height / 81.2),
                            ),
                            child: index >= state.user.photos.length &&
                                    state.isEditing
                                ? Center(
                                    child: LinearGradientMask(
                                      child: Icon(
                                        CustomIcons.ic_add_photo,
                                        color: white,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ),
                          */
                      //old CachedNetworkImageProvider was giving error while downloading photo from server.
                      //new one have placeholder and error widget in case of need.
                      Padding(
                        padding: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 4.0),
                        child: GradientContainerBorder(
                          onPressed: () {
                            if (index >= state.user.photos!.length &&
                                state.isEditing) _selectPictures(state);
                          },
                          radius: screenSize.height / 81.2,
                          height: screenSize.height,
                          strokeWidth: 0.0,
                          width: screenSize.width,
                          gradient: state.isEditing
                              ? appGradient
                              : transparentGradient,
                          child: Container(
                            margin: EdgeInsets.all(
                              index >= state.user.photos!.length &&
                                      !state.isEditing
                                  ? 1.0
                                  : 0.0,
                            ),
                            decoration: BoxDecoration(
                              color: state.isEditing &&
                                      state.user.photos!.length < 6
                                  ? white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(
                                  screenSize.height / 81.2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  screenSize.height / 81.2),
                              child: index >= state.user.photos!.length &&
                                      state.isEditing &&
                                      state.user.photos!.length < 6
                                  ? Center(
                                      child: LinearGradientMask(
                                        child: Icon(
                                          CustomIcons.ic_add_photo,
                                          color: white,
                                        ),
                                      ),
                                    )
                                  : index >= state.user.photos!.length
                                      ? Container()
                                      : CachedNetworkImage(
                                          imageUrl:
                                              state.user.photos![index].url,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ), /*
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),*/
                                        ),
                            ),
                          ),
                        ),
                      ),
                      AnimatedOpacity(
                        opacity:
                            state.isEditing && state.user.photos!.length > index
                                ? 1
                                : 0,
                        duration: Duration(milliseconds: 200),
                        child: Align(
                            alignment: Alignment.topRight,
                            child: ClipOval(
                              child: Material(
                                color: Colors.white, // button color
                                child: InkWell(
                                  splashColor: Colors.red, // inkwell color
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: LinearGradientMask(
                                      child: Icon(
                                        Icons.close,
                                        size: 20,
                                        color: white,
                                      ),
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            )
                            // Icon(
                            //   Icons.close,
                            //   color: dividerColor3,
                            // ),
                            ),
                      ),
                    ],
                  );
                },
                childCount: state.isEditing
                    ? state.user.photos!.length + 1
                    : state.user.photos!.length == 6
                        ? 6
                        : state.user.photos!.length + 1,
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
          );
  }

  Widget errorLoadingView() {
    return GestureDetector(
      onTap: () {
        myProfileBloc.add(GetMyProfile());
      },
      child: Container(
        color: white,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Couldn\'t load your profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: darkBlue,
                fontSize: 24,
              ),
            ),
            TopPadding(24.0),
            Text(
              'Tap to refresh',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none,
                color: lightGrey,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
