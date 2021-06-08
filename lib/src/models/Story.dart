import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'Story.g.dart';

@JsonSerializable()
class Story {
  @JsonKey(name: "_id")
  final String id;
  final User author;
  final String text;
  final String url;
  final String createdAt;
  final bool forever;
  Story(
      this.id, this.createdAt, this.author, this.forever, this.text, this.url);
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
