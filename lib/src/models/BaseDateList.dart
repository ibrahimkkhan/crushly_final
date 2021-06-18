import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'BaseDateList.g.dart';

@JsonSerializable()
class BaseDateList {
  final List<User> dateList;

 

  BaseDateList(this.dateList);
  factory BaseDateList.fromJson(Map<String, dynamic> json) =>
      _$BaseDateListFromJson(json);
}