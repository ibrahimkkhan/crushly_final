import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundAvatar extends StatelessWidget {
  //
  RoundAvatar({required this.imageUrl, this.height = 80, this.width = 80});
  final String imageUrl;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
        ),
        borderRadius: BorderRadius.all(Radius.circular(height / 2)),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? '',
        filterQuality: FilterQuality.high,
        fit: BoxFit.fill,
        imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey[100]!,
            ),
            borderRadius: BorderRadius.all(Radius.circular(height / 2)),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(height / 2)),
          ),
        ),
      ),
    );
  }
}
