// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseOtherUser.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseOtherUser _$BaseOtherUserFromJson(Map<String, dynamic> json) {
  return BaseOtherUser(
    person: Recommendation.fromJson(json['person'] as Map<String, dynamic>),
    ringStatus: json['ringStatus'] as int?,
    originalUserId: json['originalUserId'] as String,
    followed: json['followed'] as bool,
    isDate: json['isDate'] as bool,
    relation: json['relation'] as int?,
    ringStatusOther: json['ringStatusOther'] as String?,
    presentlySecret: json['presentlySecret'] as bool?,
    orignallySecret: json['orignallySecret'] as bool?,
    isBlocked: json['isBlocked'] as bool?,
  );
}

Map<String, dynamic> _$BaseOtherUserToJson(BaseOtherUser instance) =>
    <String, dynamic>{
      'person': instance.person,
      'originalUserId': instance.originalUserId,
      'followed': instance.followed,
      'isDate': instance.isDate,
      'ringStatusOther': instance.ringStatusOther,
      'relation': instance.relation,
      'ringStatus': instance.ringStatus,
      'presentlySecret': instance.presentlySecret,
      'orignallySecret': instance.orignallySecret,
      'isBlocked': instance.isBlocked,
    };
