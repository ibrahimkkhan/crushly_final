import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import 'package:crushly/models/User.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class InlistsearchBloc extends Bloc<InlistsearchEvent, InlistsearchState> {
  bool _hasReachedMax(InlistsearchState state) {
    return state is SearchResult && state.hasReachedMax;
  }

  @override
  Stream<InlistsearchState> transformEvents(Stream<InlistsearchEvent> events,
      Stream<InlistsearchState> Function(InlistsearchEvent event) next) {
    return super.transformEvents(
        (events as Observable<InlistsearchEvent>).debounceTime(
          Duration(milliseconds: 400),
        ),
        next);
  }

  @override
  InlistsearchState get initialState => InitialInlistsearchState();
  String myId;
  int page = 1;
  @override
  Stream<InlistsearchState> mapEventToState(
    InlistsearchEvent event,
  ) async* {
    if (event is Search) {
      if ((this.state is SearchResult)) {
        if ((this.state as SearchResult).query != event.query) {
          page = 1;

          print("in search  same query $page");
          List<User> result;
          await Api.apiClient
              .inListSearch(event.listNum, page, event.query)
              .then((onValue) {
            result = onValue;
          }).catchError((onError) {});
          if (result != null) {
            page++;
            yield SearchResult(
                result, result.isEmpty || result.length < 9, event.query);
          } else {
            yield ErrorState();
          }
        }
      } else {
        if (myId == null) {
          await SharedPref.pref.getUser().then((onValue) {
            myId = onValue.id;
          });
        }
         page = 1;
        print("in search not same query $page");
        List<User> result;
        await Api.apiClient
            .inListSearch(event.listNum, page, event.query)
            .then((onValue) {
          result = onValue;
        }).catchError((onError) {});
        if (result != null) {
          page++;
          print(page);
          yield SearchResult(
              result, result.isEmpty || result.length < 9, event.query);
        } else {
          yield ErrorState();
        }
      }
    }
    if (event is MoreSearch && !_hasReachedMax(state)) {
      List<User> result;
      print("more search  $page");
      await Api.apiClient
          .inListSearch(event.listNum, page, event.query)
          .then((onValue) {
        result = onValue;
      }).catchError((onError) {});
      if (result != null) {
        page++;
        yield SearchResult((this.state as SearchResult).result + result,
            result.isEmpty || result.length < 9, event.query);
      } else {
        yield ErrorState();
      }
    }
  }
}
