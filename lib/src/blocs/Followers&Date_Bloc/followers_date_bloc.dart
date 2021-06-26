import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import 'package:crushly/models/User.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class FollowersDateBloc extends Bloc<FollowersDateEvent, FollowersDateState> {
  bool _hasReachedMax(FollowersDateState state) {
    return state is ResultsReady && state.hasReachedMax;
  }

  @override
  Stream<FollowersDateState> transformEvents(Stream<FollowersDateEvent> events,
      Stream<FollowersDateState> Function(FollowersDateEvent event) next) {
    return super.transformEvents(
        (events as Observable<FollowersDateEvent>).debounceTime(
          Duration(milliseconds: 400),
        ),
        next);
  }

  @override
  FollowersDateState get initialState => InitialFollowersDateState();
  String myId;
  int page;

  @override
  Stream<FollowersDateState> mapEventToState(
    FollowersDateEvent event,
  ) async* {
    if (event is GetOpenlyUsers) {
      yield Loading();
      page = 1;
      String error;
      List<User> result;
      await SharedPref.pref.getUser().then((user) {
        myId = user.id;
      });
      await Api.apiClient.getMyCrushes(page).then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (result != null) {
        page++;
        yield ResultsReady(result, result.isEmpty || result.length < 9);
      } else {
        yield StateError(error);
      }
    }
    if (event is GetMoreOpenlyUsers && !_hasReachedMax(state)) {
      String error;
      List<User> result;

      await Api.apiClient.getMyCrushes(page).then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (result != null) {
        page++;

        yield ResultsReady((state as ResultsReady).result + result,
            result.isEmpty || result.length < 9);
      } else {
        yield StateError(error);
      }
    }
    if (event is GetSecretlyUsers) {
      yield Loading();
      page = 1;
      String error;
      List<User> result;
      await SharedPref.pref.getUser().then((user) {
        myId = user.id;
      });
      await Api.apiClient.getCrushees(myId, page).then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (result != null) {
        page++;
        yield ResultsReady(result, result.isEmpty || result.length < 9);
      } else {
        yield StateError(error);
      }
    }
    if (event is GetSecretlyUsers && !_hasReachedMax(state)) {
      String error;
      List<User> result;

      await Api.apiClient.getCrushees(myId, page).then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (result != null) {
        page++;
        yield ResultsReady((state as ResultsReady).result + result,
            result.isEmpty || result.length < 9);
      } else {
        yield StateError(error);
      }
    }
    if (event is GetDateUsers) {
      yield Loading();
      page = 1;
      String error;
      List<User> result;
      await SharedPref.pref.getUser().then((user) {
        myId = user.id;
      });
      await Api.apiClient.getDateUsers(page).then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (result != null) {
        page++;
        yield ResultsReady(result, result.isEmpty || result.length < 9);
      } else {
        yield StateError(error);
      }
    }
    if (event is GetMoreDateUsers && !_hasReachedMax(state)) {
      String error;
      List<User> result;

      await Api.apiClient.getDateUsers(page).then((onValue) {
        result = onValue;
      }).catchError((onError) {
        error = onError;
      });
      if (result != null) {
        page++;
        yield ResultsReady((state as ResultsReady).result + result,
            result.isEmpty || result.length < 9);
      } else {
        yield StateError(error);
      }
    }
  }
}
