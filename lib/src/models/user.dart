

import 'package:equatable/equatable.dart';

class User extends Equatable{
  final List<User>? followList;
  final List<User>? dateList;
  final String id;
  final String name;
  final int? followCount;
  final String? profilePic;

  User(
  {required this.id,
    required this.name,
    this.followCount,
    this.profilePic,
    this.followList,
    this.dateList
  });

  User.fromJson(Map<String, dynamic> parsedJson)
  : id = parsedJson["_id"],
  name = parsedJson["name"],
  followCount = parsedJson["followCount"],
  profilePic = parsedJson["profilePhoto"],
  followList = (parsedJson["followList"] as List)
      .map(
          (e) => e==null ? null : User.fromJson(e as Map<String, dynamic>))
        .toList() as List<User>,
  dateList = (parsedJson["dateList"] as List)
      .map(
          (e) => e==null ? null : User.fromJson(e as Map<String, dynamic>))
      .toList() as List<User>;

  @override
  List<Object?> get props => [
    id,
    name,
    followList,
    followCount,
    profilePic,
    dateList
  ];

}