// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ring.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ring _$RingFromJson(Map<String, dynamic> json) {
  return Ring(
    owner: json['owner'] as String,
    offeredTo: (json['offeredTo'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    currentHolder: Map<String, String>.from(json['currentHolder'] as Map),
    isWithOwner: json['isWithOwner'] as bool,
    previousHolders: (json['previousHolders'] as List<dynamic>)
        .map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['_id'] as String,
  );
}

Map<String, dynamic> _$RingToJson(Ring instance) => <String, dynamic>{
      'offeredTo': instance.offeredTo,
      '_id': instance.id,
      'owner': instance.owner,
      'isWithOwner': instance.isWithOwner,
      'previousHolders': instance.previousHolders,
      'currentHolder': instance.currentHolder,
    };
