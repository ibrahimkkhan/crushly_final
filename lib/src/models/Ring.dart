import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'Ring.g.dart';

@JsonSerializable()
class Ring {
  @JsonKey(nullable: true)
  final List<User> offeredTo;
  @JsonKey(name: "_id")
  final String id;
  final String owner;
  @JsonKey(nullable: true)
  final bool isWithOwner;
  @JsonKey(nullable: true)
  final List<User> previousHolders;
  @JsonKey(nullable: true)
  final Map<String, String> currentHolder;

  Ring(
      {this.owner,
      this.offeredTo,
      this.currentHolder,
      this.isWithOwner,
      this.previousHolders,
      this.id});
  factory Ring.fromJson(Map<String, dynamic> json) => _$RingFromJson(json);
}
