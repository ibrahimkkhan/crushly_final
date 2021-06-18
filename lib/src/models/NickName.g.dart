// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NickName.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NickName _$NickNameFromJson(Map<String, dynamic> json) {
  return NickName(
    json['name'] as String,
    json['surname'] as String,
    json['gender'] as String,
    json['region'] as String,
  );
}

Map<String, dynamic> _$NickNameToJson(NickName instance) => <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'gender': instance.gender,
      'region': instance.region,
    };
