import 'package:json_annotation/json_annotation.dart';

part 'BasePhoto.g.dart';
@JsonSerializable()
class BasePhoto {
 final String key;
 final String url;

 BasePhoto(this.key,this.url);
 factory BasePhoto.fromJson(Map<String,dynamic> json)=>_$BasePhotoFromJson(json);
}