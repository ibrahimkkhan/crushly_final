import 'package:built_value/built_value.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_preview.g.dart';

@JsonSerializable()
class UserPreview {
  @BuiltValueField(wireName: 'id')
  final int id;

  @BuiltValueField(wireName: 'profilePhoto')
  final String profilePhoto;

  @BuiltValueField(wireName: 'firstName')
  final String firstName;

  @BuiltValueField(wireName: 'lastName')
  final String lastName;

  @BuiltValueField(wireName: 'crushyCount')
  final int crushyCount;

  @BuiltValueField(wireName: 'secretCrushyCount')
  final int secretCrushyCount;

  @BuiltValueField(wireName: 'schoolName')
  final String schoolName;

  @BuiltValueField(wireName: 'address')
  final String address;

  @BuiltValueField(wireName: 'bio')
  final String bio;

  @BuiltValueField(wireName: 'languages')
  final String languages;

  @BuiltValueField(wireName: 'presentlySecret')
  final bool presentlySecret;

  @BuiltValueField(wireName: 'originallySecret')
  final bool originallySecret;


  String get fullName => firstName + ' ' + lastName;

  UserPreview(this.id, this.profilePhoto, this.firstName, this.lastName,
      this.crushyCount, this.secretCrushyCount, this.schoolName, this.address,
      this.bio, this.languages, this.presentlySecret, this.originallySecret);

  factory UserPreview.fromJson(Map<String, dynamic> json) =>
      _$UserPreviewFromJson(json);
}
