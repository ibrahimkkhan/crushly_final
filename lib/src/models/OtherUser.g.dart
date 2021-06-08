// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OtherUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtherUser _$OtherUserFromJson(Map<String, dynamic> json) {
  return OtherUser(
    dateList: json['dateList'] as List<dynamic>?,
    followCount: json['followCount'] as int?,
    followList: (json['followList'] as List<dynamic>?)
        ?.map((e) => OtherUser.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['_id'] as String,
    myfeed: json['myfeed'] as List<dynamic>?,
    name: json['name'] as String,
    profilePhoto: json['profilePhoto'] as String?,
    ringsHolding: (json['ringsHolding'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    ringsOffered: (json['ringsOffered'] as List<dynamic>?)
        ?.map((e) => Ring.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasRing: json['hasRing'] as bool?,
    nickName: json['nickName'] as String?,
    revealTime: json['revealTime'] as String?,
    presentlySecret: json['presentlySecret'] as bool?,
  );
}

Map<String, dynamic> _$OtherUserToJson(OtherUser instance) => <String, dynamic>{
      'followList': instance.followList,
      'myfeed': instance.myfeed,
      'dateList': instance.dateList,
      'ringsOffered': instance.ringsOffered,
      'ringsHolding': instance.ringsHolding,
      '_id': instance.id,
      'name': instance.name,
      'followCount': instance.followCount,
      'profilePhoto': instance.profilePhoto,
      'presentlySecret': instance.presentlySecret,
      'revealTime': instance.revealTime,
      'nickName': instance.nickName,
      'hasRing': instance.hasRing,
    };
