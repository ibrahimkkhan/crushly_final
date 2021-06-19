// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    partnerId: json['partnerId'] as String?,
    dateList: (json['dateList'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    followCount: json['followCount'] as int?,
    orignallySecret: json['orignallySecret'] as bool?,
    presentlySecret: json['presentlySecret'] as bool?,
    followList: (json['followList'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    photos: (json['photos'] as List<dynamic>?)
        ?.map((e) => BasePhoto.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasRing: json['hasRing'] as bool?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    id: json['_id'] as String,
    nickName: json['nickName'] as String?,
    revealTime: json['revealTime'] as String?,
    notify: json['notify'] as bool?,
    myfeed: (json['myfeed'] as List<dynamic>?)
        ?.map((e) => Story.fromJson(e as Map<String, dynamic>))
        .toList(),
    gender: json['gender'] as String?,
    languages: json['languages'] as String?,
    schoolName: json['schoolName'] as String?,
    university: json['university'] as String?,
    name: json['name'] as String?,
    birthday: json['dob'] as String?,
    email: json['email'] as String?,
    thumbnail: json['thumbnail'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    isCrush: json['isCrush'] as bool?,
    profilePhoto: json['profilePhoto'] as String?,
    jwtToken: json['jwtToken'] as String?,
    isSecretCrush: json['isSecretCrush'] as bool?,
    relation: json['relation'] as int?,
    ringsHolding: (json['ringsHolding'] as List<dynamic>?)
        ?.map((e) => RingOffered.fromJson(e as Map<String, dynamic>))
        .toList(),
    interestedIn: json['intrestedIn'] as String?,
    ringsOffered: (json['ringsOffered'] as List<dynamic>?)
        ?.map((e) => RingOffered.fromJson(e as Map<String, dynamic>))
        .toList(),
    myfollowees: (json['myfollowees'] as List<dynamic>?)
        ?.map((e) => FollowResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    greekHouse: json['greekHouse'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'followList': instance.followList,
      'partnerId': instance.partnerId,
      'dateList': instance.dateList,
      'images': instance.images,
      'photos': instance.photos,
      'myfollowees': instance.myfollowees,
      'ringsOffered': instance.ringsOffered,
      'ringsHolding': instance.ringsHolding,
      'createdAt': instance.createdAt?.toIso8601String(),
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'gender': instance.gender,
      'schoolName': instance.schoolName,
      'university': instance.university,
      'greekHouse': instance.greekHouse,
      'dob': instance.birthday,
      'followCount': instance.followCount,
      'relation': instance.relation,
      'profilePhoto': instance.profilePhoto,
      'thumbnail': instance.thumbnail,
      'revealTime': instance.revealTime,
      'jwtToken': instance.jwtToken,
      'nickName': instance.nickName,
      'languages': instance.languages,
      'presentlySecret': instance.presentlySecret,
      'intrestedIn': instance.interestedIn,
      'hasRing': instance.hasRing,
      'orignallySecret': instance.orignallySecret,
      'myfeed': instance.myfeed,
      'notify': instance.notify,
      'isSecretCrush': instance.isSecretCrush,
      'isCrush': instance.isCrush,
    };
