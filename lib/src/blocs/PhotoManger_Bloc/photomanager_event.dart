import 'dart:io';

import 'package:meta/meta.dart';

@immutable
abstract class PhotomanagerEvent {}
class SetPhoto extends PhotomanagerEvent{
  final File image;
  
  SetPhoto(this.image);
}