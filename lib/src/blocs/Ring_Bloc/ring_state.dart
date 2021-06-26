import 'package:crushly/models/RingOffered.dart';
import 'package:crushly/models/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class RingState {}

class InitialRingState extends RingState {}

class RingWithOwner extends RingState {
  final List<User> offeredTo;
  final String ringId;
  RingWithOwner(this.offeredTo, this.ringId);
}

class RingNotWithOwner extends RingState {
  final Map<String, String> currentHolder;
  final String ringId;
  RingNotWithOwner(this.currentHolder, this.ringId);
}

class Loading extends RingState {}

class ErrorState extends RingState {
  final String error;
  ErrorState(this.error);
}

class HolOffRingsReady extends RingState {
  final List<RingOffered> offeredRings;
  final List<RingOffered> holdingRings;
  HolOffRingsReady(this.holdingRings, this.offeredRings);
}

class ErrorAccorrd extends RingState {
  final String error;
  ErrorAccorrd(this.error);
}
