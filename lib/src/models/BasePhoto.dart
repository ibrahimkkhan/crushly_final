import 'package:json_annotation/json_annotation.dart';

part 'BasePhoto.g.dart';

@JsonSerializable()
class BasePhoto {
  final String key;
  final String url;
  @JsonKey(nullable: true)
  final String number;

  BasePhoto(this.key, this.url, this.number);

  factory BasePhoto.fromJson(Map<String, dynamic> json) =>
      _$BasePhotoFromJson(json);
}
