// GENERATED CODE - DO NOT MODIFY BY HAND

part of profile_settings_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProfileSettingsState extends ProfileSettingsState {
  factory _$ProfileSettingsState(
          [void Function(ProfileSettingsStateBuilder) updates]) =>
      (new ProfileSettingsStateBuilder()..update(updates)).build();

  _$ProfileSettingsState._() : super._();

  @override
  ProfileSettingsState rebuild(
          void Function(ProfileSettingsStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileSettingsStateBuilder toBuilder() =>
      new ProfileSettingsStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProfileSettingsState;
  }

  @override
  int get hashCode {
    return 991999814;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('ProfileSettingsState').toString();
  }
}

class ProfileSettingsStateBuilder
    implements Builder<ProfileSettingsState, ProfileSettingsStateBuilder> {
  _$ProfileSettingsState _$v;

  ProfileSettingsStateBuilder();

  @override
  void replace(ProfileSettingsState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ProfileSettingsState;
  }

  @override
  void update(void Function(ProfileSettingsStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ProfileSettingsState build() {
    final _$result = _$v ?? new _$ProfileSettingsState._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
