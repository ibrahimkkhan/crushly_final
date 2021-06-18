// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseDateList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDateList _$BaseDateListFromJson(Map<String, dynamic> json) {
  return BaseDateList(
    (json['dateList'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BaseDateListToJson(BaseDateList instance) =>
    <String, dynamic>{
      'dateList': instance.dateList,
    };
