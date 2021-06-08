import 'RingOffered.dart';
import 'package:json_annotation/json_annotation.dart';
import 'Ring.dart';

import 'Story.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(nullable: true)
  final List<User> followList;

  @JsonKey(nullable: true)
  final List<User> dateList;
  @JsonKey(nullable: true)
  final List<RingOffered> ringsOffered;
  @JsonKey(nullable: true)
  final List<RingOffered> ringsHolding;
  @JsonKey(name: "_id")
  final String id;
  @JsonKey(nullable: true)
  final String name;
  @JsonKey(nullable: true)
  final int followCount;
  @JsonKey(nullable: true)
  final String profilePhoto;
  @JsonKey(nullable: true)
  final String revealTime;
  @JsonKey(nullable: true)
  final String nickName;
  @JsonKey(nullable: true)
  final bool presentlySecret;
  @JsonKey(nullable: true)
  final bool hasRing;
  @JsonKey(nullable: true)
  final bool orignallySecret;
  @JsonKey(nullable: true)
  final List<Story> myfeed;
  final bool notify;
  User({
    this.dateList,
    this.followCount,
    this.orignallySecret,
    this.presentlySecret,
    this.followList,
    this.hasRing,
    this.id,
    this.nickName,
    this.revealTime,
    this.notify,
    this.myfeed,
    this.name,
    this.profilePhoto,
    this.ringsHolding,
    this.ringsOffered,
  });
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
