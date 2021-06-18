// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseBlockList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseBlockList _$BaseBlockListFromJson(Map<String, dynamic> json) {
  return BaseBlockList(
    (json['list'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BaseBlockListToJson(BaseBlockList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
