import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crushly/Api/Api.dart';
import 'package:crushly/SharedPref/SharedPref.dart';
import 'package:crushly/models/User.dart';
import 'package:crushly/models/search_user.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  List<SearchUser> searchResult = List();
  bool hasReachedMax = false;
  String userID;
  String error;
  int page = 1;

  @override
  SearchState get initialState => InitialSearchState();

  @override
  Stream<SearchState> transformEvents(Stream<SearchEvent> events,
          Stream<SearchState> Function(SearchEvent event) next) =>
      super.transformEvents(
          (events as Observable<SearchEvent>)
              .debounceTime(Duration(milliseconds: 400)),
          next);

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is Search)
      yield* mapSearch(event);
    else if (event is MoreSearch && !hasReachedMax) yield* mapMoreSearch(event);
  }

  Stream<SearchState> mapSearch(Search event) async* {
    yield LoadingSearch();
    if (userID == null)
      await SharedPref.pref.getUser().then((user) => userID = user.id);
    page = 1;
    searchResult.clear();
    final result = await Api.apiClient
        .search(event.query, page)
        .catchError((onError) => error = onError);
    if (result != null) {
      page++;
      searchResult.addAll(result);
      hasReachedMax = result.isEmpty || result.length < 9;
      yield SearchResult(
        query: event.query,
        result: searchResult,
      );
    } else
      yield SearchError(error);
  }

  Stream<SearchState> mapMoreSearch(MoreSearch event) async* {
    final result = await Api.apiClient
        .search(event.query, page)
        .catchError((onError) => error = onError);
    if (result != null) {
      page++;
      searchResult.addAll(result);
      hasReachedMax = result.isEmpty || result.length < 9;
      yield SearchResult(
          result: (state as SearchResult).result + result, query: event.query);
    } else
      yield SearchError(error);
  }
}
