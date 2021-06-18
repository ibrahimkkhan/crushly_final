import 'BasePhoto.dart';
import 'RingOffered.dart';
import 'follow_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'Story.dart';

part 'User.g.dart';

@JsonSerializable()
@CustomDateTimeConverter()
class User {
  @JsonKey(nullable: true)
  final List<User> followList;
  @JsonKey(nullable: true)
  final String partnerId;
  @JsonKey(nullable: true)
  final List<User> dateList;
  @JsonKey(nullable: true)
  final List<String> images;
  @JsonKey(nullable: true)
  final List<BasePhoto> photos;
  @JsonKey(nullable: true)
  final List<FollowResponse> myfollowees;
  @JsonKey(nullable: true)
  final List<RingOffered> ringsOffered;
  @JsonKey(nullable: true)
  final List<RingOffered> ringsHolding;
  @JsonKey(nullable: true)
  final DateTime createdAt;
  @JsonKey(name: "_id")
  String id;
  @JsonKey(nullable: true)
  final String name;
  @JsonKey(nullable: true)
  final String email;
  @JsonKey(nullable: true)
  String gender;
  @JsonKey(nullable: true)
  final String schoolName;
  @JsonKey(nullable: true)
  final String university;
  @JsonKey(nullable: true)
  final String greekHouse;
  @JsonKey(nullable: true, name: 'dob')
  final String birthday;
  @JsonKey(nullable: true)
  final int followCount;
  @JsonKey(nullable: true)
  final int relation;
  @JsonKey(nullable: true)
  String profilePhoto;
  @JsonKey(nullable: true)
  final String thumbnail;
  @JsonKey(nullable: true)
  final String revealTime;
  @JsonKey(nullable: true)
  final String jwtToken;
  @JsonKey(nullable: true)
  final String nickName;
  @JsonKey(nullable: true)
  final String languages;
  @JsonKey(nullable: true)
  bool presentlySecret;
  @JsonKey(nullable: true, name: 'intrestedIn')
  String interestedIn;
  @JsonKey(nullable: true)
  final bool hasRing;
  @JsonKey(nullable: true)
  bool orignallySecret;
  @JsonKey(nullable: true)
  final List<Story> myfeed;
  @JsonKey(nullable: true)
  final bool notify;
  @JsonKey(nullable: true)
  bool isSecretCrush;
  @JsonKey(nullable: true)
  bool isCrush;

  User({
    required this.partnerId,
    required this.dateList,
    required this.followCount,
    required this.orignallySecret,
    required this.presentlySecret,
    required this.followList,
    required this.photos,
    required this.hasRing,
    required this.images,
    required this.id,
    required this.nickName,
    required this.revealTime,
    required this.notify,
    required this.myfeed,
    required this.gender,
    required this.languages,
    required this.schoolName,
    required this.university,
    required this.name,
    required this.birthday,
    required this.email,
    required this.thumbnail,
    required this.createdAt,
    required this.isCrush,
    required this.profilePhoto,
    required this.jwtToken,
    required this.isSecretCrush,
    required this.relation,
    required this.ringsHolding,
    required this.interestedIn,
    required this.ringsOffered,
    required this.myfollowees,
    required this.greekHouse,
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
