import 'package:json_annotation/json_annotation.dart';

part 'search_user.g.dart';

@JsonSerializable()
class SearchUser {
  @JsonKey(nullable: true)
  final String? name;
  @JsonKey(name: "_id")
  final String id;

  final String thumbnail;

  SearchUser({
    this.name,
    required this.id,
    required this.thumbnail,
  });

  factory SearchUser.fromJson(Map<String, dynamic> json) =>
      _$SearchUserFromJson(json);

  Map<String, dynamic> toJson() => _$SearchUserToJson(this);
}
