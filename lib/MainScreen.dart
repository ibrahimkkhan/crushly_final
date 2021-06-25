import 'src/screens/Chat_List.dart';
import 'src/screens/Chat_Page.dart';
import 'src/screens/LandingPage.dart';
import 'src/screens/my_profile/my_profile_page.dart';
import 'src/SharedPref/SharedPref.dart';
import 'src/models/recommendation.dart';
import 'src/utils/main_screen_delegate.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> implements MainScreenDelegate {
  final PageController controller =
      PageController(keepPage: true, initialPage: 1);

  bool isChatPage = false;

  late bool originallySecret;
  late String otherName;
  late String otherImage;
  late String otherID;
  late bool isFromFolloweePage;
  late bool presentlySecret;

  @override
  void initState() {
    controller.addListener(
      () {
        if (controller.page == 1) {
          setState(() {
            isChatPage = false;
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: controller,
      children: <Widget>[
        MyProfilePage(
          () => controller.nextPage(
              duration: Duration(milliseconds: 400), curve: Curves.easeInOut),
          key: PageStorageKey('my_profile'),
        ),
        ShowCaseWidget(
          builder: Builder(
            builder: (context) => LandingPage(
              key: PageStorageKey('landing_page'),
              mainScreenDelegate: this,
            ),
          ),
          onFinish: () {
            SharedPref.pref.setIntroShown(true);
          },
        ),
        !isChatPage
            ? ChatList(
                key: PageStorageKey('chat_list'),
                followersList: [],
                mainScreenDelegate: this,
              )
            : ChatPage(
                key: PageStorageKey('chat_page'),
                originallySecret: originallySecret,
                otherID: otherID,
                otherName: otherName,
                otherImage: otherImage,
                presentlySecret: presentlySecret,
                isFromFolloweePage: isFromFolloweePage,
                mainScreenDelegate: this,
              ),
      ],
    );
  }

  @override
  void iconClicked(MainScreenIcon mainScreenIcon) {
    switch (mainScreenIcon) {
      case MainScreenIcon.PROFILE:
        controller.animateToPage(0,
            duration: Duration(milliseconds: 400), curve: Curves.ease);
        break;
      case MainScreenIcon.HOME:
        controller.animateToPage(1,
            duration: Duration(milliseconds: 400), curve: Curves.ease);
        break;
      case MainScreenIcon.MESSAGES:
        controller.animateToPage(2,
            duration: Duration(milliseconds: 400), curve: Curves.ease);
        break;
    }
  }

  @override
  void openChatPage(bool originallySecret, String otherName, String otherID,
      bool isFromFolloweePage, bool presentlySecret, String otherImage) {
    this.originallySecret = originallySecret;
    this.otherName = otherName;
    this.otherImage = otherImage;
    this.otherID = otherID;
    this.isFromFolloweePage = isFromFolloweePage;
    this.presentlySecret = presentlySecret;
    print('presently $presentlySecret this. ${this.presentlySecret}');
    setState(() {
      isChatPage = true;
    });
    controller.animateToPage(2,
        duration: Duration(milliseconds: 400), curve: Curves.ease);
  }
}
