import 'package:json_annotation/json_annotation.dart';
import 'profile_status.dart';

part 'settings.g.dart';

@JsonSerializable()
class Settings {
  Settings({
    required this.profileStatus,
  });

  ProfileStatus profileStatus;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
