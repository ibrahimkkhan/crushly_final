import '../blocs/Messenger_Bloc/messenger_bloc.dart';
import '../db/AppDB.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/story_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class StoryViewPage extends StatefulWidget {
  List<UserWithStory> userWithStory;

  StoryViewPage(this.userWithStory);

  @override
  _StoryViewPageState createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final storyController = StoryController();
  bool isLoading = true;
  List<LocalStory> stories = [];

  @override
  void initState() {
    getStories();

    super.initState();
  }

  getStories() async {
    await BlocProvider.of<MassengerBloc>(context)
        .appDataBase
        .getUserStories(widget.userWithStory.first.user.id)
        .then((onValue) {
      setState(() {
        stories = onValue;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0.0,
        //   title: Text(widget.userWithStory.first.user.name),
        // ),
        body: Stack(children: [
          isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : StoryView(
                  storyItems: List.generate(
                      stories.length,
                      (index) => StoryItem.pageImage(
                            url: stories[index].url,
                            imageFit: BoxFit.cover,
                            controller: storyController,
                          )),
                  onStoryShow: (s) {
                    print("Showing a story");
                  },
                  onComplete: () {
                    widget.userWithStory.removeAt(0);
                    if (widget.userWithStory.isNotEmpty) {
                      Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                              builder: (context) =>
                                  StoryViewPage(widget.userWithStory)));
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  progressPosition: ProgressPosition.top,
                  repeat: false,
                  controller: storyController,
                ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Text(
                  widget.userWithStory.first.user.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
