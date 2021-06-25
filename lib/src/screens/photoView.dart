import 'dart:io';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewPage extends StatefulWidget {
  PhotoViewPage(this.tag, {this.assetImage});

  final String tag;
  final Asset assetImage;

  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  Size size;
  double top = 0;
  double obacity = 1;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black.withOpacity(obacity),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: top,
            height: size.height,
            width: size.width,
            child: GestureDetector(
              onVerticalDragUpdate: (d) {
                setState(() {
                  top = d.localPosition.dy - (size.height / 2);

                  if (((size.height /
                                  (d.localPosition.dy - (size.height * 0.5))) /
                              10)
                          .abs() <=
                      1.000) {
                    obacity = ((size.height /
                                (d.localPosition.dy - (size.height * 0.5))) /
                            10)
                        .abs();
                  }
                });
              },
              onVerticalDragEnd: (d) {
                top.abs() > (size.height * 0.11)
                    ? Navigator.pop(context)
                    : setState(() {
                        top = 0;
                        obacity = 1;
                      });
              },
              child: widget.assetImage == null ? PhotoView(
                imageProvider: AssetImage("lib/Fonts/ananya.png"),
                //loadingChild: LoadingText(),
                backgroundDecoration: BoxDecoration(),
                gaplessPlayback: false,

                heroTag: widget.tag,

                enableRotation: false,
                transitionOnUserGestures: false,
                //controller:  controller,
                minScale: PhotoViewComputedScale.contained * 0.8,
                maxScale: PhotoViewComputedScale.covered * 1.8,
                initialScale: PhotoViewComputedScale.contained,
                basePosition: Alignment.center,
                //scaleStateCycle: scaleStateCycle
              ) : AssetThumb(
                asset: widget.assetImage,
                width: 300,
                height: 200,
//                              fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
