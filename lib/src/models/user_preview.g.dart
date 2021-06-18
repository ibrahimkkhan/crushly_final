// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preview.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreview _$UserPreviewFromJson(Map<String, dynamic> json) {
  return UserPreview(
    json['id'] as int,
    json['profilePhoto'] as String,
    json['firstName'] as String,
    json['lastName'] as String,
    json['crushyCount'] as int,
    json['secretCrushyCount'] as int,
    json['schoolName'] as String,
    json['address'] as String,
    json['bio'] as String,
    json['languages'] as String,
    json['presentlySecret'] as bool,
    json['originallySecret'] as bool,
  );
}

Map<String, dynamic> _$UserPreviewToJson(UserPreview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'profilePhoto': instance.profilePhoto,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'crushyCount': instance.crushyCount,
      'secretCrushyCount': instance.secretCrushyCount,
      'schoolName': instance.schoolName,
      'address': instance.address,
      'bio': instance.bio,
      'languages': instance.languages,
      'presentlySecret': instance.presentlySecret,
      'originallySecret': instance.originallySecret,
    };
