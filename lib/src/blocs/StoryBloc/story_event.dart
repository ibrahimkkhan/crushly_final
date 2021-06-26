import 'dart:io';
import 'dart:typed_data';

import 'package:meta/meta.dart';

@immutable
abstract class StoryEvent {}

class NewStory extends StoryEvent {
  final String userId;
  final String text;
  final String imagePath;
  final ByteData imageData;
  final bool forever;

  NewStory(
      this.userId, this.text, this.forever, this.imagePath, this.imageData);
}
