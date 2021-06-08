import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'RingOffered.g.dart';

@JsonSerializable()
class RingOffered {
  @JsonKey(name: "_id")
  final String id;
  final User owner;

  RingOffered({this.owner, this.id});
  factory RingOffered.fromJson(Map<String, dynamic> json) =>
      _$RingOfferedFromJson(json);
}
