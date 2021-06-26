import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import 'package:crushly/models/Ring.dart';
import 'package:crushly/models/User.dart';
import './bloc.dart';

class RingBloc extends Bloc<RingEvent, RingState> {
  @override
  RingState get initialState => InitialRingState();
  String userID;
  @override
  Stream<RingState> mapEventToState(
    RingEvent event,
  ) async* {
    if (event is GetRingInfo) {
      yield Loading();
      userID = event.ownerId; //depend on this
      Ring ring;
      String error;
      await Api.apiClient.getRing(event.ownerId).then((onValue) {
        ring = onValue;
      }).catchError((onError) {
        error = onError.toString();
      });
      if (ring != null) {
        print(ring.offeredTo);
        if (ring.isWithOwner) {
          yield RingWithOwner(ring.offeredTo, ring.id);
        } else {
          yield RingNotWithOwner(ring.currentHolder, ring.id);
        }
      } else {
        yield ErrorState(error);
      }
    }
    if (event is UpdateRingInfo) {
      Ring ring;
      String error;
      await Api.apiClient.getRing(event.ownerId).then((onValue) {
        ring = onValue;
      }).catchError((onError) {
        error = onError.toString();
      });
      if (ring != null) {
        if (ring.isWithOwner) {
          yield RingWithOwner(ring.offeredTo, ring.id);
        } else {
          yield RingNotWithOwner(ring.currentHolder, ring.id);
        }
      } else {
        yield ErrorState(error);
      }
    }
    if (event is AskBackRing) {
     
      final bool result =
          await Api.apiClient.askBackRing(userID, event.recieverId);
      if (result==null) {
        yield ErrorState("somthing happened .. try again");
      }
      this.add(UpdateRingInfo(userID));
    }
    if (event is ReturnRing) {
      await SharedPref.pref.getUser().then((user) {
        userID = user.id;
      });

      final result = await Api.apiClient
          .returnRing(userID /*this the reciverID */, event.ringId);
      if (result==null) {
        yield ErrorState("somthing happened .. try again");
      }
      this.add(UpdateRingInfo(userID));
    }
    if (event is CancelOffer) {
      final bool result =
          await Api.apiClient.cancelOffer(event.ownerId, event.recieverId);
      if (!result) {
        yield ErrorState("somthing happened .. try again");
      }
      this.add(UpdateRingInfo(userID));
    }

    if (event is GetHolOffRings) {
      yield Loading();

      await SharedPref.pref.getUser().then((user) {
        userID = user.id;
      });

     User user;
      String error;
      await Api.apiClient.fetchUser(userID).then((onValue) {
        user = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (user != null) {
        yield HolOffRingsReady(
          user.ringsHolding,
          user.ringsOffered,
        );
      } else {
        yield ErrorState(error);
      }
    }
    if (event is UpdateHolOffRings) {
      User user;
      String error;
      await Api.apiClient.fetchUser(userID).then((onValue) {
        user = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (user != null) {
        yield HolOffRingsReady(
          user.ringsHolding,
          user.ringsOffered,
        );
      } else {
        yield ErrorState(error);
      }
    }
    if (event is AcceptOffer) {
      bool result;
      String error;
      await Api.apiClient
          .acceptRing(userID, event.ringId, event.isAccept)
          .then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
        result = false;
      });
      if (result) {
        this.add(UpdateHolOffRings());
      } else {
        print(error ?? "no error null");
        yield ErrorAccorrd(error);
        this.add(UpdateHolOffRings());
      }
    }
  }
}
