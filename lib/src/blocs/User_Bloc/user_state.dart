import '../../db/AppDB.dart';
import '../../models/BaseOtherUser.dart';
import '../../models/User.dart';
import '../../models/follow_response.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingFetch extends UserState {}

class fetchSuccefully extends UserState {
  final User user;

  fetchSuccefully(this.user);
}

class LoadingReveal extends UserState {}

class LoadingBlock extends UserState {}
class LoadingUnBlock extends UserState {}

class RevealIdentitySuccess extends UserState {}
class RevealIdentityError extends UserState {}
class BlockError extends UserState {}

class BlockSuccess extends UserState {}
class UnBlockSuccess extends UserState {}
class UnBlockError extends UserState {}

class fetchFailed extends UserState {
  final String error;

  fetchFailed(this.error);
}

class AddUserSuccess extends UserState {
  final User user;

  AddUserSuccess(this.user);
}

class AddUserFailed extends UserState {
  final String error;

  AddUserFailed(this.error);
}

class LoadingFetchOther extends UserState {}

class FetchOtherSuccess extends UserState {
  final BaseOtherUser data;

  FetchOtherSuccess(this.data);
}

class FetchOtherFailed extends UserState {
  final String error;

  FetchOtherFailed(this.error);
}

class FolloweeReady extends UserState {
  final List<FolloweeUser> followees;

  FolloweeReady(this.followees);
}

class DatesReady extends UserState {
  final List<DateUser> dateList;

  DatesReady(this.dateList);
}

class FollowedSuccessfully extends UserState {
  final FollowResponse followResponse;
  final String otherId;
  final bool isSecret;

  FollowedSuccessfully(this.followResponse, this.otherId, this.isSecret);
}

class ErrorInFollowing extends UserState {
  final String error;

  ErrorInFollowing(this.error);
}

class LoadingFollow extends UserState {
  final bool isSecret;

  LoadingFollow(this.isSecret);
}

class NotificationReady extends UserState {
  final List<Notification> notifications;

  NotificationReady(this.notifications);
}

class LoadingNotification extends UserState {}
