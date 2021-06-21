import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  //
  FullScreenImage({required this.photoUrl});
  final String photoUrl;

  @override
  Widget build(BuildContext context) {
    print(photoUrl);
    return Material(
      child: Container(
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: Hero(
                tag: photoUrl,
                child: CachedNetworkImage(
                  imageUrl: photoUrl,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 10, 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  iconSize: 35,
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
