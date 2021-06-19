// GENERATED CODE - DO NOT MODIFY BY HAND

part of auth_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignInState extends SignInState {
  @override
  final bool signingIn;
  @override
  final bool signInValidation;
  @override
  final bool emailValidation;
  @override
  final bool passwordValidation;
  @override
  final bool signInSuccessfully;
  @override
  final int signInError;

  factory _$SignInState([void Function(SignInStateBuilder)? updates]) =>
      (new SignInStateBuilder()..update(updates)).build();

  _$SignInState._(
      {required this.signingIn,
      required this.signInValidation,
      required this.emailValidation,
      required this.passwordValidation,
      required this.signInSuccessfully,
      required this.signInError})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        signingIn, 'SignInState', 'signingIn');
    BuiltValueNullFieldError.checkNotNull(
        signInValidation, 'SignInState', 'signInValidation');
    BuiltValueNullFieldError.checkNotNull(
        emailValidation, 'SignInState', 'emailValidation');
    BuiltValueNullFieldError.checkNotNull(
        passwordValidation, 'SignInState', 'passwordValidation');
    BuiltValueNullFieldError.checkNotNull(
        signInSuccessfully, 'SignInState', 'signInSuccessfully');
    BuiltValueNullFieldError.checkNotNull(
        signInError, 'SignInState', 'signInError');
  }

  @override
  SignInState rebuild(void Function(SignInStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignInStateBuilder toBuilder() => new SignInStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignInState &&
        signingIn == other.signingIn &&
        signInValidation == other.signInValidation &&
        emailValidation == other.emailValidation &&
        passwordValidation == other.passwordValidation &&
        signInSuccessfully == other.signInSuccessfully &&
        signInError == other.signInError;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, signingIn.hashCode), signInValidation.hashCode),
                    emailValidation.hashCode),
                passwordValidation.hashCode),
            signInSuccessfully.hashCode),
        signInError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SignInState')
          ..add('signingIn', signingIn)
          ..add('signInValidation', signInValidation)
          ..add('emailValidation', emailValidation)
          ..add('passwordValidation', passwordValidation)
          ..add('signInSuccessfully', signInSuccessfully)
          ..add('signInError', signInError))
        .toString();
  }
}

class SignInStateBuilder implements Builder<SignInState, SignInStateBuilder> {
  _$SignInState? _$v;

  bool? _signingIn;
  bool? get signingIn => _$this._signingIn;
  set signingIn(bool? signingIn) => _$this._signingIn = signingIn;

  bool? _signInValidation;
  bool? get signInValidation => _$this._signInValidation;
  set signInValidation(bool? signInValidation) =>
      _$this._signInValidation = signInValidation;

  bool? _emailValidation;
  bool? get emailValidation => _$this._emailValidation;
  set emailValidation(bool? emailValidation) =>
      _$this._emailValidation = emailValidation;

  bool? _passwordValidation;
  bool? get passwordValidation => _$this._passwordValidation;
  set passwordValidation(bool? passwordValidation) =>
      _$this._passwordValidation = passwordValidation;

  bool? _signInSuccessfully;
  bool? get signInSuccessfully => _$this._signInSuccessfully;
  set signInSuccessfully(bool? signInSuccessfully) =>
      _$this._signInSuccessfully = signInSuccessfully;

  int? _signInError;
  int? get signInError => _$this._signInError;
  set signInError(int? signInError) => _$this._signInError = signInError;

  SignInStateBuilder();

  SignInStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signingIn = $v.signingIn;
      _signInValidation = $v.signInValidation;
      _emailValidation = $v.emailValidation;
      _passwordValidation = $v.passwordValidation;
      _signInSuccessfully = $v.signInSuccessfully;
      _signInError = $v.signInError;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignInState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SignInState;
  }

  @override
  void update(void Function(SignInStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SignInState build() {
    final _$result = _$v ??
        new _$SignInState._(
            signingIn: BuiltValueNullFieldError.checkNotNull(
                signingIn, 'SignInState', 'signingIn'),
            signInValidation: BuiltValueNullFieldError.checkNotNull(
                signInValidation, 'SignInState', 'signInValidation'),
            emailValidation: BuiltValueNullFieldError.checkNotNull(
                emailValidation, 'SignInState', 'emailValidation'),
            passwordValidation: BuiltValueNullFieldError.checkNotNull(
                passwordValidation, 'SignInState', 'passwordValidation'),
            signInSuccessfully: BuiltValueNullFieldError.checkNotNull(
                signInSuccessfully, 'SignInState', 'signInSuccessfully'),
            signInError: BuiltValueNullFieldError.checkNotNull(
                signInError, 'SignInState', 'signInError'));
    replace(_$result);
    return _$result;
  }
}

class _$SignUpState extends SignUpState {
  @override
  final bool signingUp;
  @override
  final bool signUpValidation;
  @override
  final bool emailValidation;
  @override
  final bool passwordValidation;
  @override
  final bool signUpSuccessfully;
  @override
  final bool uploadPhotoSuccessfully;
  @override
  final bool? isEmailAvailable;
  @override
  final int signUpError;

  factory _$SignUpState([void Function(SignUpStateBuilder)? updates]) =>
      (new SignUpStateBuilder()..update(updates)).build();

  _$SignUpState._(
      {required this.signingUp,
      required this.signUpValidation,
      required this.emailValidation,
      required this.passwordValidation,
      required this.signUpSuccessfully,
      required this.uploadPhotoSuccessfully,
      this.isEmailAvailable,
      required this.signUpError})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        signingUp, 'SignUpState', 'signingUp');
    BuiltValueNullFieldError.checkNotNull(
        signUpValidation, 'SignUpState', 'signUpValidation');
    BuiltValueNullFieldError.checkNotNull(
        emailValidation, 'SignUpState', 'emailValidation');
    BuiltValueNullFieldError.checkNotNull(
        passwordValidation, 'SignUpState', 'passwordValidation');
    BuiltValueNullFieldError.checkNotNull(
        signUpSuccessfully, 'SignUpState', 'signUpSuccessfully');
    BuiltValueNullFieldError.checkNotNull(
        uploadPhotoSuccessfully, 'SignUpState', 'uploadPhotoSuccessfully');
    BuiltValueNullFieldError.checkNotNull(
        signUpError, 'SignUpState', 'signUpError');
  }

  @override
  SignUpState rebuild(void Function(SignUpStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignUpStateBuilder toBuilder() => new SignUpStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignUpState &&
        signingUp == other.signingUp &&
        signUpValidation == other.signUpValidation &&
        emailValidation == other.emailValidation &&
        passwordValidation == other.passwordValidation &&
        signUpSuccessfully == other.signUpSuccessfully &&
        uploadPhotoSuccessfully == other.uploadPhotoSuccessfully &&
        isEmailAvailable == other.isEmailAvailable &&
        signUpError == other.signUpError;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc($jc(0, signingUp.hashCode),
                                signUpValidation.hashCode),
                            emailValidation.hashCode),
                        passwordValidation.hashCode),
                    signUpSuccessfully.hashCode),
                uploadPhotoSuccessfully.hashCode),
            isEmailAvailable.hashCode),
        signUpError.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SignUpState')
          ..add('signingUp', signingUp)
          ..add('signUpValidation', signUpValidation)
          ..add('emailValidation', emailValidation)
          ..add('passwordValidation', passwordValidation)
          ..add('signUpSuccessfully', signUpSuccessfully)
          ..add('uploadPhotoSuccessfully', uploadPhotoSuccessfully)
          ..add('isEmailAvailable', isEmailAvailable)
          ..add('signUpError', signUpError))
        .toString();
  }
}

class SignUpStateBuilder implements Builder<SignUpState, SignUpStateBuilder> {
  _$SignUpState? _$v;

  bool? _signingUp;
  bool? get signingUp => _$this._signingUp;
  set signingUp(bool? signingUp) => _$this._signingUp = signingUp;

  bool? _signUpValidation;
  bool? get signUpValidation => _$this._signUpValidation;
  set signUpValidation(bool? signUpValidation) =>
      _$this._signUpValidation = signUpValidation;

  bool? _emailValidation;
  bool? get emailValidation => _$this._emailValidation;
  set emailValidation(bool? emailValidation) =>
      _$this._emailValidation = emailValidation;

  bool? _passwordValidation;
  bool? get passwordValidation => _$this._passwordValidation;
  set passwordValidation(bool? passwordValidation) =>
      _$this._passwordValidation = passwordValidation;

  bool? _signUpSuccessfully;
  bool? get signUpSuccessfully => _$this._signUpSuccessfully;
  set signUpSuccessfully(bool? signUpSuccessfully) =>
      _$this._signUpSuccessfully = signUpSuccessfully;

  bool? _uploadPhotoSuccessfully;
  bool? get uploadPhotoSuccessfully => _$this._uploadPhotoSuccessfully;
  set uploadPhotoSuccessfully(bool? uploadPhotoSuccessfully) =>
      _$this._uploadPhotoSuccessfully = uploadPhotoSuccessfully;

  bool? _isEmailAvailable;
  bool? get isEmailAvailable => _$this._isEmailAvailable;
  set isEmailAvailable(bool? isEmailAvailable) =>
      _$this._isEmailAvailable = isEmailAvailable;

  int? _signUpError;
  int? get signUpError => _$this._signUpError;
  set signUpError(int? signUpError) => _$this._signUpError = signUpError;

  SignUpStateBuilder();

  SignUpStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signingUp = $v.signingUp;
      _signUpValidation = $v.signUpValidation;
      _emailValidation = $v.emailValidation;
      _passwordValidation = $v.passwordValidation;
      _signUpSuccessfully = $v.signUpSuccessfully;
      _uploadPhotoSuccessfully = $v.uploadPhotoSuccessfully;
      _isEmailAvailable = $v.isEmailAvailable;
      _signUpError = $v.signUpError;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignUpState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SignUpState;
  }

  @override
  void update(void Function(SignUpStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SignUpState build() {
    final _$result = _$v ??
        new _$SignUpState._(
            signingUp: BuiltValueNullFieldError.checkNotNull(
                signingUp, 'SignUpState', 'signingUp'),
            signUpValidation: BuiltValueNullFieldError.checkNotNull(
                signUpValidation, 'SignUpState', 'signUpValidation'),
            emailValidation: BuiltValueNullFieldError.checkNotNull(
                emailValidation, 'SignUpState', 'emailValidation'),
            passwordValidation: BuiltValueNullFieldError.checkNotNull(
                passwordValidation, 'SignUpState', 'passwordValidation'),
            signUpSuccessfully: BuiltValueNullFieldError.checkNotNull(
                signUpSuccessfully, 'SignUpState', 'signUpSuccessfully'),
            uploadPhotoSuccessfully: BuiltValueNullFieldError.checkNotNull(
                uploadPhotoSuccessfully,
                'SignUpState',
                'uploadPhotoSuccessfully'),
            isEmailAvailable: isEmailAvailable,
            signUpError: BuiltValueNullFieldError.checkNotNull(
                signUpError, 'SignUpState', 'signUpError'));
    replace(_$result);
    return _$result;
  }
}

class _$LocationState extends LocationState {
  @override
  final bool acquiringLocation;
  @override
  final bool errorGettingLocation;
  @override
  final bool locationAcquiredSuccessfully;

  factory _$LocationState([void Function(LocationStateBuilder)? updates]) =>
      (new LocationStateBuilder()..update(updates)).build();

  _$LocationState._(
      {required this.acquiringLocation,
      required this.errorGettingLocation,
      required this.locationAcquiredSuccessfully})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        acquiringLocation, 'LocationState', 'acquiringLocation');
    BuiltValueNullFieldError.checkNotNull(
        errorGettingLocation, 'LocationState', 'errorGettingLocation');
    BuiltValueNullFieldError.checkNotNull(locationAcquiredSuccessfully,
        'LocationState', 'locationAcquiredSuccessfully');
  }

  @override
  LocationState rebuild(void Function(LocationStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LocationStateBuilder toBuilder() => new LocationStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LocationState &&
        acquiringLocation == other.acquiringLocation &&
        errorGettingLocation == other.errorGettingLocation &&
        locationAcquiredSuccessfully == other.locationAcquiredSuccessfully;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, acquiringLocation.hashCode), errorGettingLocation.hashCode),
        locationAcquiredSuccessfully.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LocationState')
          ..add('acquiringLocation', acquiringLocation)
          ..add('errorGettingLocation', errorGettingLocation)
          ..add('locationAcquiredSuccessfully', locationAcquiredSuccessfully))
        .toString();
  }
}

class LocationStateBuilder
    implements Builder<LocationState, LocationStateBuilder> {
  _$LocationState? _$v;

  bool? _acquiringLocation;
  bool? get acquiringLocation => _$this._acquiringLocation;
  set acquiringLocation(bool? acquiringLocation) =>
      _$this._acquiringLocation = acquiringLocation;

  bool? _errorGettingLocation;
  bool? get errorGettingLocation => _$this._errorGettingLocation;
  set errorGettingLocation(bool? errorGettingLocation) =>
      _$this._errorGettingLocation = errorGettingLocation;

  bool? _locationAcquiredSuccessfully;
  bool? get locationAcquiredSuccessfully =>
      _$this._locationAcquiredSuccessfully;
  set locationAcquiredSuccessfully(bool? locationAcquiredSuccessfully) =>
      _$this._locationAcquiredSuccessfully = locationAcquiredSuccessfully;

  LocationStateBuilder();

  LocationStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _acquiringLocation = $v.acquiringLocation;
      _errorGettingLocation = $v.errorGettingLocation;
      _locationAcquiredSuccessfully = $v.locationAcquiredSuccessfully;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LocationState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$LocationState;
  }

  @override
  void update(void Function(LocationStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LocationState build() {
    final _$result = _$v ??
        new _$LocationState._(
            acquiringLocation: BuiltValueNullFieldError.checkNotNull(
                acquiringLocation, 'LocationState', 'acquiringLocation'),
            errorGettingLocation: BuiltValueNullFieldError.checkNotNull(
                errorGettingLocation, 'LocationState', 'errorGettingLocation'),
            locationAcquiredSuccessfully: BuiltValueNullFieldError.checkNotNull(
                locationAcquiredSuccessfully,
                'LocationState',
                'locationAcquiredSuccessfully'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
