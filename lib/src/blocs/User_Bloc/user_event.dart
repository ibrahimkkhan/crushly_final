import 'package:meta/meta.dart';

@immutable
abstract class UserEvent {}

class FetchUser extends UserEvent {}

class NewUser extends UserEvent {
  final String name;
  NewUser(this.name);
}

class FetchOtherUser extends UserEvent {
  final String myId;
  final String id;
  FetchOtherUser(this.myId, this.id);
}

class UpdateProfile extends UserEvent {}

class UpdateOtherProfile extends UserEvent {
  final String myId;
  final String id;
  UpdateOtherProfile(this.myId, this.id);
}

class GetFollowee extends UserEvent {}

class GetDates extends UserEvent {}
class GetNotification extends UserEvent {}

class Logout extends UserEvent {}

class Follow extends UserEvent {
  final bool isSecret;
  final String otherId;
  final String otherName;
  Follow(this.isSecret, this.otherId,this.otherName);
}
