import 'package:json_annotation/json_annotation.dart';
import 'Ring.dart';
part 'OtherUser.g.dart';

@JsonSerializable()
class OtherUser {
  @JsonKey(nullable: true)
  final List<OtherUser>? followList;
  @JsonKey(nullable: true)
  final List<dynamic>? myfeed;
  @JsonKey(nullable: true)
  final List<dynamic>? dateList;
  @JsonKey(nullable: true)
  final List<Ring>? ringsOffered;
  @JsonKey(nullable: true)
  final List<String>? ringsHolding;
  @JsonKey(name: "_id")
  final String id;
  final String name;
  @JsonKey(nullable: true)
  final int? followCount;
  @JsonKey(nullable: true)
  final String? profilePhoto;
  @JsonKey(nullable: true)
  final bool? presentlySecret;

  @JsonKey(nullable: true)
  final String? revealTime;
  @JsonKey(nullable: true)
  final String? nickName;
  @JsonKey(nullable: true)
  final bool? hasRing;

  OtherUser(
      {this.dateList,
      this.followCount,
     
      this.followList,
      required this.id,
      this.myfeed,
      required this.name,
      this.profilePhoto,
      this.ringsHolding,
      this.ringsOffered,
      this.hasRing,
      this.nickName,
      this.revealTime,this.presentlySecret});
  factory OtherUser.fromJson(Map<String, dynamic> json) =>
      _$OtherUserFromJson(json);
  Map<String, dynamic> toJson() => _$OtherUserToJson(this);
}
