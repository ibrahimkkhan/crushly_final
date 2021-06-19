import 'BasePhoto.dart';
import 'RingOffered.dart';
import 'follow_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Story.dart';

part 'User.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class User {
  final List<User>? followList;
  final String? partnerId;
  final List<User>? dateList;
  final List<String>? images;
  final List<BasePhoto>? photos;
  final List<FollowResponse>? myfollowees;
  final List<RingOffered>? ringsOffered;
  final List<RingOffered>? ringsHolding;
  final DateTime? createdAt;
  @JsonKey(name: "_id")
  String id;
  final String? name;
  final String? email;
  String? gender;
  final String? schoolName;
  final String? university;
  final String? greekHouse;
  @JsonKey(nullable: true, name: 'dob')
  final String? birthday;
  final int? followCount;
  final int? relation;
  String? profilePhoto;
  final String? thumbnail;
  final String? revealTime;
  final String? jwtToken;
  final String? nickName;
  final String? languages;
  bool? presentlySecret;
  @JsonKey(nullable: true, name: 'intrestedIn')
  String? interestedIn;
  final bool? hasRing;
  bool? orignallySecret;
  final List<Story>? myfeed;
  final bool? notify;
  bool? isSecretCrush;
  bool? isCrush;

  User({
    this.partnerId,
    this.dateList,
    this.followCount,
    this.orignallySecret,
    this.presentlySecret,
    this.followList,
    this.photos,
    this.hasRing,
    this.images,
    required this.id,
    this.nickName,
    this.revealTime,
    this.notify,
    this.myfeed,
    this.gender,
    this.languages,
    this.schoolName,
    this.university,
    this.name,
    this.birthday,
    this.email,
    this.thumbnail,
    this.createdAt,
    this.isCrush,
    this.profilePhoto,
    this.jwtToken,
    this.isSecretCrush,
    this.relation,
    this.ringsHolding,
    this.interestedIn,
    this.ringsOffered,
    this.myfollowees,
    this.greekHouse,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json == null) {
      return DateTime.now();
    }
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime json) => json.toIso8601String();
}
