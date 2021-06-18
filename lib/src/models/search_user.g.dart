// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchUser _$SearchUserFromJson(Map<String, dynamic> json) {
  return SearchUser(
    name: json['name'] as String?,
    id: json['_id'] as String,
    thumbnail: json['thumbnail'] as String,
  );
}

Map<String, dynamic> _$SearchUserToJson(SearchUser instance) =>
    <String, dynamic>{
      'name': instance.name,
      '_id': instance.id,
      'thumbnail': instance.thumbnail,
    };
