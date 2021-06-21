import 'package:crushly/models/country_names.dart';
import 'package:crushly/models/follow_response.dart';
import 'package:crushly/models/recommendation.dart';
import 'package:crushly/models/user_preview.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LandingEvent {}

class GetCountries extends LandingEvent {}

class ResetOpenAfterFilter extends LandingEvent {}

class GetRecommendations extends LandingEvent {}

class GetProfileStatus extends LandingEvent {}

class CrushUser extends LandingEvent {
  final FollowResponse followResponse;
  final String otherId;

  CrushUser(this.otherId, this.followResponse);
}

class SecretCrushUser extends LandingEvent {
  final FollowResponse followResponse;
  final String otherId;

  SecretCrushUser(this.otherId, this.followResponse);
}

class ChangeSelectedAnonymousName extends LandingEvent {
  final RelatedNames name;

  ChangeSelectedAnonymousName(this.name);
}

class GetFilteredCountries extends LandingEvent {
  final List<int> ids;

  GetFilteredCountries(this.ids);
}

class GetOtherPreview extends LandingEvent {
  final String otherUserId;

  GetOtherPreview(this.otherUserId);
}

class GetQueueResult extends LandingEvent {}
//
//class SetCrush extends LandingEvent {
//  final bool isDate;
//  final bool isSecret;
//  final String otherId;
//
//  SetCrush(this.isDate, this.isSecret, this.otherId);
//}