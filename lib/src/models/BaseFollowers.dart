import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'BaseFollowers.g.dart';

@JsonSerializable()
class BaseFollowers {
  final List<User> followList;

  final List<User> myfollowees;

  BaseFollowers(this.followList, {required this.myfollowees});

  factory BaseFollowers.fromJson(Map<String, dynamic> json) =>
      _$BaseFollowersFromJson(json);
}
