import 'package:json_annotation/json_annotation.dart';

part 'Message.g.dart';
@JsonSerializable()
class Message {
 final String message;
 final int createdAt;
 final bool isRead;
 final String author;
 final String reciever;
 Message(this.message,this.createdAt,this.isRead,this.author,this.reciever
 );
 factory Message.fromJson(Map<String,dynamic> json)=>_$MessageFromJson(json);
}