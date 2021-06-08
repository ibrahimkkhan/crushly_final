// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) {
  return Story(
    json['_id'] as String,
    json['createdAt'] as String,
    User.fromJson(json['author'] as Map<String, dynamic>),
    json['forever'] as bool,
    json['text'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      '_id': instance.id,
      'author': instance.author,
      'text': instance.text,
      'url': instance.url,
      'createdAt': instance.createdAt,
      'forever': instance.forever,
    };
