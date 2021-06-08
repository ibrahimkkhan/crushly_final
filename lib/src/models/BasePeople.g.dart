// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BasePeople.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePeople _$BasePeopleFromJson(Map<String, dynamic> json) {
  return BasePeople(
    (json['people'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BasePeopleToJson(BasePeople instance) =>
    <String, dynamic>{
      'people': instance.people,
    };
