import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'recommendation.g.dart';

@JsonSerializable()
class Recommendation {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(nullable: true, name: 'greekHouse')
  final String? greekHouse;

  @JsonKey(nullable: true, name: 'university')
  final String? university;

  @JsonKey(nullable: true, name: 'gender')
  final String? gender;

  @JsonKey(nullable: true, name: 'profilePhoto')
  final String? profilePhoto;

  @JsonKey(nullable: true, name: 'address')
  final String? address;

  @JsonKey(nullable: true, name: 'followCount')
  final int? followCount;

  @JsonKey(nullable: true, name: 'age')
  final int? age;

  @JsonKey(nullable: true)
  final List<String>? photos;
  @JsonKey(nullable: true)
  final String? email;
  @JsonKey(nullable: true)
  final String? schoolName;
  @JsonKey(nullable: true)
  final String? birthday;
  @JsonKey(nullable: true)
  final String? revealTime;
  @JsonKey(nullable: true)
  final String? jwtToken;
  @JsonKey(nullable: true)
  final String? nickName;
  @JsonKey(nullable: true)
  final String? languages;
  @JsonKey(nullable: true)
  final int? relation;
  @JsonKey(nullable: true)
  bool? presentlySecret;
  @JsonKey(nullable: true)
  String? interestedIn;
  @JsonKey(nullable: true)
  final bool? hasRing;
  @JsonKey(nullable: true)
  bool? orignallySecret;
  @JsonKey(nullable: true)
  final bool? notify;

  @JsonKey(nullable: true)
  bool? isSecretCrush;

  @JsonKey(nullable: true)
  bool? isCrush;

  Recommendation({
  required this.address, required this.age,
    required this.followCount,
    required this.orignallySecret,
    required this.presentlySecret,
    required this.photos,
    required this.hasRing,
    required this.id,
    required this.nickName,
    required this.revealTime,
    required this.notify,
    required this.gender,
    required this.languages,
    required this.schoolName,
    required this.university,
    required this.name,
    required this.relation,
    required this.birthday,
    required this.email,
    required this.isCrush,
    required this.profilePhoto,
    required this.jwtToken,
    required this.isSecretCrush,
    required this.interestedIn,
    required this.greekHouse,
  });


  factory Recommendation.fromJson(Map<String, dynamic> json) =>
      _$RecommendationFromJson(json);
}
