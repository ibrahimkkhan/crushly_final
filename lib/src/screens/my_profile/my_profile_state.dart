library my_profile_state;

import 'package:built_value/built_value.dart';
import '../../models/User.dart';

part 'my_profile_state.g.dart';

abstract class MyProfileState
    implements Built<MyProfileState, MyProfileStateBuilder> {
  @nullable
  User get user;

  bool get isEditing;

  bool get isLoading;

  bool get errorLoading;

  MyProfileState._();

  factory MyProfileState([updates(MyProfileStateBuilder b)]) = _$MyProfileState;

  factory MyProfileState.initial() {
    return MyProfileState((b) => b
      ..isEditing = false
      ..isLoading = true
      ..errorLoading = false);
  }

  factory MyProfileState.profileLoaded(MyProfileState currentState, User user) {
    return currentState.rebuild((b) => b
      ..isLoading = false
      ..isEditing = false
      ..user = user);
  }

  factory MyProfileState.editingProfile(MyProfileState currentState) {
    return currentState.rebuild((b) => b..isEditing = !b.isEditing);
  }

  factory MyProfileState.loadingMyProfile(MyProfileState currentState) {
    return currentState.rebuild((b) => b
      ..isLoading = true
      ..errorLoading = false);
  }

  factory MyProfileState.errorLoadingProfile(MyProfileState currentState) {
    return currentState.rebuild((b) => b..isLoading = false ..errorLoading = true);
  }
}
