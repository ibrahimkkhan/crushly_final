import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';

@immutable
abstract class MyProfileEvent {}

class GetMyProfile extends MyProfileEvent {}

class EditProfile extends MyProfileEvent {}

class ChangeProfilePhoto extends MyProfileEvent {
  final Asset image;

  ChangeProfilePhoto(this.image);
}

class ChangeImages extends MyProfileEvent {
  final List<Asset> images;

  ChangeImages(this.images);
}
