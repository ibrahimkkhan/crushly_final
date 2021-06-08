import 'RingOffered.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Story.dart';
part 'User.g.dart';

@JsonSerializable()
class User {
  final List<User>? followList;

  final List<User>? dateList;
  final List<RingOffered>? ringsOffered;
  final List<RingOffered>? ringsHolding;
  @JsonKey(name: "_id")
  final String id;
  final String? name;
  final int? followCount;
  final String? profilePhoto;
  final String? revealTime;
  final String? nickName;
  final bool? presentlySecret;
  final bool? hasRing;
  final bool? orignallySecret;
  final List<Story>? myfeed;
  final bool? notify;
  User({
    this.dateList,
    this.followCount,
    this.orignallySecret,
    this.presentlySecret,
    this.followList,
    this.hasRing,
    required this.id,
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
