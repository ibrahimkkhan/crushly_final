import 'dart:io';

import '../../theme/theme.dart';
import '../../utils/custom_icons.dart';
import '../../utils/gradient_container_border.dart';
import '../../utils/linear_gradient_mask.dart';
import '../../utils/utils.dart';
//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'signup_page.dart';

class UploadPhotosView extends StatefulWidget {
  final Function(List<Asset>) onPhotosChanged;
  final Function(int) onPrimaryIndexChanged;
  final List<Asset> photoList;
  final int primaryIndex;

  UploadPhotosView(
      {required this.photoList,
      required this.primaryIndex,
      required this.onPhotosChanged,
      required this.onPrimaryIndexChanged});

  @override
  _UploadPhotosViewState createState() => _UploadPhotosViewState();
}

class _UploadPhotosViewState extends State<UploadPhotosView> {
  List<Asset> photoList = [];
  late int primaryIndex;
  late Size screenSize;

  @override
  void initState() {
    photoList.addAll(widget.photoList);
    primaryIndex = widget.primaryIndex;
    print('primaryIndex = $primaryIndex');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    value = 1;
    screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width / 12.5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Let\'s upload some photos!',
            style: TextStyle(
              color: darkBlue,
              fontSize: screenSize.width / 12.5,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontFamily: Fonts.SOMANTIC_FONT,
            ),
          ),
          SizedBox(height: screenSize.height / 27.06),
          /* GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 4 / 5,
            children: List.generate(
                photoList.length == 4 ? 4 : photoList.length + 1, (index) {
              return Padding(
                padding: EdgeInsets.all(screenSize.width / 83.2),
                child: GradientContainerBorder(
                  onPressed: () {
                    print('index is $index, length is ${photoList.length}');
                    if (index == photoList.length) {
                      _selectPictures();
                    } else if (index < photoList.length) {
                      _showPictureOptionsBottomSheet(index);
                    } else {
                      Fluttertoast.showToast(
                        msg:
                            'Please fill previous images before continuing with this image',
                      );
                    }
                  },
                  radius: screenSize.width / 37.5,
                  height: screenSize.height / 6.76,
                  strokeWidth: 1.0,
                  width: MediaQuery.of(context).size.width,
                  gradient: appGradient,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                        Radius.circular(screenSize.width / 37.5)),
                    child: Container(
                      margin:
                          EdgeInsets.all(photoList.length > index ? 0.0 : 1.0),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenSize.width / 37.5))),
                      child: photoList.length > index
                          ? Stack(
                              fit: StackFit.expand,
                              children: <Widget>[
                                AssetThumb(
                                  asset: photoList[index],
                                  width: screenSize.width.toInt(),
                                  height: screenSize.height.toInt(),
                                ),
                                Visibility(
                                  visible: index == primaryIndex,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: screenSize.width,
                                    color: Color(0x40000000),
                                    child: Text(
                                      'Primary',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : LinearGradientMask(
                              child: Icon(
                                CustomIcons.ic_add_photo,
                                color: white,
                              ),
                            ),
                    ),
                  ),
                ),
              );
            }),
          ),*/
          Container(
            height: screenSize.height / 2.12,
            width: screenSize.height / 2.12,
            child: GridView.builder(
                shrinkWrap: true,
                itemCount: photoList.length == 0
                    ? 1
                    : photoList.length == 4 ? 4 : photoList.length + 1,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(screenSize.width / 83.2),
                    child: GradientContainerBorder(
                      onPressed: () {
                        print('index is $index, length is ${photoList.length}');
                        if (index == photoList.length) {
                          _selectPictures();
                        } else if (index < photoList.length) {
                          _showPictureOptionsBottomSheet(index);
                        } else {
                          Fluttertoast.showToast(
                            msg:
                                'Please fill previous images before continuing with this image',
                          );
                        }
                      },
                      radius: screenSize.width / 37.5,
                      height: screenSize.height / 6.76,
                      strokeWidth: 0.0,
                      width: MediaQuery.of(context).size.width,
                      gradient: appGradient,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                            Radius.circular(screenSize.width / 37.5)),
                        child: Container(
                          margin: EdgeInsets.all(
                              photoList.length > index ? 0.0 : 1.0),
                          decoration: BoxDecoration(
                              color: white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(screenSize.width / 37.5))),
                          child: photoList.length > index
                              ? Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    AssetThumb(
                                      asset: photoList[index],
                                      width: screenSize.width.toInt(),
                                      height: screenSize.height.toInt(),
                                    ),
                                    Visibility(
                                      visible: index == primaryIndex,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: screenSize.width,
                                        color: Color(0x40000000),
                                        child: Text(
                                          'Primary',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : LinearGradientMask(
                                  child: Icon(
                                    CustomIcons.ic_add_photo,
                                    color: white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  _selectPictures() async {
    final images = await MultiImagePicker.pickImages(
//      type: FileType.image,
      maxImages: 4 - photoList.length,
      materialOptions: MaterialOptions(
        actionBarColor: '#454f63',
        statusBarColor: '#454f63',
        lightStatusBar: true,
        startInAllView: true,
        useDetailsView: true,
      ),
    ).catchError((e) => print('No photos selected'));

    if (images != null && images.isNotEmpty) {
      photoList.insertAll(photoList.length, images);
      if (photoList.length > 4) photoList.removeRange(4, photoList.length);
      widget.onPhotosChanged(photoList);
      setState(() {});
    }
  }

  _showPictureOptionsBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          top: false,
          minimum: EdgeInsets.only(bottom: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
//                ListTile(
//                  contentPadding:
//                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
//                  title: Text(
//                    'View picture',
//                    style: TextStyle(
//                      fontSize: 16.0,
//                      color: grey,
//                      fontWeight: FontWeight.w600,
//                    ),
//                  ),
//                  onTap: () {
//                    Navigator.push(
//                        context,
//                        PageRouteBuilder(
//                            transitionDuration: Duration(milliseconds: 200),
//                            opaque: false,
//                            pageBuilder: (BuildContext context, _, __) {
//                              return PhotoViewPage(
//                                index.toString(),
//                                assetImage: pictureList[index],
//                              );
//                            },
//                            transitionsBuilder: (___,
//                                Animation<double> animation,
//                                ____,
//                                Widget child) {
//                              return FadeTransition(
//                                opacity: animation,
//                                child: child,
//                              );
//                            }));
//                  },
//                ),
                ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  title: Text(
                    'Remove photo',
                    style: TextStyle(
                      fontSize: screenSize.width / 23.43,
                      color: accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    setState(() {
                      photoList.removeAt(index);
                      widget.onPhotosChanged(photoList);
                      if (primaryIndex == index) {
                        primaryIndex = 0;
                        widget.onPrimaryIndexChanged(primaryIndex);
                      }
                    });
                    Navigator.pop(context);
                  },
                ),
                photoList.length < 4
                    ? ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        title: Text(
                          'Upload more photos',
                          style: TextStyle(
                            fontSize: screenSize.width / 23.43,
                            color: accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          _selectPictures();
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
                primaryIndex != index
                    ? ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 4.0),
                        title: Text(
                          'Set as primary (profile picture)',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: accent,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            primaryIndex = index;
                            widget.onPrimaryIndexChanged(primaryIndex);
                          });
                          Navigator.pop(context);
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
