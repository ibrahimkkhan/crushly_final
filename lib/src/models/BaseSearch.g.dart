// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BaseSearch.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseSearch _$BaseSearchFromJson(Map<String, dynamic> json) {
  return BaseSearch(
    (json['result'] as List<dynamic>)
        .map((e) => SearchUser.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BaseSearchToJson(BaseSearch instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
