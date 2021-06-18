import 'package:json_annotation/json_annotation.dart';

part 'NickName.g.dart';

@JsonSerializable()
class NickName {
  @JsonKey(nullable: true)
  final String name;
  final String surname;
  @JsonKey(nullable: true)
  final String gender;
  @JsonKey(nullable: true)
  final String region;

  NickName(this.name, this.surname, this.gender, this.region);
  factory NickName.fromJson(Map<String, dynamic> json) =>
      _$NickNameFromJson(json);
}
