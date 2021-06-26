import 'package:crushly/models/User.dart';
import 'package:meta/meta.dart';

@immutable
abstract class InlistsearchState {}

class InitialInlistsearchState extends InlistsearchState {}

class SearchResult extends InlistsearchState {
  final List<User> result;

  final bool hasReachedMax;
  final String query;
  SearchResult(this.result, this.hasReachedMax, this.query) : super();
  SearchResult copyWith(List<User> result, bool hasReachedMax, String query) {
    return SearchResult(result ?? this.result,
        hasReachedMax ?? this.hasReachedMax, query ?? this.query);
  }
}

class ErrorState extends InlistsearchState {}

class Loading extends InlistsearchState {}
