import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'Ring.g.dart';

@JsonSerializable()
class Ring {
  final List<User>? offeredTo;
  @JsonKey(name: "_id")
  final String id;
  final String owner;
  final bool? isWithOwner;
  final List<User>? previousHolders;
  final Map<String, String>? currentHolder;

  Ring(
      {required this.owner,
      this.offeredTo,
      this.currentHolder,
      this.isWithOwner,
      this.previousHolders,
      required this.id});
  factory Ring.fromJson(Map<String, dynamic> json) => _$RingFromJson(json);
}
