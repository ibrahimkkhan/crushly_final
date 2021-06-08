// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUser _$BaseUserFromJson(Map<String, dynamic> json) {
  return BaseUser(
    person: User.fromJson(json['person'] as Map<String, dynamic>),
    myfollowees: (json['myfollowees'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BaseUserToJson(BaseUser instance) => <String, dynamic>{
      'person': instance.person,
      'myfollowees': instance.myfollowees,
    };
