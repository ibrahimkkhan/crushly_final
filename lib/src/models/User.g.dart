// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    dateList: (json['dateList'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    followCount: json['followCount'] as int?,
    orignallySecret: json['orignallySecret'] as bool?,
    presentlySecret: json['presentlySecret'] as bool?,
    followList: (json['followList'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasRing: json['hasRing'] as bool?,
    id: json['_id'] as String,
    nickName: json['nickName'] as String?,
    revealTime: json['revealTime'] as String?,
    notify: json['notify'] as bool?,
    myfeed: (json['myfeed'] as List<dynamic>?)
        ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
        .toList(),
    name: json['name'] as String?,
    profilePhoto: json['profilePhoto'] as String?,
    ringsHolding: (json['ringsHolding'] as List<dynamic>?)
        ?.map((e) => RingOffered.fromJson(e as Map<String, dynamic>))
        .toList(),
    ringsOffered: (json['ringsOffered'] as List<dynamic>?)
        ?.map((e) => RingOffered.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'followList': instance.followList,
      'dateList': instance.dateList,
      'ringsOffered': instance.ringsOffered,
      'ringsHolding': instance.ringsHolding,
      '_id': instance.id,
      'name': instance.name,
      'followCount': instance.followCount,
      'profilePhoto': instance.profilePhoto,
      'revealTime': instance.revealTime,
      'nickName': instance.nickName,
      'presentlySecret': instance.presentlySecret,
      'hasRing': instance.hasRing,
      'orignallySecret': instance.orignallySecret,
      'myfeed': instance.myfeed,
      'notify': instance.notify,
    };
