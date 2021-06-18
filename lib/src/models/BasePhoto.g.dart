// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'BasePhoto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasePhoto _$BasePhotoFromJson(Map<String, dynamic> json) {
  return BasePhoto(
    json['key'] as String,
    json['url'] as String,
    json['number'] as String,
  );
}

Map<String, dynamic> _$BasePhotoToJson(BasePhoto instance) => <String, dynamic>{
      'key': instance.key,
      'url': instance.url,
      'number': instance.number,
    };
