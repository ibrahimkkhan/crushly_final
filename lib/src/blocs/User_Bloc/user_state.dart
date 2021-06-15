import '../../DB/AppDB.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserState {}

class InitialUserState extends UserState {}

class LoadingFetch extends UserState {}

class fetchSuccefully extends UserState {
  final Map<String, dynamic> user;
  fetchSuccefully(this.user);
}

class fetchFailed extends UserState {
  final String error;
  fetchFailed(this.error);
}

class AddUserSuccess extends UserState {
  final Map<String, dynamic> user;
  AddUserSuccess(this.user);
}

class AddUserFailed extends UserState {
  final String error;
  AddUserFailed(this.error);
}

class LoadingFetchOther extends UserState {}

class FetchOtherSuccess extends UserState {
  final Map<String, dynamic> data;
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

class FollowedSuccessfuly extends UserState {
  final bool isDate;
  FollowedSuccessfuly(this.isDate);
}

class ErrorInFollowing extends UserState {
  final String error;
  ErrorInFollowing(this.error);
}

class LoadingFollow extends UserState {}

class NotificationReady extends UserState {
  final List<Notification> notifications;
  NotificationReady(this.notifications);
}
class LoadingNotification extends UserState{}