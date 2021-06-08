// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseOtherUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseOtherUser _$BaseOtherUserFromJson(Map<String, dynamic> json) {
  return BaseOtherUser(
    person: OtherUser.fromJson(json['person'] as Map<String, dynamic>),
    ringStatus: json['ringStatus'] as int?,
    orginalUserId: json['orginalUserId'] as String,
    followed: json['followed'] as bool,
    isDate: json['isDate'] as bool,
    ringStatusOther: json['ringStatusOther'] as String?,
    presentlySecret: json['presentlySecret'] as bool?,
  );
}

Map<String, dynamic> _$BaseOtherUserToJson(BaseOtherUser instance) =>
    <String, dynamic>{
      'person': instance.person,
      'orginalUserId': instance.orginalUserId,
      'followed': instance.followed,
      'isDate': instance.isDate,
      'ringStatusOther': instance.ringStatusOther,
      'ringStatus': instance.ringStatus,
      'presentlySecret': instance.presentlySecret,
    };
