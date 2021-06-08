import 'package:json_annotation/json_annotation.dart';
import './OtherUser.dart';

part 'BaseOtherUser.g.dart';

@JsonSerializable()
class BaseOtherUser {
  final OtherUser person;
  final String orginalUserId;
  final bool followed;
  final bool isDate;
  final String? ringStatusOther;
  final int? ringStatus;
  final bool? presentlySecret;

  BaseOtherUser(
      {required this.person,
      this.ringStatus,
      required this.orginalUserId,
      required this.followed,
      required this.isDate,
      this.ringStatusOther,
      this.presentlySecret});

  factory BaseOtherUser.fromJson(Map<String, dynamic> json) =>
      _$BaseOtherUserFromJson(json);
}
