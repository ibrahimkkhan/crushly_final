import 'dart:io';
import 'dart:typed_data';

import 'package:crushly/BLocs/StoryBloc/bloc.dart';
import 'package:crushly/BLocs/User_Bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewStoryPage extends StatefulWidget {
  final String userId;
  NewStoryPage(this.userId);

  _NewStoryPageState createState() => _NewStoryPageState();
}

class _NewStoryPageState extends State<NewStoryPage> {
  String text;
  String url;
  ByteData _image;
  bool forever = false;
  bool imagePicked = false;
  StoryBloc storyBloc;
  String imagePath;
  String result;
  static const platform = const MethodChannel('crushly.mohammad.test');

  // Future<void> retrieveLostData() async {
  //   final LostDataResponse response = await ImagePicker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     _image = response.file;

  //     setState(() {
  //       imagePicked = true;
  //     });
  //   }
  // }

  // Future _getImage() async {
  //   var image = await ImagePicker.pickImage(source: ImageSource.camera);

  //   if (image != null) {
  //     _image = image;
  //     setState(() {
  //       imagePicked = true;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) retrieveLostData();
    storyBloc = StoryBloc();
  }

  @override
  void dispose() {
    super.dispose();
    storyBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeAware = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("new story"),
      ),
      body: SingleChildScrollView(
        child: BlocListener(
          bloc: storyBloc,
          listener: (context, state) {
            if (state is AddingStorySuccess) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  "new story added",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
              BlocProvider.of<UserBloc>(context).add(UpdateProfile());
            }
            if (state is AddingStoryFailed) {
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error ?? "error ",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(children: [
                  Text("story text   "),
                  Expanded(
                    child: TextField(
                      onChanged: (t) {
                        text = t;
                      },
                    ),
                  )
                ]),
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("forever"),
                    Checkbox(
                      value: forever,
                      onChanged: (v) {
                        setState(() {
                          forever = v;
                        });
                      },
                    ),
                  ],
                ),
                Container(
                  color: Colors.blueGrey,
                  width: sizeAware.width / 0.5555,
                  height: sizeAware.height / 2.5555,
                  child: imagePicked
                      ? Image.file(
                          File.fromUri(Uri.parse(result)),
                          fit: BoxFit.cover,
                        )
                      : IconButton(
                          icon: Icon(Icons.photo),
                          onPressed: () async {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          IconButton(
                                            icon: Icon(Icons.photo_library),
                                            onPressed: () async {
                                              result =
                                                  await platform.invokeMethod(
                                                      'startEditor', "gallery");

                                              // await Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 PhotoEditor(
                                              //                     false)))
                                              //     .then((onValue) {
                                              //   if (onValue != null) {
                                              //     _image = onValue[0];
                                              //     imagePath = onValue[1];
                                              //     setState(() {
                                              //       imagePicked = true;
                                              //     });
                                              //   }
                                              // });
                                              setState(() {
                                                imagePicked = true;
                                              });
                                              Navigator.pop(context);
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.photo_camera),
                                            onPressed: () async {
                                              result =
                                                  await platform.invokeMethod(
                                                      'startEditor', "camera");
                                              // await Navigator.push(
                                              //         context,
                                              //         MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 PhotoEditor(
                                              //                     true)))
                                              //     .then((onValue) {
                                              //   if (onValue != null) {
                                              //     _image = onValue[0];
                                              //     imagePath = onValue[1];
                                              //     setState(() {
                                              //       imagePicked = true;
                                              //     });
                                              //     Navigator.pop(context);
                                              //   }
                                              // });
                                              setState(() {
                                                imagePicked = true;
                                              });
                                              Navigator.pop(context);
                                              
                                            },
                                          )
                                        ],
                                      ),
                                    ));
                          },
                        ),
                ),
                BlocBuilder(
                  bloc: storyBloc,
                  builder: (context, state) {
                    if (state is LoadingNewStory) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return RaisedButton(
                      onPressed: () async {
                        if (text != null && imagePicked) {
                          if (text.isNotEmpty) {
                            storyBloc.add(NewStory(widget.userId, text, forever,
                                imagePath, _image));
                          }
                        } else {
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                              "add a text and image",
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Text("post story"),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
