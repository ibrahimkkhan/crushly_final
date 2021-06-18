// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RingOffered.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RingOffered _$RingOfferedFromJson(Map<String, dynamic> json) {
  return RingOffered(
    owner: User.fromJson(json['owner'] as Map<String, dynamic>),
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$RingOfferedToJson(RingOffered instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'owner': instance.owner,
    };
