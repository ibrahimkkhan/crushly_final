import 'User.dart';
import 'recommendation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'OtherUser.dart';

part 'BaseOtherUser.g.dart';

@JsonSerializable()
class BaseOtherUser {
  final Recommendation person;

  final String originalUserId;
  final bool followed;
  final bool isDate;

  final String? ringStatusOther;
  final int? relation;
  final int? ringStatus;
  final bool? presentlySecret;
  final bool? orignallySecret;
  final bool? isBlocked;

  BaseOtherUser({
    required this.person,
    this.ringStatus,
    required this.originalUserId,
    required this.followed,
    required this.isDate,
    this.relation,
    this.ringStatusOther,
    this.presentlySecret,
    this.orignallySecret,
    this.isBlocked,
  });

  factory BaseOtherUser.fromJson(Map<String, dynamic> json) =>
      _$BaseOtherUserFromJson(json);
}
