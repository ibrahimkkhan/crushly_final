import 'package:crushly/models/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class FollowersDateState {}

class InitialFollowersDateState extends FollowersDateState {}

class ResultsReady extends FollowersDateState {
  final List<User> result;

  final bool hasReachedMax;

  ResultsReady(this.result, this.hasReachedMax) : super();

  ResultsReady copyWith(
    List<User> result,
    bool hasReachedMax,
  ) {
    return ResultsReady(
      result ?? this.result,
      hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class StateError extends FollowersDateState {
  final String error;

  StateError(this.error);
}

class Loading extends FollowersDateState {}
