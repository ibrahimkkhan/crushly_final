import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'BasePeople.g.dart';

@JsonSerializable()
class BasePeople {
  final List<User> people;

 

  BasePeople(this.people);
  factory BasePeople.fromJson(Map<String, dynamic> json) =>
      _$BasePeopleFromJson(json);
}