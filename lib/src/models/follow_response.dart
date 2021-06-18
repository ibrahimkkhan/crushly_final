import 'package:json_annotation/json_annotation.dart';

part 'follow_response.g.dart';

@JsonSerializable()
class FollowResponse {
  @JsonKey(name: 'isDate', nullable: true)
  final bool isDate;
  @JsonKey(name: 'orignallySecret', nullable: true)
  final bool originallySecret;
  @JsonKey(name: 'presentlySecret', nullable: true)
  final bool presentlySecret;
  @JsonKey(name: 'otherHadSecret', nullable: true)
  final bool otherHadSecret;
  @JsonKey(name: 'name', nullable: true)
  final String otherName;
  @JsonKey(name: 'profilePhoto', nullable: true)
  final String profilePhoto;
  @JsonKey(name: '_id', nullable: true)
  final String id;

  FollowResponse(this.isDate, this.originallySecret, this.presentlySecret,
      this.otherHadSecret, this.otherName, this.profilePhoto, this.id);

  factory FollowResponse.fromJson(Map<String, dynamic> json) =>
      _$FollowResponseFromJson(json);
}