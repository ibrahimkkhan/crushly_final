import 'package:json_annotation/json_annotation.dart';
import 'User.dart';
part 'BaseUser.g.dart';
@JsonSerializable()
class BaseUser {
 final User person;
 @JsonKey(nullable: true)
final List<User> myfollowees;
 BaseUser({required this.person,required this.myfollowees});
 factory BaseUser.fromJson(Map<String,dynamic> json)=>_$BaseUserFromJson(json);
}