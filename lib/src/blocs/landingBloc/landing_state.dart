library landing_state;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:crushly/BLocs/landingBloc/landing_bloc.dart';
import 'package:crushly/models/User.dart';
import 'package:crushly/models/country.dart';
import 'package:crushly/models/country_names.dart';
import 'package:crushly/models/follow_response.dart';
import 'package:crushly/models/recommendation.dart';
import 'package:crushly/models/user_preview.dart';
import 'package:crushly/models/profile_status.dart';
import 'package:crushly/utils/constants.dart';

part 'landing_state.g.dart';

abstract class LandingState
    implements Built<LandingState, LandingStateBuilder> {
  @nullable
  RelatedNames get selectedName;

  @nullable
  int get selectedCountryID;

  List<Country> get countries;

  BuiltList<Recommendation> get recommendationList;

  @nullable
  ProfileStatus get profileStatus;

  bool get openListOfSecretCrushNames;

  bool get isLoading;

//  bool get crushSubmitted;

  /// the following parameters for other user preview
  int get getUserPreviewError;

  @nullable
  UserPreview get otherPreview;

  bool get isLoadingOtherPreview;

  bool get otherPreviewLoadedSuccessfully;

  int get errorGettingRecommendations;

  bool get unseenNotifications;

  bool get unreadMessages;

  LandingState._();

  factory LandingState([updates(LandingStateBuilder b)]) = _$LandingState;

  factory LandingState.initial() {
    return LandingState((b) => b
      ..openListOfSecretCrushNames = false
      ..recommendationList.replace([])
      ..profileStatus = null
      ..isLoading = false
      ..countries = []
//      ..crushSubmitted = false
      ..otherPreview = null
      ..unreadMessages = false
      ..unseenNotifications = false
      ..isLoadingOtherPreview = false
      ..errorGettingRecommendations = NO_ERROR
      ..otherPreviewLoadedSuccessfully = false
      ..getUserPreviewError = NO_ERROR);
  }

  factory LandingState.recommendationsLoaded(
      LandingState state, List<Recommendation> recommendationList) {
    return state.rebuild((b) => b
          ..recommendationList.addAll(recommendationList)
          ..errorGettingRecommendations = NO_ERROR
        // ..isLoading = false
        );
  }

  // For loading profile status
  factory LandingState.profileStatusLoaded(
      LandingState state, ProfileStatus profileStatus) {
    print('PROFILE STATUS --: ${profileStatus.morePhotosRequired}');
    return state.rebuild((b) => b
      ..profileStatus = profileStatus
      ..isLoading = false);
  }

  factory LandingState.secretCrushUser(
      LandingState state, String otherId, FollowResponse followResponse) {
    int index = state.recommendationList.indexWhere((recommendation) {
      return recommendation.id == otherId;
    });

    if (index > -1)
      return state.rebuild((b) => b
        ..recommendationList[index].isSecretCrush = true
        ..recommendationList[index].presentlySecret =
            followResponse.presentlySecret
        ..recommendationList[index].orignallySecret =
            followResponse.originallySecret);
    else
      return state;
  }

  factory LandingState.crushUser(
      LandingState state, String otherId, FollowResponse followResponse) {
    int index = state.recommendationList.indexWhere((recommendation) {
      return recommendation.id == otherId;
    });

    if (index > -1)
      return state.rebuild((b) => b
        ..recommendationList[index].isCrush = true
        ..recommendationList[index].presentlySecret =
            followResponse.presentlySecret
        ..recommendationList[index].orignallySecret =
            followResponse.originallySecret);
    else
      return state;
  }

  factory LandingState.loading(LandingState state) {
    return state.rebuild((b) => b
      ..isLoading = true
      ..errorGettingRecommendations = NO_ERROR);
  }

  factory LandingState.changeSelectedAnonymousName(
      LandingState state, RelatedNames name) {
    return state.rebuild((b) => b..selectedName = name);
  }

  factory LandingState.countriesLoaded(
      LandingState state, List<Country> countries) {
    return state.rebuild((b) => b..countries = countries);
  }

  factory LandingState.resetCountriesAfterFilter(LandingState state) {
    return state.rebuild((b) => b..openListOfSecretCrushNames = false);
  }

  factory LandingState.countriesAfterFilterLoaded(
      LandingState state, List<Country> countries) {
    return state.rebuild((b) => b
      ..countries = countries
      ..openListOfSecretCrushNames = true);
  }

  factory LandingState.loadingOtherUserPreview(LandingState state) {
    return state.rebuild((b) => b..isLoadingOtherPreview = true);
  }

  factory LandingState.finishLoadingOtherUserPreview(
      LandingState state, UserPreview userPreview, bool succeed, int errorNum) {
    return state.rebuild((b) => b
      ..isLoadingOtherPreview = false
      ..otherPreviewLoadedSuccessfully = succeed
      ..getUserPreviewError = errorNum
      ..otherPreview = userPreview);
  }

  factory LandingState.errorLoadingRecommendations(
      LandingState state, int errorNumber) {
    return state.rebuild((b) => b..errorGettingRecommendations = errorNumber);
  }

  factory LandingState.setQueuesResult(
      LandingState state, bool unseenNotifications, bool unreadMessages) {
    return state.rebuild((b) => b
      ..unreadMessages = unreadMessages
      ..unseenNotifications = unseenNotifications);
  }
}

abstract class OtherState implements Built<OtherState, OtherStateBuilder> {
  bool get isLoading;

  UserPreview get userPreview;

  OtherState._();

  factory OtherState([updates(OtherStateBuilder b)]) = _$OtherState;

  factory OtherState.initial() {
    return OtherState((b) => b);
  }
}
