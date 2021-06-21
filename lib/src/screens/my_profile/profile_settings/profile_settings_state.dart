library profile_settings_state;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'profile_settings_state.g.dart';


abstract class ProfileSettingsState implements Built<ProfileSettingsState, ProfileSettingsStateBuilder> {



  ProfileSettingsState._();

  factory ProfileSettingsState([updates(ProfileSettingsStateBuilder b)]) = _$ProfileSettingsState;

  factory ProfileSettingsState.initial() {
    return ProfileSettingsState((b) => b);
  }
}
