import 'search_user.dart';
import 'package:json_annotation/json_annotation.dart';
import 'User.dart';
part 'BaseSearch.g.dart';
@JsonSerializable()
class BaseSearch {
 final List<SearchUser> result;

 BaseSearch(this.result);
 factory BaseSearch.fromJson(Map<String,dynamic> json)=>_$BaseSearchFromJson(json);
}