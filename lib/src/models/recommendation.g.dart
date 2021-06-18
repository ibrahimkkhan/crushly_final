// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recommendation _$RecommendationFromJson(Map<String, dynamic> json) {
  return Recommendation(
    address: json['address'] as String?,
    age: json['age'] as int?,
    followCount: json['followCount'] as int?,
    orignallySecret: json['orignallySecret'] as bool?,
    presentlySecret: json['presentlySecret'] as bool?,
    photos:
        (json['photos'] as List<dynamic>?)?.map((e) => e as String).toList(),
    hasRing: json['hasRing'] as bool?,
    id: json['_id'] as String,
    nickName: json['nickName'] as String?,
    revealTime: json['revealTime'] as String?,
    notify: json['notify'] as bool?,
    gender: json['gender'] as String?,
    languages: json['languages'] as String?,
    schoolName: json['schoolName'] as String?,
    university: json['university'] as String?,
    name: json['name'] as String,
    relation: json['relation'] as int?,
    birthday: json['birthday'] as String?,
    email: json['email'] as String?,
    isCrush: json['isCrush'] as bool?,
    profilePhoto: json['profilePhoto'] as String?,
    jwtToken: json['jwtToken'] as String?,
    isSecretCrush: json['isSecretCrush'] as bool?,
    interestedIn: json['interestedIn'] as String?,
    greekHouse: json['greekHouse'] as String?,
  );
}

Map<String, dynamic> _$RecommendationToJson(Recommendation instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'greekHouse': instance.greekHouse,
      'university': instance.university,
      'gender': instance.gender,
      'profilePhoto': instance.profilePhoto,
      'address': instance.address,
      'followCount': instance.followCount,
      'age': instance.age,
      'photos': instance.photos,
      'email': instance.email,
      'schoolName': instance.schoolName,
      'birthday': instance.birthday,
      'revealTime': instance.revealTime,
      'jwtToken': instance.jwtToken,
      'nickName': instance.nickName,
      'languages': instance.languages,
      'relation': instance.relation,
      'presentlySecret': instance.presentlySecret,
      'interestedIn': instance.interestedIn,
      'hasRing': instance.hasRing,
      'orignallySecret': instance.orignallySecret,
      'notify': instance.notify,
      'isSecretCrush': instance.isSecretCrush,
      'isCrush': instance.isCrush,
    };
