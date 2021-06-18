// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowResponse _$FollowResponseFromJson(Map<String, dynamic> json) {
  return FollowResponse(
    json['isDate'] as bool,
    json['orignallySecret'] as bool,
    json['presentlySecret'] as bool,
    json['otherHadSecret'] as bool,
    json['name'] as String,
    json['profilePhoto'] as String,
    json['_id'] as String,
  );
}

Map<String, dynamic> _$FollowResponseToJson(FollowResponse instance) =>
    <String, dynamic>{
      'isDate': instance.isDate,
      'orignallySecret': instance.originallySecret,
      'presentlySecret': instance.presentlySecret,
      'otherHadSecret': instance.otherHadSecret,
      'name': instance.otherName,
      'profilePhoto': instance.profilePhoto,
      '_id': instance.id,
    };
