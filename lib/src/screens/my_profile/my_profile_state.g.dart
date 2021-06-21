// GENERATED CODE - DO NOT MODIFY BY HAND

part of my_profile_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MyProfileState extends MyProfileState {
  @override
  final User user;
  @override
  final bool isEditing;
  @override
  final bool isLoading;
  @override
  final bool errorLoading;

  factory _$MyProfileState([void Function(MyProfileStateBuilder) updates]) =>
      (new MyProfileStateBuilder()..update(updates)).build();

  _$MyProfileState._(
      {this.user, this.isEditing, this.isLoading, this.errorLoading})
      : super._() {
    if (isEditing == null) {
      throw new BuiltValueNullFieldError('MyProfileState', 'isEditing');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('MyProfileState', 'isLoading');
    }
    if (errorLoading == null) {
      throw new BuiltValueNullFieldError('MyProfileState', 'errorLoading');
    }
  }

  @override
  MyProfileState rebuild(void Function(MyProfileStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyProfileStateBuilder toBuilder() =>
      new MyProfileStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyProfileState &&
        user == other.user &&
        isEditing == other.isEditing &&
        isLoading == other.isLoading &&
        errorLoading == other.errorLoading;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, user.hashCode), isEditing.hashCode), isLoading.hashCode),
        errorLoading.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('MyProfileState')
          ..add('user', user)
          ..add('isEditing', isEditing)
          ..add('isLoading', isLoading)
          ..add('errorLoading', errorLoading))
        .toString();
  }
}

class MyProfileStateBuilder
    implements Builder<MyProfileState, MyProfileStateBuilder> {
  _$MyProfileState _$v;

  User _user;
  User get user => _$this._user;
  set user(User user) => _$this._user = user;

  bool _isEditing;
  bool get isEditing => _$this._isEditing;
  set isEditing(bool isEditing) => _$this._isEditing = isEditing;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  bool _errorLoading;
  bool get errorLoading => _$this._errorLoading;
  set errorLoading(bool errorLoading) => _$this._errorLoading = errorLoading;

  MyProfileStateBuilder();

  MyProfileStateBuilder get _$this {
    if (_$v != null) {
      _user = _$v.user;
      _isEditing = _$v.isEditing;
      _isLoading = _$v.isLoading;
      _errorLoading = _$v.errorLoading;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyProfileState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$MyProfileState;
  }

  @override
  void update(void Function(MyProfileStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$MyProfileState build() {
    final _$result = _$v ??
        new _$MyProfileState._(
            user: user,
            isEditing: isEditing,
            isLoading: isLoading,
            errorLoading: errorLoading);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
