// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileStatus _$ProfileStatusFromJson(Map<String, dynamic> json) {
  return ProfileStatus(
    active: json['active'] as bool?,
    profilePhotoRequired: json['profilePhotoRequired'] as bool?,
    morePhotosRequired: json['morePhotosRequired'] as bool?,
    moreNumberOfRegPhotosReq: json['moreNumberOfRegPhotosReq'] as int?,
  );
}

Map<String, dynamic> _$ProfileStatusToJson(ProfileStatus instance) =>
    <String, dynamic>{
      'active': instance.active,
      'profilePhotoRequired': instance.profilePhotoRequired,
      'morePhotosRequired': instance.morePhotosRequired,
      'moreNumberOfRegPhotosReq': instance.moreNumberOfRegPhotosReq,
    };
