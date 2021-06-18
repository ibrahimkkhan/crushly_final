import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'BaseBlockList.g.dart';

@JsonSerializable()
class BaseBlockList {
  final List<User> list;

 

  BaseBlockList(this.list);
  factory BaseBlockList.fromJson(Map<String, dynamic> json) =>
      _$BaseBlockListFromJson(json);
}