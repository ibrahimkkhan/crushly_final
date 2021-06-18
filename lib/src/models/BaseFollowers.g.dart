// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseFollowers.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseFollowers _$BaseFollowersFromJson(Map<String, dynamic> json) {
  return BaseFollowers(
    (json['followList'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    myfollowees: (json['myfollowees'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BaseFollowersToJson(BaseFollowers instance) =>
    <String, dynamic>{
      'followList': instance.followList,
      'myfollowees': instance.myfollowees,
    };
