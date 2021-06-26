import 'package:meta/meta.dart';

@immutable
abstract class RingEvent {}

class GetRingInfo extends RingEvent {
  final String ownerId;
  GetRingInfo(this.ownerId);
}

class UpdateRingInfo extends RingEvent {
  final String ownerId;
  UpdateRingInfo(this.ownerId);
}

class AskBackRing extends RingEvent {
  final String recieverId;
  AskBackRing(this.recieverId);
}

class CancelOffer extends RingEvent {
  final String ringId;
  final String ownerId;
  final String recieverId;
  CancelOffer(this.ownerId, this.recieverId, this.ringId);
}

class GetHolOffRings extends RingEvent {}

class UpdateHolOffRings extends RingEvent {}

class AcceptOffer extends RingEvent {
  final String isAccept;
  final String ringId;

  AcceptOffer(this.isAccept, this.ringId);
}

class ReturnRing extends RingEvent {
  
  final String ringId;
  ReturnRing( this.ringId);
}
