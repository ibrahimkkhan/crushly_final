import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/DB/AppDB.dart';
import 'package:crushly/models/country.dart';
import 'package:crushly/models/country_names.dart';
import 'package:crushly/models/recommendation.dart';
import 'package:crushly/utils/constants.dart';
import './bloc.dart';

class LandingBloc extends Bloc<LandingEvent, LandingState> {
//  final previews = [
//    UserPreview((b) => b
//      ..id = 1
//      ..image =
//          'https://images.pexels.com/photos/1082962/pexels-photo-1082962.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
//      ..name = 'Ray Akira'
//      ..address = 'Bijin, China'
//      ..isCrush = false
//      ..isSecretCrush = false
//      ..crushyCount = 50
//      ..secretCrushyCount = 123
//      ..schoolName = 'Massachusetts Institute of Technology'
//      ..bio =
//          'I\'m Passionate about Photography & Travelling.\nI love to explore different cities, places,cultures. I never get tired of travelling. I like to capture the world with my camera.'
//      ..languages = 'English, Arabic'
//      ..originallySecret = false
//      ..presentlySecret = false),
//    UserPreview((b) => b
//      ..id = 2
//      ..image =
//          'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
//      ..name = 'Chase Schnider'
//      ..address = 'Toledo, Ohio'
//      ..isSecretCrush = false
//      ..isCrush = false
//      ..crushyCount = 100
//      ..secretCrushyCount = 531
//      ..schoolName = 'Delta Sigma Pi'
//      ..bio =
//          'I\'m Passionate about Photography & Travelling.\nI love to explore different cities, places,cultures. I never get tired of travelling. I like to capture the world with my camera.'
//      ..languages = 'English, French'
//      ..originallySecret = true
//      ..presentlySecret = false),
//    UserPreview((b) => b
//      ..id = 3
//      ..image =
//          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
//      ..name = 'Ayham Orfali'
//      ..address = 'Damascus, Syria'
//      ..isCrush = false
//      ..isSecretCrush = false
//      ..crushyCount = 30
//      ..secretCrushyCount = 15
//      ..schoolName = 'Delta Sigma Pi'
//      ..bio =
//          'I\'m Passionate about Photography & Travelling.\nI love to explore different cities, places,cultures. I never get tired of travelling. I like to capture the world with my camera.'
//      ..languages = 'English, French'
//      ..originallySecret = false
//      ..presentlySecret = true),
//    UserPreview((b) => b
//      ..id = 4
//      ..image =
//          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
//      ..name = 'Test user'
//      ..address = 'Damascus, Syria'
//      ..isCrush = false
//      ..isSecretCrush = false
//      ..crushyCount = 30
//      ..secretCrushyCount = 15
//      ..schoolName = 'Delta Sigma Pi'
//      ..bio =
//          'I\'m Passionate about Photography & Travelling.\nI love to explore different cities, places,cultures. I never get tired of travelling. I like to capture the world with my camera.'
//      ..languages = 'English, French'
//      ..originallySecret = true
//      ..presentlySecret = true),
//  ];

  final AppDataBase appDataBase;

  LandingBloc({this.appDataBase});

  @override
  LandingState get initialState => LandingState.initial();

  @override
  Stream<LandingState> mapEventToState(LandingEvent event) async* {
//    print('event is $event');
    if (event is GetCountries) {
      yield LandingState.countriesLoaded(state, _getListOfCountries());
    } else if (event is GetFilteredCountries) {
      print('event is ${event.ids}');
      List<Country> countries = [];
      for (Country country in _getListOfCountries()) {
        if (event.ids.contains(country.id)) {
          country.isSelected = true;
        }
        countries.add(country);
      }
      yield LandingState.countriesAfterFilterLoaded(state, countries);
    } else if (event is ChangeSelectedAnonymousName) {
      yield LandingState.changeSelectedAnonymousName(state, event.name);
    } else if (event is SecretCrushUser) {
      yield LandingState.secretCrushUser(
          state, event.otherId, event.followResponse);
    } else if (event is CrushUser) {
      print('mapEventToState => CrushUser before yield');
      yield LandingState.crushUser(state, event.otherId, event.followResponse);
      print('mapEventToState => CrushUser after yield');
    } else if (event is ResetOpenAfterFilter) {
      yield LandingState.resetCountriesAfterFilter(state);
    } else if (event is GetRecommendations) {
      yield* mapGetRecommendations(event);
    } else if (event is GetProfileStatus) {
      yield* mapGetProfileStatus(event);
    } else if (event is GetOtherPreview) {
      yield* mapGetOtherPreview(event);
    } else if (event is GetQueueResult) yield* mapGetQueueResult(event);
  }

  Stream<LandingState> mapGetQueueResult(GetQueueResult event) async* {
//    if (appDataBase != null) {
//      final unreadMessages = await appDataBase.isThereAnyUnreadMessages();
//      final unseenNotifications =
//          await appDataBase.isThereAnyUnseenNotifications();
//      yield LandingState.setQueuesResult(
//          state, unseenNotifications, unreadMessages);
//    }
  }

  Stream<LandingState> mapGetRecommendations(GetRecommendations event) async* {
    try {
      yield LandingState.loading(state);
      print('LandingBloc => mapGetRecommendations => loading..');
      final response = await Api.apiClient.getRecommendations();
      print(
          'LandingBloc => mapGetRecommendations => loaded successfully. length = ${response.length}');
      yield LandingState.recommendationsLoaded(state, response);
    } catch (e) {
      yield LandingState.errorLoadingRecommendations(state, ERROR_GETTING_DATA);
      print('LandingBloc => mapGetRecommendations => ERROR = $e');
    }
  }

  Stream<LandingState> mapGetProfileStatus(GetProfileStatus event) async* {
    try {
      yield LandingState.loading(state);
      print('LandingBloc => mapGetProfileStatus => loading..');
      final response = await Api.apiClient.getProfileStatus();
      print('LandingBloc => mapGetProfileStatus => loaded successfully.');
      yield LandingState.profileStatusLoaded(state, response);
    } catch (e) {
      print('LandingBloc => mapGetProfileStatus => ERROR = $e');
    }
  }

  Stream<LandingState> mapGetOtherPreview(GetOtherPreview event) async* {
    try {
      yield LandingState.loadingOtherUserPreview(state);
      print('LandingBloc => mapGetOtherPreview => loading..');
      final response = await Api.apiClient.getUserPreview(event.otherUserId);
      print(
          'LandingBloc => mapGetOtherPreview => loaded successfully. preview = $response');
      yield LandingState.finishLoadingOtherUserPreview(
          state, response, true, NO_ERROR);
    } catch (e) {
      print('LandingBloc => mapGetOtherPreview => ERROR = $e');
      yield LandingState.finishLoadingOtherUserPreview(
          state, null, false, ERROR_GETTING_DATA);
    }
  }

  List<Country> _getListOfCountries() {
    return [
      Country(
        isSelected: false,
        image: 'assets/flags/China.png',
        id: 1,
        relatedNames: [
          RelatedNames(name: 'Yu Yan1'),
          RelatedNames(name: 'Yu Yan2'),
        ],
      ),
      Country(
        image: 'assets/flags/USA.png',
        isSelected: false,
        id: 2,
        relatedNames: [
          RelatedNames(name: 'Christopher Thomas1'),
          RelatedNames(name: 'Christopher Thomas2'),
          RelatedNames(name: 'Christopher Thomas3'),
        ],
      ),
    ];
  }
}
//
//class UserPreview {
//  final int id;
//  final String image;
//  final String name;
//  final int crushyCount;
//  final int secretCrushyCount;
//  bool isCrush;
//  bool isSecretCrush;
//  final String schoolName;
//
//  final String address;
//  final String bio;
//  final String languages;
//
//  UserPreview(
//    this.id,
//    this.image,
//    this.name,
//    this.address,
//    this.isCrush,
//    this.isSecretCrush,
//    this.crushyCount,
//    this.secretCrushyCount,
//    this.schoolName,
//    this.bio,
//    this.languages,
//  );
//
//  @override
//  String toString() {
//    return '$isCrush, $isSecretCrush\t ';
//  }
//}
