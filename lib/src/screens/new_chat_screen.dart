import '../screens/DateListPage.dart';
import '../screens/OpenlyFollowList.dart';
import '../screens/myFollowees_list.dart';
import '../theme/theme.dart';
import 'package:flutter/material.dart';

class NewChat extends StatefulWidget {
  final int initialIndex;
  final bool openChat;

  const NewChat(
      {Key? key, this.initialIndex = PAGE_CRUSHEE, this.openChat = false})
      : super(key: key);

  @override
  _NewChatState createState() => _NewChatState();
}

class _NewChatState extends State<NewChat> with SingleTickerProviderStateMixin {
  late TabController tabController;
  late int currentPageIndex;

  @override
  void initState() {
    currentPageIndex = widget.initialIndex;
    tabController = TabController(length: 3, vsync: this);
    tabController.index = widget.initialIndex;
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print('widget.initialIndex ${widget.initialIndex}');
    return Scaffold(
      backgroundColor: pageBackground,
      appBar: AppBar(
        backgroundColor: pageBackground,
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: pink,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height / 15),
          child: Padding(
            padding: EdgeInsets.only(top: size.height / 35.06),
            child: _TabBar(tabController),
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.only(
              top: size.height / 33.83,
              right: size.width / 17.5,
              left: size.width / 17.5),
          child: TabBarView(
            controller: tabController,
            children: [
              OpenlyFollowList(
                openChat: widget.openChat,
              ),
              DateListPage(openChat: widget.openChat),
              MyFolloweesList(openChat: widget.openChat),
            ],
          ),
        ),
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final TabController tabController;

  _TabBar(this.tabController);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width / 17.5),
      child: Container(
        height: size.height / 14.5,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width / 12.5),
            color: Colors.white),
        child: Container(
          margin: EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(Radius.circular(size.width / 7.5)),
          ),
          child: TabBar(
            controller: tabController,
            unselectedLabelColor: lightBlue,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width / 7.5),
                // gradient: appGradient,
                color: pink),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Crushee",
                    style: getTabLabelStyle(PAGE_CRUSHEE, size),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Date",
                    style: getTabLabelStyle(PAGE_DATE, size),
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Crush",
                    style: getTabLabelStyle(PAGE_CRUSH, size),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle getTabLabelStyle(int index, Size size) => TextStyle(
        fontSize: size.width / 26.78,
        color: tabController.index == index ? white : darkBlue,
      );
}

const PAGE_CRUSHEE = 0;
const PAGE_DATE = 1;
const PAGE_CRUSH = 2;
/*GradientContainerBorder(
        onPressed: () {},
        radius: size.width / 12.5,
        height: size.height / 14.5,
        strokeWidth: 1.0,
        width: MediaQuery.of(context).size.width,
        gradient: appGradient,
        child:
      ),*/
