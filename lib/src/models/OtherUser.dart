import 'package:json_annotation/json_annotation.dart';
import 'Ring.dart';
part 'OtherUser.g.dart';

@JsonSerializable()
class OtherUser {
  final List<OtherUser>? followList;
  final List<dynamic>? myfeed;
  final List<dynamic>? dateList;
  final List<Ring>? ringsOffered;
  final List<String>? ringsHolding;
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final int? followCount;
  final String? profilePhoto;
  final bool? presentlySecret;
  final String? revealTime;
  final String? nickName;
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
