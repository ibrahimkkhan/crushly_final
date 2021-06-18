// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
    json['message'] as String,
    json['createdAt'] as int,
    json['isRead'] as bool,
    json['author'] as String,
    json['reciever'] as String,
  );
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'createdAt': instance.createdAt,
      'isRead': instance.isRead,
      'author': instance.author,
      'reciever': instance.reciever,
    };
