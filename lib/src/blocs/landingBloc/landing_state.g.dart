// GENERATED CODE - DO NOT MODIFY BY HAND

part of landing_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$LandingState extends LandingState {
  @override
  final RelatedNames selectedName;
  @override
  final int selectedCountryID;
  @override
  final List<Country> countries;
  @override
  final BuiltList<Recommendation> recommendationList;
  @override
  final ProfileStatus profileStatus;
  @override
  final bool openListOfSecretCrushNames;
  @override
  final bool isLoading;
  @override
  final int getUserPreviewError;
  @override
  final UserPreview otherPreview;
  @override
  final bool isLoadingOtherPreview;
  @override
  final bool otherPreviewLoadedSuccessfully;
  @override
  final int errorGettingRecommendations;
  @override
  final bool unseenNotifications;
  @override
  final bool unreadMessages;

  factory _$LandingState([void Function(LandingStateBuilder) updates]) =>
      (new LandingStateBuilder()..update(updates)).build();

  _$LandingState._(
      {this.selectedName,
      this.selectedCountryID,
      this.countries,
      this.recommendationList,
      this.profileStatus,
      this.openListOfSecretCrushNames,
      this.isLoading,
      this.getUserPreviewError,
      this.otherPreview,
      this.isLoadingOtherPreview,
      this.otherPreviewLoadedSuccessfully,
      this.errorGettingRecommendations,
      this.unseenNotifications,
      this.unreadMessages})
      : super._() {
    if (countries == null) {
      throw new BuiltValueNullFieldError('LandingState', 'countries');
    }
    if (recommendationList == null) {
      throw new BuiltValueNullFieldError('LandingState', 'recommendationList');
    }
    if (openListOfSecretCrushNames == null) {
      throw new BuiltValueNullFieldError(
          'LandingState', 'openListOfSecretCrushNames');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('LandingState', 'isLoading');
    }
    if (getUserPreviewError == null) {
      throw new BuiltValueNullFieldError('LandingState', 'getUserPreviewError');
    }
    if (isLoadingOtherPreview == null) {
      throw new BuiltValueNullFieldError(
          'LandingState', 'isLoadingOtherPreview');
    }
    if (otherPreviewLoadedSuccessfully == null) {
      throw new BuiltValueNullFieldError(
          'LandingState', 'otherPreviewLoadedSuccessfully');
    }
    if (errorGettingRecommendations == null) {
      throw new BuiltValueNullFieldError(
          'LandingState', 'errorGettingRecommendations');
    }
    if (unseenNotifications == null) {
      throw new BuiltValueNullFieldError('LandingState', 'unseenNotifications');
    }
    if (unreadMessages == null) {
      throw new BuiltValueNullFieldError('LandingState', 'unreadMessages');
    }
  }

  @override
  LandingState rebuild(void Function(LandingStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  LandingStateBuilder toBuilder() => new LandingStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is LandingState &&
        selectedName == other.selectedName &&
        selectedCountryID == other.selectedCountryID &&
        countries == other.countries &&
        recommendationList == other.recommendationList &&
        profileStatus == other.profileStatus &&
        openListOfSecretCrushNames == other.openListOfSecretCrushNames &&
        isLoading == other.isLoading &&
        getUserPreviewError == other.getUserPreviewError &&
        otherPreview == other.otherPreview &&
        isLoadingOtherPreview == other.isLoadingOtherPreview &&
        otherPreviewLoadedSuccessfully ==
            other.otherPreviewLoadedSuccessfully &&
        errorGettingRecommendations == other.errorGettingRecommendations &&
        unseenNotifications == other.unseenNotifications &&
        unreadMessages == other.unreadMessages;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            0,
                                                            selectedName
                                                                .hashCode),
                                                        selectedCountryID
                                                            .hashCode),
                                                    countries.hashCode),
                                                recommendationList.hashCode),
                                            profileStatus.hashCode),
                                        openListOfSecretCrushNames.hashCode),
                                    isLoading.hashCode),
                                getUserPreviewError.hashCode),
                            otherPreview.hashCode),
                        isLoadingOtherPreview.hashCode),
                    otherPreviewLoadedSuccessfully.hashCode),
                errorGettingRecommendations.hashCode),
            unseenNotifications.hashCode),
        unreadMessages.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('LandingState')
          ..add('selectedName', selectedName)
          ..add('selectedCountryID', selectedCountryID)
          ..add('countries', countries)
          ..add('recommendationList', recommendationList)
          ..add('profileStatus', profileStatus)
          ..add('openListOfSecretCrushNames', openListOfSecretCrushNames)
          ..add('isLoading', isLoading)
          ..add('getUserPreviewError', getUserPreviewError)
          ..add('otherPreview', otherPreview)
          ..add('isLoadingOtherPreview', isLoadingOtherPreview)
          ..add(
              'otherPreviewLoadedSuccessfully', otherPreviewLoadedSuccessfully)
          ..add('errorGettingRecommendations', errorGettingRecommendations)
          ..add('unseenNotifications', unseenNotifications)
          ..add('unreadMessages', unreadMessages))
        .toString();
  }
}

class LandingStateBuilder
    implements Builder<LandingState, LandingStateBuilder> {
  _$LandingState _$v;

  RelatedNames _selectedName;
  RelatedNames get selectedName => _$this._selectedName;
  set selectedName(RelatedNames selectedName) =>
      _$this._selectedName = selectedName;

  int _selectedCountryID;
  int get selectedCountryID => _$this._selectedCountryID;
  set selectedCountryID(int selectedCountryID) =>
      _$this._selectedCountryID = selectedCountryID;

  List<Country> _countries;
  List<Country> get countries => _$this._countries;
  set countries(List<Country> countries) => _$this._countries = countries;

  ListBuilder<Recommendation> _recommendationList;
  ListBuilder<Recommendation> get recommendationList =>
      _$this._recommendationList ??= new ListBuilder<Recommendation>();
  set recommendationList(ListBuilder<Recommendation> recommendationList) =>
      _$this._recommendationList = recommendationList;

  ProfileStatus _profileStatus;
  ProfileStatus get profileStatus => _$this._profileStatus;
  set profileStatus(ProfileStatus profileStatus) =>
      _$this._profileStatus = profileStatus;

  bool _openListOfSecretCrushNames;
  bool get openListOfSecretCrushNames => _$this._openListOfSecretCrushNames;
  set openListOfSecretCrushNames(bool openListOfSecretCrushNames) =>
      _$this._openListOfSecretCrushNames = openListOfSecretCrushNames;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  int _getUserPreviewError;
  int get getUserPreviewError => _$this._getUserPreviewError;
  set getUserPreviewError(int getUserPreviewError) =>
      _$this._getUserPreviewError = getUserPreviewError;

  UserPreview _otherPreview;
  UserPreview get otherPreview => _$this._otherPreview;
  set otherPreview(UserPreview otherPreview) =>
      _$this._otherPreview = otherPreview;

  bool _isLoadingOtherPreview;
  bool get isLoadingOtherPreview => _$this._isLoadingOtherPreview;
  set isLoadingOtherPreview(bool isLoadingOtherPreview) =>
      _$this._isLoadingOtherPreview = isLoadingOtherPreview;

  bool _otherPreviewLoadedSuccessfully;
  bool get otherPreviewLoadedSuccessfully =>
      _$this._otherPreviewLoadedSuccessfully;
  set otherPreviewLoadedSuccessfully(bool otherPreviewLoadedSuccessfully) =>
      _$this._otherPreviewLoadedSuccessfully = otherPreviewLoadedSuccessfully;

  int _errorGettingRecommendations;
  int get errorGettingRecommendations => _$this._errorGettingRecommendations;
  set errorGettingRecommendations(int errorGettingRecommendations) =>
      _$this._errorGettingRecommendations = errorGettingRecommendations;

  bool _unseenNotifications;
  bool get unseenNotifications => _$this._unseenNotifications;
  set unseenNotifications(bool unseenNotifications) =>
      _$this._unseenNotifications = unseenNotifications;

  bool _unreadMessages;
  bool get unreadMessages => _$this._unreadMessages;
  set unreadMessages(bool unreadMessages) =>
      _$this._unreadMessages = unreadMessages;

  LandingStateBuilder();

  LandingStateBuilder get _$this {
    if (_$v != null) {
      _selectedName = _$v.selectedName;
      _selectedCountryID = _$v.selectedCountryID;
      _countries = _$v.countries;
      _recommendationList = _$v.recommendationList?.toBuilder();
      _profileStatus = _$v.profileStatus;
      _openListOfSecretCrushNames = _$v.openListOfSecretCrushNames;
      _isLoading = _$v.isLoading;
      _getUserPreviewError = _$v.getUserPreviewError;
      _otherPreview = _$v.otherPreview;
      _isLoadingOtherPreview = _$v.isLoadingOtherPreview;
      _otherPreviewLoadedSuccessfully = _$v.otherPreviewLoadedSuccessfully;
      _errorGettingRecommendations = _$v.errorGettingRecommendations;
      _unseenNotifications = _$v.unseenNotifications;
      _unreadMessages = _$v.unreadMessages;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(LandingState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$LandingState;
  }

  @override
  void update(void Function(LandingStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$LandingState build() {
    _$LandingState _$result;
    try {
      _$result = _$v ??
          new _$LandingState._(
              selectedName: selectedName,
              selectedCountryID: selectedCountryID,
              countries: countries,
              recommendationList: recommendationList.build(),
              profileStatus: profileStatus,
              openListOfSecretCrushNames: openListOfSecretCrushNames,
              isLoading: isLoading,
              getUserPreviewError: getUserPreviewError,
              otherPreview: otherPreview,
              isLoadingOtherPreview: isLoadingOtherPreview,
              otherPreviewLoadedSuccessfully: otherPreviewLoadedSuccessfully,
              errorGettingRecommendations: errorGettingRecommendations,
              unseenNotifications: unseenNotifications,
              unreadMessages: unreadMessages);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'recommendationList';
        recommendationList.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'LandingState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$OtherState extends OtherState {
  @override
  final bool isLoading;
  @override
  final UserPreview userPreview;

  factory _$OtherState([void Function(OtherStateBuilder) updates]) =>
      (new OtherStateBuilder()..update(updates)).build();

  _$OtherState._({this.isLoading, this.userPreview}) : super._() {
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('OtherState', 'isLoading');
    }
    if (userPreview == null) {
      throw new BuiltValueNullFieldError('OtherState', 'userPreview');
    }
  }

  @override
  OtherState rebuild(void Function(OtherStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OtherStateBuilder toBuilder() => new OtherStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OtherState &&
        isLoading == other.isLoading &&
        userPreview == other.userPreview;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, isLoading.hashCode), userPreview.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('OtherState')
          ..add('isLoading', isLoading)
          ..add('userPreview', userPreview))
        .toString();
  }
}

class OtherStateBuilder implements Builder<OtherState, OtherStateBuilder> {
  _$OtherState _$v;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  UserPreview _userPreview;
  UserPreview get userPreview => _$this._userPreview;
  set userPreview(UserPreview userPreview) => _$this._userPreview = userPreview;

  OtherStateBuilder();

  OtherStateBuilder get _$this {
    if (_$v != null) {
      _isLoading = _$v.isLoading;
      _userPreview = _$v.userPreview;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OtherState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$OtherState;
  }

  @override
  void update(void Function(OtherStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$OtherState build() {
    final _$result = _$v ??
        new _$OtherState._(isLoading: isLoading, userPreview: userPreview);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
