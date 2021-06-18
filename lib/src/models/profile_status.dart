import 'package:json_annotation/json_annotation.dart';

part 'profile_status.g.dart';

@JsonSerializable()
class ProfileStatus {
  ProfileStatus({
    this.active,
    this.profilePhotoRequired,
    this.morePhotosRequired,
    this.moreNumberOfRegPhotosReq,
  });

  bool? active;
  bool? profilePhotoRequired;
  bool? morePhotosRequired;
  int? moreNumberOfRegPhotosReq;

  factory ProfileStatus.fromJson(Map<String, dynamic> json) =>
      _$ProfileStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileStatusToJson(this);
}
