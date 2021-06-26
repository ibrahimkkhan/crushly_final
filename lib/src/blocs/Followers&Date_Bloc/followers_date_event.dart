import 'package:meta/meta.dart';

@immutable
abstract class FollowersDateEvent {}

class GetOpenlyUsers extends FollowersDateEvent {}

class GetSecretlyUsers extends FollowersDateEvent {}

class GetDateUsers extends FollowersDateEvent {}

class GetMoreOpenlyUsers extends FollowersDateEvent {}

class GetMoreSecretlyUsers extends FollowersDateEvent {}

class GetMoreDateUsers extends FollowersDateEvent {}